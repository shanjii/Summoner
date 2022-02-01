import 'dart:convert' as convert;
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:league_checker/api/summoner_api.dart';
import 'package:league_checker/model/champion_data_model.dart';
import 'package:league_checker/model/champion_mastery_model.dart';
import 'package:league_checker/model/match_data_model.dart';
import 'package:league_checker/model/rank_model.dart';
import 'package:league_checker/model/summoner_model.dart';
import 'package:league_checker/utils/misc.dart';
import 'package:league_checker/utils/waiter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckerRepository extends ChangeNotifier {
  var summonerAPI = SummonerAPI("na1", "americas");
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

  CheckerRepository(this.region, this.summonerAPI);

  //Return summoner data from specified summoner name
  getSummonerData(String summonerName) async {
    try {
      isLoadingSummoner = true;
      var response = await summonerAPI.getSummonerData(summonerName);

      if (response.statusCode == 200) {
        var decodedJsonData = convert.jsonDecode(response.body);
        summonerData = SummonerModel.fromJson(decodedJsonData);
        summonerData.region = region;

        await Future.wait([
          getChampionMastery(summonerData.id),
          getSummonerRank(summonerData.id),
          getChampionData(),
          getMatchList()
        ]);

        summonerData.background = getChampionImage(masteryList[0].championId);
      }

      isLoadingSummoner = false;
      return response.statusCode;
    } catch (error) {
      throw Exception(error);
    }
  }

  //Return the top 3 champion masteries from specified summoner ID
  Future getChampionMastery(summonerId) async {
    masteryList.clear();

    var response = await summonerAPI.getChampionMastery(summonerId);
    var decodedJsonData = convert.jsonDecode(response);

    for (var i = 0; i < decodedJsonData.length; i++) {
      masteryList.add(ChampionMasteryModel.fromJson(decodedJsonData[i]));
      if (i >= 2) {
        break;
      }
    }
  }

  //Return all recent matches from the selected summoner
  Future getMatchList() async {
    matchList.clear();
    myMatchStats.clear();

    var response = await summonerAPI.getMatchId(summonerData.puuid);
    var decodedJsonData = convert.jsonDecode(response);

    List<Future> promises = [];

    for (var id in decodedJsonData) {
      promises.add(getMatchData(id));
    }

    if (promises.isNotEmpty) {
      await Future.wait(promises);
    }

    matchList.sort((b, a) => a.info.gameCreation.compareTo(b.info
        .gameCreation)); //Needed for match order based on most the recent match

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
    var response = await summonerAPI.getMatchData(id);
    var decodedJsonData = convert.jsonDecode(response);
    try {
      matchList.add(MatchData.fromJson(decodedJsonData));
    } catch (error) {
      log("A match had an unknown error");
      return;
    }
  }

  //Return all the ranks of the specified summoner ID
  Future getSummonerRank(summonerId) async {
    rankList.clear();
    var response = await summonerAPI.getSummonerRank(summonerId);
    List decodedJsonData = convert.jsonDecode(response);
    if (decodedJsonData.isNotEmpty) {
      for (var i = 0; i < decodedJsonData.length; i++) {
        if (decodedJsonData[i]['queueType'] != "RANKED_TFT_PAIRS") {
          rankList.add(RankModel.fromJson(decodedJsonData[i]));
        }
      }
    }
  }

  //Load all champion data into a list
  Future getChampionData() async {
    if (championList.isEmpty) {
      var response = await summonerAPI.getChampionData(apiVersion);
      var decodedJsonData = convert.jsonDecode(response)['data'];

      decodedJsonData.values.forEach((value) {
        championList.add(ChampionData.fromJson(value));
      });
    }
  }

  //Add a favorited summoner to the summoner list and save them in the memory
  addFavoriteSummoner(String summonerName) async {
    try {
      List<ChampionMasteryModel> masteryList = [];
      var response = await summonerAPI.getSummonerData(summonerName);
      var summoner = SummonerModel.fromJson(convert.jsonDecode(response.body));
      response = await summonerAPI.getChampionMastery(summoner.id);
      var decodedJsonData = convert.jsonDecode(response);

      if (decodedJsonData.length != 0) {
        masteryList.add(ChampionMasteryModel.fromJson(decodedJsonData[0]));
        await getChampionData();
        summoner.background = getChampionImage(masteryList[0].championId);
      }

      summoner.region = region;
      summonerList.add(summoner);

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('summoners', convert.jsonEncode(summonerList));

      notifyListeners();
      return 200;
    } catch (error) {
      return 400;
    }
  }

  //Return any stored summoners in the memory
  updateSummonerList() async {
    final prefs = await SharedPreferences.getInstance();
    var summonerString = prefs.getString('summoners');
    if (summonerString != null) {
      List decodedJsonData = convert.jsonDecode(summonerString);
      for (var i = 0; i < decodedJsonData.length; i++) {
        summonerList.add(SummonerModel.fromJson(decodedJsonData[i]));
      }
      prefs.setString('summoners', convert.jsonEncode(summonerList));
    }
    notifyListeners();
  }

  //Clear summoner list variable and the data stored in the device
  removeSummonerList() async {
    summonerList.clear();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('summoners');
    notifyListeners();
  }

  //Return any selected background stored in the memory
  updateBackground() async {
    final prefs = await SharedPreferences.getInstance();
    var selectedBackground = prefs.getString('background');
    if (selectedBackground != null) {
      background = selectedBackground;
    }
    notifyListeners();
  }

  //Register the selected background into memory
  selectBackground(background) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('background', background);
    await updateBackground();
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
    final prefs = await SharedPreferences.getInstance();
    var devicePatch = prefs.getString('patch');

    if (devicePatch == null) {
      await updateDevice();
    } else {
      apiVersion = devicePatch;
      notifyListeners();

      var response = await summonerAPI.getCurrentPatch();
      var decodedJsonData = convert.jsonDecode(response);

      if (devicePatch != decodedJsonData[0]) {
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
    final prefs = await SharedPreferences.getInstance();
    var response = await summonerAPI.getCurrentPatch();
    var decodedJsonData = convert.jsonDecode(response);
    apiVersion = decodedJsonData[0];
    prefs.setString('patch', apiVersion);
    updatingDevice = false;
    notifyListeners();
  }

  selectRegion(String flag) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("region", flag);
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
