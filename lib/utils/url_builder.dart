profileIconUrl(value, apiVersion) {
  return "http://ddragon.leagueoflegends.com/cdn/$apiVersion/img/profileicon/$value.png";
}

championWallpaper(value) {
  return "http://ddragon.leagueoflegends.com/cdn/img/champion/splash/${value}_0.jpg";
}

flags(value) {
  return "assets/images/regions/regionFlag-$value.png";
}

itemImage(value, apiVersion) {
  return "http://ddragon.leagueoflegends.com/cdn/$apiVersion/img/item/$value.png";
}

championIcon(value, apiVersion) {
  return "http://ddragon.leagueoflegends.com/cdn/$apiVersion/img/champion/$value.png";
}

//Return the champion image url from a champion ID
getChampionImage(championId, championList) {
  for (var element in championList) {
    if (element.key == championId.toString()) {
      return element.image.full.replaceAll('.png', '');
    }
  }
  return 'Undefined';
}
