import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:league_checker/models/summoner_model.dart';
import 'package:league_checker/utils/indexer.dart';
import 'package:league_checker/utils/local_storage.dart';
import 'package:league_checker/utils/url_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> loadImage(ImageProvider provider) {
  final config = ImageConfiguration(
    bundle: rootBundle,
    devicePixelRatio: 1,
    platform: defaultTargetPlatform,
  );
  final Completer<void> completer = Completer();
  final ImageStream stream = provider.resolve(config);

  late final ImageStreamListener listener;

  listener = ImageStreamListener((ImageInfo image, bool sync) {
    completer.complete();
    stream.removeListener(listener);
  }, onError: (dynamic exception, StackTrace? stackTrace) {
    completer.complete();
    stream.removeListener(listener);
    FlutterError.reportError(FlutterErrorDetails(
      context: ErrorDescription('image failed to load'),
      library: 'image resource service',
      exception: exception,
      stack: stackTrace,
      silent: true,
    ));
  });

  stream.addListener(listener);
  return completer.future;
}

Future preloadImages() async {
  List<SummonerModel> summonerList = [];
  List decodedJsonData = await LocalStorage.readDecoded("summoners");
  for (var i = 0; i < decodedJsonData.length; i++) {
    summonerList.add(SummonerModel.fromJson(decodedJsonData[i]));
  }
  for (var summoner in summonerList) {
    if (summoner.background != "") {
      await loadImage(
        NetworkImage(UrlBuilder.championWallpaper(summoner.background)),
      );
    }
  }
}

Future<List<String>> checkRegion() async {
  final prefs = await SharedPreferences.getInstance();
  var region = prefs.getString('region');

  return regionIndex(region);
}
