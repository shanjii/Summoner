import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
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

Future<String> verifySelectedImage() async {
  String background;
  
  await loadImage(const AssetImage('assets/images/backgrounds/rengar.jpg'));
  await loadImage(const AssetImage('assets/images/backgrounds/aatrox.jpg'));
  await loadImage(
      const AssetImage('assets/images/backgrounds/mordekaiser.jpg'));

  final prefs = await SharedPreferences.getInstance();
  var selectedBackground = prefs.getString('background');
  if (selectedBackground != null) {
    background = selectedBackground;
  } else {
    background = 'rengar';
  }
  return background;
}
