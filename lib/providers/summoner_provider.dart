import 'dart:convert' as convert;
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:league_checker/api/summoner_api.dart';
import 'package:league_checker/models/champion_data_model.dart';
import 'package:league_checker/models/champion_mastery_model.dart';
import 'package:league_checker/models/match_data_model.dart';
import 'package:league_checker/models/rank_model.dart';
import 'package:league_checker/models/summoner_model.dart';
import 'package:league_checker/utils/indexer.dart';
import 'package:league_checker/utils/local_storage.dart';
import 'package:league_checker/utils/misc.dart';

class SummonerProvider extends ChangeNotifier {
  SummonerAPI summonerAPI = SummonerAPI("na1", "americas");
  String region = '';
  String apiVersion = '';
  bool updatingDevice = false;
  bool showUserNotFound = false;
  double statusBarHeight = 0;
  double height = 0;
  double width = 0;
  String background = 'rengar';
  bool isLoadingSummoner = false;
  String errorMessage = 'Summoner not found.';
  List<SummonerModel> summonerList = [];
  List<ChampionMasteryModel> masteryList = [];
  List<RankModel> rankList = [];
  List<ChampionData> championList = [];
  late SummonerModel summonerData;
  List<MatchData> matchList = [];
  List myMatchStats = [];

  SummonerProvider(this.region, this.summonerAPI);

  //Return summoner data from specified summoner name
  getSummonerData(String summonerName, [argument]) async {
    try {
      List<String> regionData = regionIndex(region);
      summonerAPI = SummonerAPI(regionData[0], regionData[1]);
      isLoadingSummoner = true;
      var response =
          await summonerAPI.getSummonerData(summonerName, [argument]);
      summonerData = SummonerModel.fromJson(response);
      summonerData.region = region;
      await Future.wait([
        getChampionMastery(summonerData.id),
        getSummonerRank(summonerData.id),
        getChampionData(),
        getMatchList()
      ]);
      if (masteryList.isNotEmpty) {
        summonerData.background = getChampionImage(masteryList[0].championId);
      }
      isLoadingSummoner = false;
      return 200;
    } catch (error) {
      isLoadingSummoner = false;
      return error;
    }
  }

  //Return the top 3 champion masteries from specified summoner ID
  Future getChampionMastery(summonerId) async {
    masteryList.clear();
    var championMasteries = await summonerAPI.getChampionMastery(summonerId);
    for (var i = 0; i < championMasteries.length; i++) {
      masteryList.add(ChampionMasteryModel.fromJson(championMasteries[i]));
      if (i >= 2) {
        break;
      }
    }
  }

  //Return all recent matches from the selected summoner
  Future getMatchList() async {
    matchList.clear();
    myMatchStats.clear();
    var matchIds = await summonerAPI.getMatchId(summonerData.puuid);
    List<Future> promises = [];
    for (var id in matchIds) {
      promises.add(getMatchData(id));
    }
    if (promises.isNotEmpty) {
      await Future.wait(promises);
    }
    //Needed for match order based on most the recent match
    matchList.sort(
      (b, a) => a.info.gameCreation.compareTo(b.info.gameCreation),
    );
    if (matchList.isNotEmpty) {
      for (var match in matchList) {
        for (var participant in match.info.participants) {
          if (participant.puuid == summonerData.puuid) {
            myMatchStats.add(participant);
          }
        }
      }
    }
  }

  //Return the match data from specified match ID
  Future getMatchData(id) async {
    var summonerMatches = await summonerAPI.getMatchData(id);
    try {
      matchList.add(MatchData.fromJson(summonerMatches));
    } catch (error) {
      log("A match had an unknown error");
      return;
    }
  }

  //Return all the ranks of the specified summoner ID
  Future getSummonerRank(summonerId) async {
    rankList.clear();
    var summonerRanks = await summonerAPI.getSummonerRank(summonerId);
    if (summonerRanks.isNotEmpty) {
      for (var i = 0; i < summonerRanks.length; i++) {
        if (summonerRanks[i]['queueType'] != "RANKED_TFT_PAIRS") {
          rankList.add(RankModel.fromJson(summonerRanks[i]));
        }
      }
    }
  }

  //Load all champion data into a list
  Future getChampionData() async {
    if (championList.isEmpty) {
      var championData = await summonerAPI.getChampionData(apiVersion);
      championData.values.forEach((value) {
        championList.add(ChampionData.fromJson(value));
      });
    }
  }

  //Add a favorited summoner to the summoner list and save them in the memory
  addFavoriteSummoner(String summonerName) async {
    try {
      var summoner = SummonerModel.fromJson(
        await summonerAPI.getSummonerData(summonerName),
      );
      summoner.region = region;
      var masteries = await summonerAPI.getChampionMastery(summoner.id);
      if (masteries.isNotEmpty) {
        await getChampionData();
        summoner.background = getChampionImage(masteries[0]["championId"]);
      }
      summonerList.add(summoner);
      await LocalStorage.writeEncoded("summoners", summonerList);
      notifyListeners();
      return 200;
    } catch (error) {
      return 400;
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

  getDeviceDimensions(context) {
    statusBarHeight = MediaQuery.of(context).padding.top;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
  }

  //Return the champion image url from a champion ID
  getChampionImage(championId) {
    for (var element in championList) {
      if (element.key == championId.toString()) {
        return element.image.full.replaceAll('.png', '');
      }
    }
    return 'Undefined';
  }

  checkApiVersion() async {
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
  }

  updateDevice() async {
    updatingDevice = true;
    notifyListeners();
    var patchList = await summonerAPI.getPatches();
    apiVersion = patchList[0];
    await LocalStorage.writeString("patch", apiVersion);
    updatingDevice = false;
    notifyListeners();
  }

  selectRegion(String flag) async {
    await LocalStorage.writeString("region", flag);
    region = flag;
    List<String> regionData = regionIndex(region);
    summonerAPI = SummonerAPI(regionData[0], regionData[1]);
    notifyListeners();
  }

  setError(error) async {
    showUserNotFound = true;
    errorMessage = error;
    notifyListeners();
    await wait(3000);
    showUserNotFound = false;
    notifyListeners();
  }
}