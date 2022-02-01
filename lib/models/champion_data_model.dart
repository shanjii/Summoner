class ChampionData {
  late String version;
  late String id;
  late String key;
  late String name;
  late String title;
  late String blurb;
  late Info info;
  late Image image;
  late List<String> tags;
  late String partype;
  late Stats stats;

  ChampionData(
      {required this.version,
      required this.id,
      required this.key,
      required this.name,
      required this.title,
      required this.blurb,
      required this.info,
      required this.image,
      required this.tags,
      required this.partype,
      required this.stats});

  ChampionData.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    id = json['id'];
    key = json['key'];
    name = json['name'];
    title = json['title'];
    blurb = json['blurb'];
    info = (json['info'] != null ? Info.fromJson(json['info']) : null)!;
    image = (json['image'] != null ? Image.fromJson(json['image']) : null)!;
    tags = json['tags'].cast<String>();
    partype = json['partype'];
    stats = (json['stats'] != null ? Stats.fromJson(json['stats']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['version'] = version;
    data['id'] = id;
    data['key'] = key;
    data['name'] = name;
    data['title'] = title;
    data['blurb'] = blurb;
    data['info'] = info.toJson();
    data['image'] = image.toJson();
    data['tags'] = tags;
    data['partype'] = partype;
    data['stats'] = stats.toJson();
    return data;
  }
}

class Info {
  late dynamic attack;
  late dynamic defense;
  late dynamic magic;
  late dynamic difficulty;

  Info(
      {required this.attack,
      required this.defense,
      required this.magic,
      required this.difficulty});

  Info.fromJson(Map<String, dynamic> json) {
    attack = json['attack'];
    defense = json['defense'];
    magic = json['magic'];
    difficulty = json['difficulty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attack'] = attack;
    data['defense'] = defense;
    data['magic'] = magic;
    data['difficulty'] = difficulty;
    return data;
  }
}

class Image {
  late String full;
  late String sprite;
  late String group;
  late int x;
  late int y;
  late int w;
  late int h;

  Image(
      {required this.full,
      required this.sprite,
      required this.group,
      required this.x,
      required this.y,
      required this.w,
      required this.h});

  Image.fromJson(Map<String, dynamic> json) {
    full = json['full'];
    sprite = json['sprite'];
    group = json['group'];
    x = json['x'];
    y = json['y'];
    w = json['w'];
    h = json['h'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full'] = full;
    data['sprite'] = sprite;
    data['group'] = group;
    data['x'] = x;
    data['y'] = y;
    data['w'] = w;
    data['h'] = h;
    return data;
  }
}

class Stats {
  late dynamic hp;
  late dynamic hpperlevel;
  late dynamic mp;
  late dynamic mpperlevel;
  late dynamic movespeed;
  late dynamic armor;
  late dynamic armorperlevel;
  late dynamic spellblock;
  late dynamic spellblockperlevel;
  late dynamic attackrange;
  late dynamic hpregen;
  late dynamic hpregenperlevel;
  late dynamic mpregen;
  late dynamic mpregenperlevel;
  late dynamic crit;
  late dynamic critperlevel;
  late dynamic attackdamage;
  late dynamic attackdamageperlevel;
  late dynamic attackspeedperlevel;
  late dynamic attackspeed;

  Stats(
      {required this.hp,
      required this.hpperlevel,
      required this.mp,
      required this.mpperlevel,
      required this.movespeed,
      required this.armor,
      required this.armorperlevel,
      required this.spellblock,
      required this.spellblockperlevel,
      required this.attackrange,
      required this.hpregen,
      required this.hpregenperlevel,
      required this.mpregen,
      required this.mpregenperlevel,
      required this.crit,
      required this.critperlevel,
      required this.attackdamage,
      required this.attackdamageperlevel,
      required this.attackspeedperlevel,
      required this.attackspeed});

  Stats.fromJson(Map<String, dynamic> json) {
    hp = json['hp'];
    hpperlevel = json['hpperlevel'];
    mp = json['mp'];
    mpperlevel = json['mpperlevel'];
    movespeed = json['movespeed'];
    armor = json['armor'];
    armorperlevel = json['armorperlevel'];
    spellblock = json['spellblock'];
    spellblockperlevel = json['spellblockperlevel'];
    attackrange = json['attackrange'];
    hpregen = json['hpregen'];
    hpregenperlevel = json['hpregenperlevel'];
    mpregen = json['mpregen'];
    mpregenperlevel = json['mpregenperlevel'];
    crit = json['crit'];
    critperlevel = json['critperlevel'];
    attackdamage = json['attackdamage'];
    attackdamageperlevel = json['attackdamageperlevel'];
    attackspeedperlevel = json['attackspeedperlevel'];
    attackspeed = json['attackspeed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hp'] = hp;
    data['hpperlevel'] = hpperlevel;
    data['mp'] = mp;
    data['mpperlevel'] = mpperlevel;
    data['movespeed'] = movespeed;
    data['armor'] = armor;
    data['armorperlevel'] = armorperlevel;
    data['spellblock'] = spellblock;
    data['spellblockperlevel'] = spellblockperlevel;
    data['attackrange'] = attackrange;
    data['hpregen'] = hpregen;
    data['hpregenperlevel'] = hpregenperlevel;
    data['mpregen'] = mpregen;
    data['mpregenperlevel'] = mpregenperlevel;
    data['crit'] = crit;
    data['critperlevel'] = critperlevel;
    data['attackdamage'] = attackdamage;
    data['attackdamageperlevel'] = attackdamageperlevel;
    data['attackspeedperlevel'] = attackspeedperlevel;
    data['attackspeed'] = attackspeed;
    return data;
  }
}

