import 'dart:developer';

import 'package:league_checker/api/summoner_api.dart';
import 'package:league_checker/models/champion_data_model.dart';
import 'package:league_checker/models/champion_mastery_model.dart';
import 'package:league_checker/models/match_data_model.dart';
import 'package:league_checker/models/rank_model.dart';
import 'package:league_checker/models/summoner_model.dart';

class DataRepository {
  DataRepository(this.summonerAPI);
  late SummonerAPI summonerAPI;

  getSummonerData(summonerName, [argument]) async {
    if (argument == null) {
      return SummonerModel.fromJson(await summonerAPI.getselectedSummonerData(summonerName));
    } else {
      return SummonerModel.fromJson(await summonerAPI.getselectedSummonerData(summonerName, argument));
    }
  }

  //Return the top 3 champion masteries from specified summoner ID
  Future getChampionMastery(summonerId) async {
    List<ChampionMasteryModel> masteryList = [];
    var championMasteries = await summonerAPI.getChampionMastery(summonerId);
    for (var i = 0; i < championMasteries.length; i++) {
      masteryList.add(ChampionMasteryModel.fromJson(championMasteries[i]));
      if (i >= 2) {
        break;
      }
    }
    return masteryList;
  }

  //Return all the ranks of the specified summoner ID
  Future getSummonerRank(summonerId) async {
    List<RankModel> rankList = [];
    var summonerRanks = await summonerAPI.getSummonerRank(summonerId);
    if (summonerRanks.isNotEmpty) {
      for (var i = 0; i < summonerRanks.length; i++) {
        if (summonerRanks[i]['queueType'] != "RANKED_TFT_PAIRS") {
          rankList.add(RankModel.fromJson(summonerRanks[i]));
        }
      }
    }
    return rankList;
  }

  //Load all champion data into a list
  Future getChampionData(List<ChampionData> championList, apiVersion) async {
    if (championList.isEmpty) {
      var championData = await summonerAPI.getChampionData(apiVersion);
      championData.values.forEach((value) {
        championList.add(ChampionData.fromJson(value));
      });
    }
    return championList;
  }

  //Return all recent matches from the selected summoner
  Future getMatchList(SummonerModel selectedSummonerData) async {
    List<MatchData> matchList = [];
    List myMatchStats = [];
    List<Future> promises = [];

    var matchIds = await summonerAPI.getMatchId(selectedSummonerData.puuid);
    for (var id in matchIds) {
      promises.add(getMatchData(id).then((value) => matchList.add(value)));
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
          if (participant.puuid == selectedSummonerData.puuid) {
            myMatchStats.add(participant);
          }
        }
      }
      return [myMatchStats, matchList];
    } else {
      return null;
    }
  }

  //Return the match data from specified match ID
  Future getMatchData(id) async {
    var summonerMatches = await summonerAPI.getMatchData(id);
    try {
      return MatchData.fromJson(summonerMatches);
    } catch (error) {
      log("A match had an unknown error");
      return;
    }
  }
}
