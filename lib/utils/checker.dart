import 'package:league_checker/models/summoner_model.dart';

hasFavoriteSummoner(SummonerModel summoner, summonerList) {
  bool hasSummoner = false;
  for (var item in summonerList) {
    if (summoner.accountId == item.accountId) {
      hasSummoner = true;
    }
  }
  if (hasSummoner) {
    return true;
  } else {
    return false;
  }
}
