import 'package:flutter/material.dart';
import 'package:league_checker/api/summoner_api.dart';
import 'package:league_checker/app.dart';
import 'package:league_checker/preload.dart';
import 'package:league_checker/repositories/checker_repository.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // var background = await verifySelectedImage();
  List<String> regionData = await checkRegion();

  runApp(
    ChangeNotifierProvider(
      create: (context) => CheckerRepository(
        // background,
        regionData[2],
        SummonerAPI(regionData[0], regionData[1]),
      ),
      child: const MyApp(),
    ),
  );
}
