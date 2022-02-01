class RankModel {
  late String leagueId;
  late String queueType;
  late String tier;
  late String rank;
  late String summonerId;
  late String summonerName;
  late int leaguePoints;
  late int wins;
  late int losses;
  late bool veteran;
  late bool inactive;
  late bool freshBlood;
  late bool hotStreak;

  RankModel(
      {required this.leagueId,
      required this.queueType,
      required this.tier,
      required this.rank,
      required this.summonerId,
      required this.summonerName,
      required this.leaguePoints,
      required this.wins,
      required this.losses,
      required this.veteran,
      required this.inactive,
      required this.freshBlood,
      required this.hotStreak});

  RankModel.fromJson(Map<String, dynamic> json) {
    leagueId = json['leagueId'];
    queueType = json['queueType'];
    tier = json['tier'];
    rank = json['rank'];
    summonerId = json['summonerId'];
    summonerName = json['summonerName'];
    leaguePoints = json['leaguePoints'];
    wins = json['wins'];
    losses = json['losses'];
    veteran = json['veteran'];
    inactive = json['inactive'];
    freshBlood = json['freshBlood'];
    hotStreak = json['hotStreak'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['leagueId'] = leagueId;
    data['queueType'] = queueType;
    data['tier'] = tier;
    data['rank'] = rank;
    data['summonerId'] = summonerId;
    data['summonerName'] = summonerName;
    data['leaguePoints'] = leaguePoints;
    data['wins'] = wins;
    data['losses'] = losses;
    data['veteran'] = veteran;
    data['inactive'] = inactive;
    data['freshBlood'] = freshBlood;
    data['hotStreak'] = hotStreak;
    return data;
  }
}
