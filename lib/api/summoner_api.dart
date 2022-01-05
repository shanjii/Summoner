import 'package:http/http.dart' as http;

String riotToken = "RGAPI-c25fb5bc-2008-4a8c-b193-faa5d6292f7f";

class SummonerAPI {
  Future getSummonerData(summonerName) async {
    var response = await http.get(
      Uri.parse(
        'https://br1.api.riotgames.com/lol/summoner/v4/summoners/by-name/$summonerName',
      ),
      headers: {"X-Riot-Token": riotToken},
    );
    return response;
  }

  Future getChampionMastery(summonerId) async {
    var response = await http.get(
      Uri.parse(
        'https://br1.api.riotgames.com/lol/champion-mastery/v4/champion-masteries/by-summoner/$summonerId',
      ),
      headers: {"X-Riot-Token": riotToken},
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error retrieving champion mastery');
    }
  }

  Future getSummonerRank(summonerId) async {
    var response = await http.get(
      Uri.parse(
        'https://br1.api.riotgames.com/lol/league/v4/entries/by-summoner/$summonerId',
      ),
      headers: {"X-Riot-Token": riotToken},
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error retrieving summoner rank');
    }
  }

  Future getChampionData() async {
    var response = await http.get(
      Uri.parse(
        'http://ddragon.leagueoflegends.com/cdn/11.24.1/data/en_US/champion.json',
      ),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error retrieving champion data');
    }
  }

  Future getMatchData(matchId) async {
    var response = await http.get(
      Uri.parse(
        'https://americas.api.riotgames.com/lol/match/v5/matches/$matchId',
      ),
      headers: {"X-Riot-Token": riotToken},
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error retrieving match data');
    }
  }

  Future getMatchId(puuid) async {
    var response = await http.get(
      Uri.parse(
        'https://americas.api.riotgames.com/lol/match/v5/matches/by-puuid/$puuid/ids?start=0&count=10',
      ),
      headers: {"X-Riot-Token": riotToken},
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error retrieving matches');
    }
  }
}
