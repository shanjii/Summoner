import 'package:flutter/material.dart';
import 'package:league_checker/providers/data_provider.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/widget.dart';
import 'package:provider/provider.dart';

class NoRankCard extends StatefulWidget {
  const NoRankCard({Key? key}) : super(key: key);

  @override
  State<NoRankCard> createState() => _NoRankCardState();
}

class _NoRankCardState extends State<NoRankCard> {
  @override
  Widget build(BuildContext context) {
    DataProvider provider = Provider.of<DataProvider>(context);
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      width: provider.device.width - 20,
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: darkGrayTone3,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: const [
            Icon(
              Icons.question_mark_rounded,
              size: 80,
              color: darkGrayTone2,
            ),
            Spacer(),
            Text(
              "Unranked",
              style: textMediumBlended,
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
