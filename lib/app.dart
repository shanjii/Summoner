import 'package:flutter/material.dart';
import 'package:league_checker/summoner/summoner.dart';
import 'package:league_checker/style/color_palette.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: darkGrayTone3,
            secondary: grayTone2,
          ),
          backgroundColor: darkGrayTone2),
      home: const SummonerPage(),
    );
  }
}
