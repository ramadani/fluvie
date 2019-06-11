class ConfigData {
  final TmDB tmdb;

  ConfigData({this.tmdb});
}

class TmDB {
  final String baseUrl;
  final String apiKey;

  TmDB({this.baseUrl, this.apiKey});
}
