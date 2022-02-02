class MatchData {
  late Metadata metadata;
  late Info info;

  MatchData({required this.metadata, required this.info});

  MatchData.fromJson(Map<String, dynamic> json) {
    metadata = (json['metadata'] != null
        ? Metadata.fromJson(json['metadata'])
        : null)!;
    info = (json['info'] != null ? Info.fromJson(json['info']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['metadata'] = metadata.toJson();
    data['info'] = info.toJson();
    return data;
  }
}

class Metadata {
  late String dataVersion;
  late String matchId;
  late List<String> participants;

  Metadata(
      {required this.dataVersion,
      required this.matchId,
      required this.participants});

  Metadata.fromJson(Map<String, dynamic> json) {
    dataVersion = json['dataVersion'];
    matchId = json['matchId'];
    participants = json['participants'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dataVersion'] = dataVersion;
    data['matchId'] = matchId;
    data['participants'] = participants;
    return data;
  }
}

class Info {
  late int gameCreation;
  late int gameDuration;
  late int gameId;
  late String gameMode;
  late String gameName;
  late int gameStartTimestamp;
  late String gameType;
  late String gameVersion;
  late int mapId;
  late List<Participants> participants;
  late String platformId;
  late int queueId;
  late List<Teams> teams;
  late String tournamentCode;

  Info(
      {required this.gameCreation,
      required this.gameDuration,
      required this.gameId,
      required this.gameMode,
      required this.gameName,
      required this.gameStartTimestamp,
      required this.gameType,
      required this.gameVersion,
      required this.mapId,
      required this.participants,
      required this.platformId,
      required this.queueId,
      required this.teams,
      required this.tournamentCode});

  Info.fromJson(Map<String, dynamic> json) {
    gameCreation = json['gameCreation'];
    gameDuration = json['gameDuration'];
    gameId = json['gameId'];
    gameMode = json['gameMode'];
    gameName = json['gameName'];
    gameStartTimestamp = json['gameStartTimestamp'];
    gameType = json['gameType'];
    gameVersion = json['gameVersion'];
    mapId = json['mapId'];
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {
        participants.add(Participants.fromJson(v));
      });
    }
    platformId = json['platformId'];
    queueId = json['queueId'];
    if (json['teams'] != null) {
      teams = <Teams>[];
      json['teams'].forEach((v) {
        teams.add(Teams.fromJson(v));
      });
    }
    tournamentCode = json['tournamentCode'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gameCreation'] = gameCreation;
    data['gameDuration'] = gameDuration;
    data['gameId'] = gameId;
    data['gameMode'] = gameMode;
    data['gameName'] = gameName;
    data['gameStartTimestamp'] = gameStartTimestamp;
    data['gameType'] = gameType;
    data['gameVersion'] = gameVersion;
    data['mapId'] = mapId;
    data['participants'] = participants.map((v) => v.toJson()).toList();
    data['platformId'] = platformId;
    data['queueId'] = queueId;
    data['teams'] = teams.map((v) => v.toJson()).toList();
    data['tournamentCode'] = tournamentCode;
    return data;
  }
}

class Participants {
  late int assists;
  late int baronKills;
  late int bountyLevel;
  late int champExperience;
  late int champLevel;
  late int championId;
  late String championName;
  late int championTransform;
  late int consumablesPurchased;
  late int damageDealtToBuildings;
  late int damageDealtToObjectives;
  late int damageDealtToTurrets;
  late int damageSelfMitigated;
  late int deaths;
  late int detectorWardsPlaced;
  late int doubleKills;
  late int dragonKills;
  late bool firstBloodAssist;
  late bool firstBloodKill;
  late bool firstTowerAssist;
  late bool firstTowerKill;
  late bool gameEndedInEarlySurrender;
  late bool gameEndedInSurrender;
  late int goldEarned;
  late int goldSpent;
  late String individualPosition;
  late int inhibitorKills;
  late int inhibitorTakedowns;
  late int inhibitorsLost;
  late int item0;
  late int item1;
  late int item2;
  late int item3;
  late int item4;
  late int item5;
  late int item6;
  late int itemsPurchased;
  late int killingSprees;
  late int kills;
  late String lane;
  late int largestCriticalStrike;
  late int largestKillingSpree;
  late int largestMultiKill;
  late int longestTimeSpentLiving;
  late int magicDamageDealt;
  late int magicDamageDealtToChampions;
  late int magicDamageTaken;
  late int neutralMinionsKilled;
  late int nexusKills;
  late int nexusLost;
  late int nexusTakedowns;
  late int objectivesStolen;
  late int objectivesStolenAssists;
  late int participantId;
  late int pentaKills;
  late Perks perks;
  late int physicalDamageDealt;
  late int physicalDamageDealtToChampions;
  late int physicalDamageTaken;
  late int profileIcon;
  late String puuid;
  late int quadraKills;
  late String riotIdName;
  late String riotIdTagline;
  late String role;
  late int sightWardsBoughtInGame;
  late int spell1Casts;
  late int spell2Casts;
  late int spell3Casts;
  late int spell4Casts;
  late int summoner1Casts;
  late int summoner1Id;
  late int summoner2Casts;
  late int summoner2Id;
  late String summonerId;
  late int summonerLevel;
  late String summonerName;
  late bool teamEarlySurrendered;
  late int teamId;
  late String teamPosition;
  late int timeCCingOthers;
  late int timePlayed;
  late int totalDamageDealt;
  late int totalDamageDealtToChampions;
  late int totalDamageShieldedOnTeammates;
  late int totalDamageTaken;
  late int totalHeal;
  late int totalHealsOnTeammates;
  late int totalMinionsKilled;
  late int totalTimeCCDealt;
  late int totalTimeSpentDead;
  late int totalUnitsHealed;
  late int tripleKills;
  late int trueDamageDealt;
  late int trueDamageDealtToChampions;
  late int trueDamageTaken;
  late int turretKills;
  late int turretTakedowns;
  late int turretsLost;
  late int unrealKills;
  late int visionScore;
  late int visionWardsBoughtInGame;
  late int wardsKilled;
  late int wardsPlaced;
  late bool win;

  Participants(
      {required this.assists,
      required this.baronKills,
      required this.bountyLevel,
      required this.champExperience,
      required this.champLevel,
      required this.championId,
      required this.championName,
      required this.championTransform,
      required this.consumablesPurchased,
      required this.damageDealtToBuildings,
      required this.damageDealtToObjectives,
      required this.damageDealtToTurrets,
      required this.damageSelfMitigated,
      required this.deaths,
      required this.detectorWardsPlaced,
      required this.doubleKills,
      required this.dragonKills,
      required this.firstBloodAssist,
      required this.firstBloodKill,
      required this.firstTowerAssist,
      required this.firstTowerKill,
      required this.gameEndedInEarlySurrender,
      required this.gameEndedInSurrender,
      required this.goldEarned,
      required this.goldSpent,
      required this.individualPosition,
      required this.inhibitorKills,
      required this.inhibitorTakedowns,
      required this.inhibitorsLost,
      required this.item0,
      required this.item1,
      required this.item2,
      required this.item3,
      required this.item4,
      required this.item5,
      required this.item6,
      required this.itemsPurchased,
      required this.killingSprees,
      required this.kills,
      required this.lane,
      required this.largestCriticalStrike,
      required this.largestKillingSpree,
      required this.largestMultiKill,
      required this.longestTimeSpentLiving,
      required this.magicDamageDealt,
      required this.magicDamageDealtToChampions,
      required this.magicDamageTaken,
      required this.neutralMinionsKilled,
      required this.nexusKills,
      required this.nexusLost,
      required this.nexusTakedowns,
      required this.objectivesStolen,
      required this.objectivesStolenAssists,
      required this.participantId,
      required this.pentaKills,
      required this.perks,
      required this.physicalDamageDealt,
      required this.physicalDamageDealtToChampions,
      required this.physicalDamageTaken,
      required this.profileIcon,
      required this.puuid,
      required this.quadraKills,
      required this.riotIdName,
      required this.riotIdTagline,
      required this.role,
      required this.sightWardsBoughtInGame,
      required this.spell1Casts,
      required this.spell2Casts,
      required this.spell3Casts,
      required this.spell4Casts,
      required this.summoner1Casts,
      required this.summoner1Id,
      required this.summoner2Casts,
      required this.summoner2Id,
      required this.summonerId,
      required this.summonerLevel,
      required this.summonerName,
      required this.teamEarlySurrendered,
      required this.teamId,
      required this.teamPosition,
      required this.timeCCingOthers,
      required this.timePlayed,
      required this.totalDamageDealt,
      required this.totalDamageDealtToChampions,
      required this.totalDamageShieldedOnTeammates,
      required this.totalDamageTaken,
      required this.totalHeal,
      required this.totalHealsOnTeammates,
      required this.totalMinionsKilled,
      required this.totalTimeCCDealt,
      required this.totalTimeSpentDead,
      required this.totalUnitsHealed,
      required this.tripleKills,
      required this.trueDamageDealt,
      required this.trueDamageDealtToChampions,
      required this.trueDamageTaken,
      required this.turretKills,
      required this.turretTakedowns,
      required this.turretsLost,
      required this.unrealKills,
      required this.visionScore,
      required this.visionWardsBoughtInGame,
      required this.wardsKilled,
      required this.wardsPlaced,
      required this.win});

  Participants.fromJson(Map<String, dynamic> json) {
    assists = json['assists'];
    baronKills = json['baronKills'];
    bountyLevel = json['bountyLevel'];
    champExperience = json['champExperience'];
    champLevel = json['champLevel'];
    championId = json['championId'];
    championName = json['championName'];
    championTransform = json['championTransform'];
    consumablesPurchased = json['consumablesPurchased'];
    damageDealtToBuildings = json['damageDealtToBuildings'] ?? 0;
    damageDealtToObjectives = json['damageDealtToObjectives'];
    damageDealtToTurrets = json['damageDealtToTurrets'];
    damageSelfMitigated = json['damageSelfMitigated'];
    deaths = json['deaths'];
    detectorWardsPlaced = json['detectorWardsPlaced'];
    doubleKills = json['doubleKills'];
    dragonKills = json['dragonKills'];
    firstBloodAssist = json['firstBloodAssist'];
    firstBloodKill = json['firstBloodKill'];
    firstTowerAssist = json['firstTowerAssist'];
    firstTowerKill = json['firstTowerKill'];
    gameEndedInEarlySurrender = json['gameEndedInEarlySurrender'];
    gameEndedInSurrender = json['gameEndedInSurrender'];
    goldEarned = json['goldEarned'];
    goldSpent = json['goldSpent'];
    individualPosition = json['individualPosition'];
    inhibitorKills = json['inhibitorKills'];
    inhibitorTakedowns = json['inhibitorTakedowns'] ?? 0;
    inhibitorsLost = json['inhibitorsLost'] ?? 0;
    item0 = json['item0'];
    item1 = json['item1'];
    item2 = json['item2'];
    item3 = json['item3'];
    item4 = json['item4'];
    item5 = json['item5'];
    item6 = json['item6'];
    itemsPurchased = json['itemsPurchased'];
    killingSprees = json['killingSprees'];
    kills = json['kills'];
    lane = json['lane'];
    largestCriticalStrike = json['largestCriticalStrike'];
    largestKillingSpree = json['largestKillingSpree'];
    largestMultiKill = json['largestMultiKill'];
    longestTimeSpentLiving = json['longestTimeSpentLiving'];
    magicDamageDealt = json['magicDamageDealt'];
    magicDamageDealtToChampions = json['magicDamageDealtToChampions'];
    magicDamageTaken = json['magicDamageTaken'];
    neutralMinionsKilled = json['neutralMinionsKilled'];
    nexusKills = json['nexusKills'];
    nexusLost = json['nexusLost'] ?? 0;
    nexusTakedowns = json['nexusTakedowns'] ?? 0;
    objectivesStolen = json['objectivesStolen'];
    objectivesStolenAssists = json['objectivesStolenAssists'];
    participantId = json['participantId'];
    pentaKills = json['pentaKills'];
    perks = (json['perks'] != null ? Perks.fromJson(json['perks']) : null)!;
    physicalDamageDealt = json['physicalDamageDealt'];
    physicalDamageDealtToChampions = json['physicalDamageDealtToChampions'];
    physicalDamageTaken = json['physicalDamageTaken'];
    profileIcon = json['profileIcon'];
    puuid = json['puuid'];
    quadraKills = json['quadraKills'];
    riotIdName = json['riotIdName'];
    riotIdTagline = json['riotIdTagline'];
    role = json['role'];
    sightWardsBoughtInGame = json['sightWardsBoughtInGame'];
    spell1Casts = json['spell1Casts'];
    spell2Casts = json['spell2Casts'];
    spell3Casts = json['spell3Casts'];
    spell4Casts = json['spell4Casts'];
    summoner1Casts = json['summoner1Casts'];
    summoner1Id = json['summoner1Id'];
    summoner2Casts = json['summoner2Casts'];
    summoner2Id = json['summoner2Id'];
    summonerId = json['summonerId'];
    summonerLevel = json['summonerLevel'];
    summonerName = json['summonerName'];
    teamEarlySurrendered = json['teamEarlySurrendered'];
    teamId = json['teamId'];
    teamPosition = json['teamPosition'];
    timeCCingOthers = json['timeCCingOthers'];
    timePlayed = json['timePlayed'];
    totalDamageDealt = json['totalDamageDealt'];
    totalDamageDealtToChampions = json['totalDamageDealtToChampions'];
    totalDamageShieldedOnTeammates = json['totalDamageShieldedOnTeammates'];
    totalDamageTaken = json['totalDamageTaken'];
    totalHeal = json['totalHeal'];
    totalHealsOnTeammates = json['totalHealsOnTeammates'];
    totalMinionsKilled = json['totalMinionsKilled'];
    totalTimeCCDealt = json['totalTimeCCDealt'];
    totalTimeSpentDead = json['totalTimeSpentDead'];
    totalUnitsHealed = json['totalUnitsHealed'];
    tripleKills = json['tripleKills'];
    trueDamageDealt = json['trueDamageDealt'];
    trueDamageDealtToChampions = json['trueDamageDealtToChampions'];
    trueDamageTaken = json['trueDamageTaken'];
    turretKills = json['turretKills'];
    turretTakedowns = json['turretTakedowns'] ?? 0;
    turretsLost = json['turretsLost'] ?? 0;
    unrealKills = json['unrealKills'];
    visionScore = json['visionScore'];
    visionWardsBoughtInGame = json['visionWardsBoughtInGame'];
    wardsKilled = json['wardsKilled'];
    wardsPlaced = json['wardsPlaced'];
    win = json['win'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['assists'] = assists;
    data['baronKills'] = baronKills;
    data['bountyLevel'] = bountyLevel;
    data['champExperience'] = champExperience;
    data['champLevel'] = champLevel;
    data['championId'] = championId;
    data['championName'] = championName;
    data['championTransform'] = championTransform;
    data['consumablesPurchased'] = consumablesPurchased;
    data['damageDealtToBuildings'] = damageDealtToBuildings;
    data['damageDealtToObjectives'] = damageDealtToObjectives;
    data['damageDealtToTurrets'] = damageDealtToTurrets;
    data['damageSelfMitigated'] = damageSelfMitigated;
    data['deaths'] = deaths;
    data['detectorWardsPlaced'] = detectorWardsPlaced;
    data['doubleKills'] = doubleKills;
    data['dragonKills'] = dragonKills;
    data['firstBloodAssist'] = firstBloodAssist;
    data['firstBloodKill'] = firstBloodKill;
    data['firstTowerAssist'] = firstTowerAssist;
    data['firstTowerKill'] = firstTowerKill;
    data['gameEndedInEarlySurrender'] = gameEndedInEarlySurrender;
    data['gameEndedInSurrender'] = gameEndedInSurrender;
    data['goldEarned'] = goldEarned;
    data['goldSpent'] = goldSpent;
    data['individualPosition'] = individualPosition;
    data['inhibitorKills'] = inhibitorKills;
    data['inhibitorTakedowns'] = inhibitorTakedowns;
    data['inhibitorsLost'] = inhibitorsLost;
    data['item0'] = item0;
    data['item1'] = item1;
    data['item2'] = item2;
    data['item3'] = item3;
    data['item4'] = item4;
    data['item5'] = item5;
    data['item6'] = item6;
    data['itemsPurchased'] = itemsPurchased;
    data['killingSprees'] = killingSprees;
    data['kills'] = kills;
    data['lane'] = lane;
    data['largestCriticalStrike'] = largestCriticalStrike;
    data['largestKillingSpree'] = largestKillingSpree;
    data['largestMultiKill'] = largestMultiKill;
    data['longestTimeSpentLiving'] = longestTimeSpentLiving;
    data['magicDamageDealt'] = magicDamageDealt;
    data['magicDamageDealtToChampions'] = magicDamageDealtToChampions;
    data['magicDamageTaken'] = magicDamageTaken;
    data['neutralMinionsKilled'] = neutralMinionsKilled;
    data['nexusKills'] = nexusKills;
    data['nexusLost'] = nexusLost;
    data['nexusTakedowns'] = nexusTakedowns;
    data['objectivesStolen'] = objectivesStolen;
    data['objectivesStolenAssists'] = objectivesStolenAssists;
    data['participantId'] = participantId;
    data['pentaKills'] = pentaKills;
    data['perks'] = perks.toJson();
    data['physicalDamageDealt'] = physicalDamageDealt;
    data['physicalDamageDealtToChampions'] = physicalDamageDealtToChampions;
    data['physicalDamageTaken'] = physicalDamageTaken;
    data['profileIcon'] = profileIcon;
    data['puuid'] = puuid;
    data['quadraKills'] = quadraKills;
    data['riotIdName'] = riotIdName;
    data['riotIdTagline'] = riotIdTagline;
    data['role'] = role;
    data['sightWardsBoughtInGame'] = sightWardsBoughtInGame;
    data['spell1Casts'] = spell1Casts;
    data['spell2Casts'] = spell2Casts;
    data['spell3Casts'] = spell3Casts;
    data['spell4Casts'] = spell4Casts;
    data['summoner1Casts'] = summoner1Casts;
    data['summoner1Id'] = summoner1Id;
    data['summoner2Casts'] = summoner2Casts;
    data['summoner2Id'] = summoner2Id;
    data['summonerId'] = summonerId;
    data['summonerLevel'] = summonerLevel;
    data['summonerName'] = summonerName;
    data['teamEarlySurrendered'] = teamEarlySurrendered;
    data['teamId'] = teamId;
    data['teamPosition'] = teamPosition;
    data['timeCCingOthers'] = timeCCingOthers;
    data['timePlayed'] = timePlayed;
    data['totalDamageDealt'] = totalDamageDealt;
    data['totalDamageDealtToChampions'] = totalDamageDealtToChampions;
    data['totalDamageShieldedOnTeammates'] = totalDamageShieldedOnTeammates;
    data['totalDamageTaken'] = totalDamageTaken;
    data['totalHeal'] = totalHeal;
    data['totalHealsOnTeammates'] = totalHealsOnTeammates;
    data['totalMinionsKilled'] = totalMinionsKilled;
    data['totalTimeCCDealt'] = totalTimeCCDealt;
    data['totalTimeSpentDead'] = totalTimeSpentDead;
    data['totalUnitsHealed'] = totalUnitsHealed;
    data['tripleKills'] = tripleKills;
    data['trueDamageDealt'] = trueDamageDealt;
    data['trueDamageDealtToChampions'] = trueDamageDealtToChampions;
    data['trueDamageTaken'] = trueDamageTaken;
    data['turretKills'] = turretKills;
    data['turretTakedowns'] = turretTakedowns;
    data['turretsLost'] = turretsLost;
    data['unrealKills'] = unrealKills;
    data['visionScore'] = visionScore;
    data['visionWardsBoughtInGame'] = visionWardsBoughtInGame;
    data['wardsKilled'] = wardsKilled;
    data['wardsPlaced'] = wardsPlaced;
    data['win'] = win;
    return data;
  }
}

class Perks {
  late StatPerks statPerks;
  late List<Styles> styles;

  Perks({required this.statPerks, required this.styles});

  Perks.fromJson(Map<String, dynamic> json) {
    statPerks = (json['statPerks'] != null
        ? StatPerks.fromJson(json['statPerks'])
        : null)!;
    if (json['styles'] != null) {
      styles = <Styles>[];
      json['styles'].forEach((v) {
        styles.add(Styles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statPerks'] = statPerks.toJson();
    data['styles'] = styles.map((v) => v.toJson()).toList();
    return data;
  }
}

class StatPerks {
  late int defense;
  late int flex;
  late int offense;

  StatPerks({required this.defense, required this.flex, required this.offense});

  StatPerks.fromJson(Map<String, dynamic> json) {
    defense = json['defense'];
    flex = json['flex'];
    offense = json['offense'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['defense'] = defense;
    data['flex'] = flex;
    data['offense'] = offense;
    return data;
  }
}

class Styles {
  late String description;
  late List<Selections> selections;
  late int style;

  Styles(
      {required this.description,
      required this.selections,
      required this.style});

  Styles.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    if (json['selections'] != null) {
      selections = <Selections>[];
      json['selections'].forEach((v) {
        selections.add(Selections.fromJson(v));
      });
    }
    style = json['style'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['selections'] = selections.map((v) => v.toJson()).toList();
    data['style'] = style;
    return data;
  }
}

class Selections {
  late int perk;
  late int var1;
  late int var2;
  late int var3;

  Selections(
      {required this.perk,
      required this.var1,
      required this.var2,
      required this.var3});

  Selections.fromJson(Map<String, dynamic> json) {
    perk = json['perk'];
    var1 = json['var1'];
    var2 = json['var2'];
    var3 = json['var3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['perk'] = perk;
    data['var1'] = var1;
    data['var2'] = var2;
    data['var3'] = var3;
    return data;
  }
}

class Teams {
  late List<Bans> bans;
  late Objectives objectives;
  late int teamId;
  late bool win;

  Teams(
      {required this.bans,
      required this.objectives,
      required this.teamId,
      required this.win});

  Teams.fromJson(Map<String, dynamic> json) {
    if (json['bans'] != null) {
      bans = <Bans>[];
      json['bans'].forEach((v) {
        bans.add(Bans.fromJson(v));
      });
    }
    objectives = (json['objectives'] != null
        ? Objectives.fromJson(json['objectives'])
        : null)!;
    teamId = json['teamId'];
    win = json['win'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bans'] = bans.map((v) => v.toJson()).toList();
    data['objectives'] = objectives.toJson();
    data['teamId'] = teamId;
    data['win'] = win;
    return data;
  }
}

class Bans {
  late int championId;
  late int pickTurn;

  Bans({required this.championId, required this.pickTurn});

  Bans.fromJson(Map<String, dynamic> json) {
    championId = json['championId'];
    pickTurn = json['pickTurn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['championId'] = championId;
    data['pickTurn'] = pickTurn;
    return data;
  }
}

class Objectives {
  late Baron baron;
  late Baron champion;
  late Baron dragon;
  late Baron inhibitor;
  late Baron riftHerald;
  late Baron tower;

  Objectives(
      {required this.baron,
      required this.champion,
      required this.dragon,
      required this.inhibitor,
      required this.riftHerald,
      required this.tower});

  Objectives.fromJson(Map<String, dynamic> json) {
    baron = (json['baron'] != null ? Baron.fromJson(json['baron']) : null)!;
    champion =
        (json['champion'] != null ? Baron.fromJson(json['champion']) : null)!;
    dragon = (json['dragon'] != null ? Baron.fromJson(json['dragon']) : null)!;
    inhibitor =
        (json['inhibitor'] != null ? Baron.fromJson(json['inhibitor']) : null)!;
    riftHerald = (json['riftHerald'] != null
        ? Baron.fromJson(json['riftHerald'])
        : null)!;
    tower = (json['tower'] != null ? Baron.fromJson(json['tower']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['baron'] = baron.toJson();
    data['champion'] = champion.toJson();
    data['dragon'] = dragon.toJson();
    data['inhibitor'] = inhibitor.toJson();
    data['riftHerald'] = riftHerald.toJson();
    data['tower'] = tower.toJson();
    return data;
  }
}

class Baron {
  late bool first;
  late int kills;

  Baron({required this.first, required this.kills});

  Baron.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    kills = json['kills'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first'] = first;
    data['kills'] = kills;
    return data;
  }
}
