regionIndex(region) {
  switch (region) {
    case "na":
      return ["na1", "americas", "na"];
    case "br":
      return ["br1", "americas", "br"];
    case "eune":
      return ["eun1", "europe", "eune"];
    case "euw":
      return ["euw1", "europe", "euw"];
    case "jp":
      return ["jp1", "asia", "jp"];
    case "kr":
      return ["kr", "asia", "kr"];
    case "lan":
      return ["la1", "americas", "lan"];
    case "las":
      return ["la2", "americas", "las"];
    case "oce":
      return ["oc1", "americas", "oce"];
    case "ru":
      return ["ru", "europe", "ru"];
    case "tr":
      return ["tr1", "europe", "tr"];
    default:
      return ["na1", "americas", "na"];
  }
}
