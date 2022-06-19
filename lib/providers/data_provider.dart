import 'package:flutter/material.dart';
import 'package:league_checker/api/summoner_api.dart';
import 'package:league_checker/models/champion_data_model.dart';
import 'package:league_checker/models/champion_mastery_model.dart';
import 'package:league_checker/models/match_data_model.dart';
import 'package:league_checker/models/rank_model.dart';
import 'package:league_checker/models/summoner_model.dart';
import 'package:league_checker/repositories/data_repository.dart';
import 'package:league_checker/utils/checker.dart';
import 'package:league_checker/utils/device.dart';
import 'package:league_checker/utils/indexer.dart';
import 'package:league_checker/utils/local_storage.dart';
import 'package:league_checker/utils/url_builder.dart';
import 'package:league_checker/utils/waiter.dart';

class DataProvider extends ChangeNotifier {
  DataProvider(this.region, this.summonerAPI);

  late SummonerAPI summonerAPI;
  late DataRepository _dataRepository = DataRepository(summonerAPI);

  late Device device;
  late SummonerModel selectedSummonerData;

  bool updatingDevice = false;
  bool showError = false;
  bool showAddSummoner = false;
  bool viewerOpen = false;
  bool isLoadingSummoner = false;

  String region = '';
  String apiVersion = '';
  String errorMessage = '';

  List<SummonerModel> summonerList = [];
  List<ChampionMasteryModel> masteryList = [];
  List<RankModel> rankList = [];
  List<ChampionData> championList = [];
  List myMatchStats = [];
  List<MatchData> matchList = [];
  FocusNode addSummonerKeyboardFocus = FocusNode();
  int recentRequests = 0;

  //Return summoner data from specified summoner name
  getSelectedSummonerData(String summonerName, [argument]) async {
    try {
      isLoadingSummoner = true;
      await selectRegion(region);
      selectedSummonerData = await _dataRepository.getSummonerData(summonerName, [argument]);
      selectedSummonerData.region = region;
      await Future.wait([
        _dataRepository.getChampionMastery(selectedSummonerData.id).then((value) => masteryList = value),
        _dataRepository.getSummonerRank(selectedSummonerData.id).then((value) => rankList = value),
        _dataRepository.getChampionData(championList, apiVersion).then((value) => championList = value),
        _dataRepository.getMatchList(selectedSummonerData).then((value) {
          myMatchStats = value[0];
          matchList = value[1];
        }),
      ]);
      if (masteryList.isNotEmpty) {
        selectedSummonerData.background = getChampionImage(masteryList[0].championId, championList);
      }
      isLoadingSummoner = false;
      notifyListeners();
      return 200;
    } catch (error) {
      isLoadingSummoner = false;
      errorHandler(error);
      return error;
    }
  }

  //Add a favorited summoner to the summoner list and save them in the memory
  addFavoriteSummoner(String summonerName, region) async {
    try {
      var summoner = await _dataRepository.getSummonerData(summonerName);
      championList = await _dataRepository.getChampionData(championList, apiVersion);
      if (!hasFavoriteSummoner(summoner, summonerList)) {
        summoner.region = region;
        List<ChampionMasteryModel> masteries = await _dataRepository.getChampionMastery(summoner.id);
        if (masteries.isNotEmpty) {
          summoner.background = getChampionImage(masteries[0].championId, championList);
        }
        summonerList.add(summoner);
        await LocalStorage.writeEncoded("summoners", summonerList);
        notifyListeners();
        return 200;
      } else {
        setError("Summoner already added.");
      }
    } catch (error) {
      isLoadingSummoner = false;
      errorHandler(error);
      return error;
    }
  }

  addSelectedSummoner(region) async {
    try {
      if (!hasFavoriteSummoner(selectedSummonerData, summonerList)) {
        selectedSummonerData.region = region;
        if (masteryList.isNotEmpty) {
          selectedSummonerData.background = getChampionImage(masteryList[0].championId, championList);
        }
        summonerList.add(selectedSummonerData);
        await LocalStorage.writeEncoded("summoners", summonerList);
        notifyListeners();
        return 200;
      } else {
        setError("Summoner already added.");
      }
    } catch (error) {
      isLoadingSummoner = false;
      errorHandler(error);
      return error;
    }
  }

  //Return any stored summoners in the memory
  updateSummonerList() async {
    var decodedJsonData = await LocalStorage.readDecoded("summoners");
    for (var i = 0; i < decodedJsonData.length; i++) {
      summonerList.add(SummonerModel.fromJson(decodedJsonData[i]));
    }
    await LocalStorage.writeEncoded("summoners", summonerList);
    notifyListeners();
  }

  //Clear summoner list variable and the data stored in the device
  removeSummonerList() async {
    summonerList.clear();
    await LocalStorage.clear("summoners");
    notifyListeners();
  }

  removeSingleSummoner(index) async {
    summonerList.removeAt(index);
    await LocalStorage.clear("summoners");
    updateSummonerList();
  }

  checkApiVersion() async {
    try {
      var devicePatch = await LocalStorage.readString("patch");
      if (devicePatch == null) {
        await updateDevice();
      } else {
        apiVersion = devicePatch;
        notifyListeners();
        var patchList = await summonerAPI.getPatches();
        if (devicePatch != patchList[0]) {
          await updateDevice();
        } else {
          apiVersion = devicePatch;
          notifyListeners();
        }
      }
    } catch (error) {
      errorHandler(error);
    }
  }

  updateDevice() async {
    try {
      updatingDevice = true;
      notifyListeners();
      var patchList = await summonerAPI.getPatches();
      apiVersion = patchList[0];
      await LocalStorage.writeString("patch", apiVersion);
      updatingDevice = false;
      notifyListeners();
    } catch (error) {
      isLoadingSummoner = false;
      errorHandler(error);
    }
  }

  selectRegion(String flag) async {
    await LocalStorage.writeString("region", flag);
    region = flag;
    List<String> regionData = regionIndex(region);
    summonerAPI = SummonerAPI(regionData[0], regionData[1]);
    _dataRepository = DataRepository(summonerAPI);
    notifyListeners();
  }

  setError(error) async {
    if (!showError) {
      showError = true;
      errorMessage = error;
      notifyListeners();
      await wait(4000);
      showError = false;
      notifyListeners();
    }
  }

  clearError() async {
    showError = false;
    notifyListeners();
  }

  activateAddSummonerScreen(value, context) {
    showAddSummoner = value;
    if (value) {
      FocusScope.of(context).requestFocus(addSummonerKeyboardFocus);
    } else {
      FocusScope.of(context).unfocus();
    }
    notifyListeners();
  }

  updateSummoner(String accountId, String region) {
    for (var i = 0; i < summonerList.length; i++) {
      if (summonerList[i].accountId == accountId) {
        summonerList.removeAt(i);
        selectedSummonerData.region = region;
        summonerList.insert(0, selectedSummonerData);
      }
    }
  }

  rateLimiter() async {
    if (recentRequests == 1) {
      while (recentRequests > 0) {
        await wait(25000);
        if (recentRequests == 4) {
          await wait(25000);
          recentRequests = 0;
          break;
        }
        recentRequests--;
      }
    }
  }

  errorHandler(error) {
    if (error == 404) {
      setError("Summoner not found");
    } else if (error == 403) {
      setError("Type in a Summoner");
    } else if (error == 500) {
      setError("Network error");
    } else {
      setError("Unknown error");
    }
  }
}
