class SummonerModel {
  late String id;
  late String accountId;
  late String puuid;
  late String name;
  late int profileIconId;
  late int revisionDate;
  late int summonerLevel;
  late String region;
  late String background;

  SummonerModel(
      {required this.id,
      required this.accountId,
      required this.puuid,
      required this.name,
      required this.profileIconId,
      required this.revisionDate,
      required this.summonerLevel,
      required this.region,
      required this.background});

  SummonerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['accountId'];
    puuid = json['puuid'];
    name = json['name'];
    profileIconId = json['profileIconId'];
    revisionDate = json['revisionDate'];
    summonerLevel = json['summonerLevel'];
    region = json['region'] ?? "";
    background = json['background'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['accountId'] = accountId;
    data['puuid'] = puuid;
    data['name'] = name;
    data['profileIconId'] = profileIconId;
    data['revisionDate'] = revisionDate;
    data['summonerLevel'] = summonerLevel;
    data['region'] = region;
    data['background'] = background;
    return data;
  }
}
