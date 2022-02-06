class UrlBuilder {
  
  static profileIconUrl(value, apiVersion) {
    return "http://ddragon.leagueoflegends.com/cdn/$apiVersion/img/profileicon/$value.png";
  }

  static championWallpaper(value) {
    return "http://ddragon.leagueoflegends.com/cdn/img/champion/splash/${value}_0.jpg";
  }

  static flags(value) {
    return "assets/images/regions/regionFlag-$value.png";
  }

  static itemImage(value, apiVersion) {
    return "http://ddragon.leagueoflegends.com/cdn/$apiVersion/img/item/$value.png";
  }

  static championIcon(value, apiVersion) {
    return "http://ddragon.leagueoflegends.com/cdn/$apiVersion/img/champion/$value.png";
  }
}
