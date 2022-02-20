import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:league_checker/providers/data_provider.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/parser.dart';
import 'package:provider/provider.dart';

class MasteryCard extends StatefulWidget {
  const MasteryCard({Key? key}) : super(key: key);

  @override
  _MasteryCardState createState() => _MasteryCardState();
}

class _MasteryCardState extends State<MasteryCard> {
  @override
  Widget build(BuildContext context) {
    DataProvider provider = Provider.of<DataProvider>(context);

    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      width: provider.device.width - 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: darkGrayTone3,
      ),
      child: provider.isLoadingSummoner
          ? const Center(
              child: Text(
              "Fetching data...",
              style: label,
            ))
          : Column(
              children: [
                Text(provider.rankList.isNotEmpty ? provider.rankList[0].tier : "No rank", style: label),
                Text(provider.rankList.isNotEmpty ? provider.rankList[0].rank : "No tier", style: label),
                Text(provider.masteryList.isNotEmpty ? provider.masteryList[0].championId.toString() : "No masteries", style: label),
                // Text(winRate(provider.rankList[0].wins, provider.rankList[0].losses) + '%', style: label),
              ],
            ),
    );
  }
}
