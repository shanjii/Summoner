import 'package:flutter/material.dart';
import 'package:league_checker/app.dart';
import 'package:league_checker/preload.dart';
import 'package:league_checker/repositories/checker_repository.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var background = await verifySelectedImage();
  runApp(
    ChangeNotifierProvider(
      create: (context) => CheckerRepository(background),
      child: const MyApp(),
    ),
  );
}
