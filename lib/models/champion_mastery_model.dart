class ChampionMasteryModel {
  late int championId;
  late int championLevel;
  late int championPoints;
  late int lastPlayTime;
  late int championPointsSinceLastLevel;
  late int championPointsUntilNextLevel;
  late bool chestGranted;
  late int tokensEarned;
  late String summonerId;

  ChampionMasteryModel(
      {required this.championId,
      required this.championLevel,
      required this.championPoints,
      required this.lastPlayTime,
      required this.championPointsSinceLastLevel,
      required this.championPointsUntilNextLevel,
      required this.chestGranted,
      required this.tokensEarned,
      required this.summonerId});

  ChampionMasteryModel.fromJson(Map<String, dynamic> json) {
    championId = json['championId'];
    championLevel = json['championLevel'];
    championPoints = json['championPoints'];
    lastPlayTime = json['lastPlayTime'];
    championPointsSinceLastLevel = json['championPointsSinceLastLevel'];
    championPointsUntilNextLevel = json['championPointsUntilNextLevel'];
    chestGranted = json['chestGranted'];
    tokensEarned = json['tokensEarned'];
    summonerId = json['summonerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['championId'] = championId;
    data['championLevel'] = championLevel;
    data['championPoints'] = championPoints;
    data['lastPlayTime'] = lastPlayTime;
    data['championPointsSinceLastLevel'] = championPointsSinceLastLevel;
    data['championPointsUntilNextLevel'] = championPointsUntilNextLevel;
    data['chestGranted'] = chestGranted;
    data['tokensEarned'] = tokensEarned;
    data['summonerId'] = summonerId;
    return data;
  }
}
