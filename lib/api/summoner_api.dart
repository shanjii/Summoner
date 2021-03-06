import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:league_checker/api/token.dart';

class SummonerAPI {
  String riotToken = Token.value;
  String region = "br1";
  String regionType = "americas";

  SummonerAPI(this.region, this.regionType);

  Future getselectedSummonerData(summonerName, [argument]) async {
    try {
      if (argument != null) {
        if (argument[0] != null) {
          var cardRegion = argument[0];
          region = cardRegion[0];
          regionType = cardRegion[1];
        }
      }
      var response = await http.get(
        Uri.parse(
          'https://$region.api.riotgames.com/lol/summoner/v4/summoners/by-name/$summonerName',
        ),
        headers: {"X-Riot-Token": riotToken},
      ).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        return convert.jsonDecode(response.body);
      } else {
        throw response.statusCode;
      }
    } catch (error) {
      if (error == 404 || error == 403) {
        rethrow;
      } else {
        throw 500;
      }
    }
  }

  Future getChampionMastery(summonerId) async {
    try {
      var response = await http.get(
        Uri.parse(
          'https://$region.api.riotgames.com/lol/champion-mastery/v4/champion-masteries/by-summoner/$summonerId',
        ),
        headers: {"X-Riot-Token": riotToken},
      ).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        return convert.jsonDecode(response.body);
      } else {
        throw response.statusCode;
      }
    } catch (error) {
      if (error == 404 || error == 403) {
        rethrow;
      } else {
        throw 500;
      }
    }
  }

  Future getSummonerRank(summonerId) async {
    try {
      var response = await http.get(
        Uri.parse(
          'https://$region.api.riotgames.com/lol/league/v4/entries/by-summoner/$summonerId',
        ),
        headers: {"X-Riot-Token": riotToken},
      ).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        return convert.jsonDecode(response.body);
      } else {
        throw response.statusCode;
      }
    } catch (error) {
      if (error == 404 || error == 403) {
        rethrow;
      } else {
        throw 500;
      }
    }
  }

  Future getChampionData(patch) async {
    try {
      var response = await http
          .get(
            Uri.parse(
              'http://ddragon.leagueoflegends.com/cdn/$patch/data/en_US/champion.json',
            ),
          )
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        return convert.jsonDecode(response.body)['data'];
      } else {
        throw response.statusCode;
      }
    } catch (error) {
      if (error == 404 || error == 403) {
        rethrow;
      } else {
        throw 500;
      }
    }
  }

  Future getMatchData(matchId) async {
    try {
      var response = await http.get(
        Uri.parse(
          'https://$regionType.api.riotgames.com/lol/match/v5/matches/$matchId',
        ),
        headers: {"X-Riot-Token": riotToken},
      ).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        return convert.jsonDecode(response.body);
      } else {
        throw response.statusCode;
      }
    } catch (error) {
      if (error == 404 || error == 403) {
        rethrow;
      } else {
        throw 500;
      }
    }
  }

  Future getMatchId(puuid) async {
    try {
      var response = await http.get(
        Uri.parse(
          'https://$regionType.api.riotgames.com/lol/match/v5/matches/by-puuid/$puuid/ids?start=0&count=5',
        ),
        headers: {"X-Riot-Token": riotToken},
      ).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        return convert.jsonDecode(response.body);
      } else {
        throw response.statusCode;
      }
    } catch (error) {
      if (error == 404 || error == 403) {
        rethrow;
      } else {
        throw 500;
      }
    }
  }

  Future getPatches() async {
    try {
      var response = await http.get(
        Uri.parse(
          'https://ddragon.leagueoflegends.com/api/versions.json',
        ),
        headers: {"X-Riot-Token": riotToken},
      ).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        return convert.jsonDecode(response.body);
      } else {
        throw response.statusCode;
      }
    } catch (error) {
      if (error == 404 || error == 403) {
        rethrow;
      } else {
        throw 500;
      }
    }
  }
}
