import 'package:http/http.dart' as http;
import 'package:league_checker/utils/misc.dart';

class SummonerAPI {
  String riotToken = "RGAPI-c25fb5bc-2008-4a8c-b193-faa5d6292f7f";
  String region = "br1";
  String regionType = "americas";

  SummonerAPI(this.region, this.regionType);

  Future getSummonerData(summonerName) async {
    var response = await http.get(
      Uri.parse(
        'https://$region.api.riotgames.com/lol/summoner/v4/summoners/by-name/$summonerName',
      ),
      headers: {"X-Riot-Token": riotToken},
    );
    return response;
  }

  Future getChampionMastery(summonerId) async {
    var response = await http.get(
      Uri.parse(
        'https://$region.api.riotgames.com/lol/champion-mastery/v4/champion-masteries/by-summoner/$summonerId',
      ),
      headers: {"X-Riot-Token": riotToken},
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw 'Error retrieving champion mastery';
    }
  }

  Future getSummonerRank(summonerId) async {
    var response = await http.get(
      Uri.parse(
        'https://$region.api.riotgames.com/lol/league/v4/entries/by-summoner/$summonerId',
      ),
      headers: {"X-Riot-Token": riotToken},
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw 'Error retrieving summoner rank';
    }
  }

  Future getChampionData(patch) async {
    var response = await http.get(
      Uri.parse(
        'http://ddragon.leagueoflegends.com/cdn/$patch/data/en_US/champion.json',
      ),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw 'Error retrieving champion data';
    }
  }

  Future getMatchData(matchId) async {
    var response = await http.get(
      Uri.parse(
        'https://$regionType.api.riotgames.com/lol/match/v5/matches/$matchId',
      ),
      headers: {"X-Riot-Token": riotToken},
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw 'Error retrieving match data';
    }
  }

  Future getMatchId(puuid) async {
    var response = await http.get(
      Uri.parse(
        'https://$regionType.api.riotgames.com/lol/match/v5/matches/by-puuid/$puuid/ids?start=0&count=10',
      ),
      headers: {"X-Riot-Token": riotToken},
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw 'Error retrieving matches';
    }
  }

  Future getCurrentPatch() async {
    var response = await http.get(
      Uri.parse(
        'https://ddragon.leagueoflegends.com/api/versions.json',
      ),
      headers: {"X-Riot-Token": riotToken},
    );
    return response.body;
  }
}
