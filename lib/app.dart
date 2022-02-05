import 'package:flutter/material.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/summoner/summoner.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Summoner',
      theme: ThemeData(
        primaryColor: darkGrayTone2,
        dialogTheme: const DialogTheme(
          backgroundColor: darkGrayTone3,
          titleTextStyle: textSmall,
        ),
      ),
      color: darkGrayTone2,
      home: const SummonerPage(),
    );
  }
}
