import 'dart:convert' as convert;
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:league_checker/api/summoner_api.dart';
import 'package:league_checker/model/champion_data_model.dart';
import 'package:league_checker/model/champion_mastery_model.dart';
import 'package:league_checker/model/match_data_model.dart';
import 'package:league_checker/model/rank_model.dart';
import 'package:league_checker/model/summoner_model.dart';
import 'package:league_checker/utils/waiter.dart';
import 'package:shared_preferences/shared_preferences.dart';

var summonerAPI = SummonerAPI();

class CheckerRepository extends ChangeNotifier {

  bool showUserNotFound = false;
  double statusBarHeight = 0;
  double height = 0;
  double width = 0;
  String background = 'rengar';

  List<SummonerModel> summonerList = [];
  List<ChampionMasteryModel> masteryList = [];
  List<RankModel> rankList = [];
  List<ChampionData> championList = [];
  late SummonerModel summonerData;
  List<MatchData> matchList = [];

  getSummonerData(String summonerName) async {
    try {
      var response = await summonerAPI.getSummonerData(summonerName);

      if (response == 403) return 403;
      if (response == 404) return 404;

      var decodedJsonData = convert.jsonDecode(response.body);
      summonerData = SummonerModel.fromJson(decodedJsonData);

      await Future.wait([
        getChampionMastery(summonerData.id),
        getSummonerRank(summonerData.id),
        getChampionData(),
        getMatchList()
      ]);

      return 200;
    } catch (error) {
      throw Exception(error);
    }
  }

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

  Future getMatchList() async {
    matchList.clear();

    var response = await summonerAPI.getMatchId(summonerData.puuid);
    var decodedJsonData = convert.jsonDecode(response);

    List<Future> promises = [];

    for (var id in decodedJsonData) {
      promises.add(getMatchData(id));
    }

    if (promises.isNotEmpty) {
      await Future.wait(promises);
    }
  }

  Future getMatchData(id) async {
    var response = await summonerAPI.getMatchData(id);
    var decodedJsonData = convert.jsonDecode(response);

    matchList.add(MatchData.fromJson(decodedJsonData));
  }

  Future getSummonerRank(summonerId) async {
    rankList.clear();
    var response = await summonerAPI.getSummonerRank(summonerId);
    var decodedJsonData = convert.jsonDecode(response);

    for (var i = 0; i < decodedJsonData.length; i++) {
      rankList.add(RankModel.fromJson(decodedJsonData[i]));
    }
  }

  Future getChampionData() async {
    if (championList.isEmpty) {
      var response = await summonerAPI.getChampionData();
      var decodedJsonData = convert.jsonDecode(response)['data'];

      decodedJsonData.values.forEach((value) {
        championList.add(ChampionData.fromJson(value));
      });
    }
  }

  addFavoriteSummoner(String summonerName) async {
    try {
      var response = await summonerAPI.getSummonerData(summonerName);

      if (response == 403) return 403;
      if (response == 404) return 404;

      var decodedJsonData = convert.jsonDecode(response.body);
      summonerList.add(SummonerModel.fromJson(decodedJsonData));

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('summoners', convert.jsonEncode(summonerList));

      return 200;
    } catch (error) {
      return 400;
    }
  }

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

  removeSummonerList() async {
    summonerList.clear();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('summoners');
    notifyListeners();
  }

  updateBackground() async {
    final prefs = await SharedPreferences.getInstance();
    var selectedBackground = prefs.getString('background');
    if (selectedBackground != null) {
      background = selectedBackground;
    }
    notifyListeners();
  }

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

  showNotFoundMessage() async {
    showUserNotFound = true;
    await wait(3000);
    showUserNotFound = false;
    notifyListeners();
  }
}
