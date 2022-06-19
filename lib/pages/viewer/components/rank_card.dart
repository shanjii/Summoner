import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:league_checker/models/rank_model.dart';
import 'package:league_checker/providers/data_provider.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/widget.dart';
import 'package:provider/provider.dart';

class RankCard extends StatefulWidget {
  const RankCard({Key? key, required this.rank}) : super(key: key);
  final RankModel rank;
  @override
  _MasteryCardState createState() => _MasteryCardState();
}

class _MasteryCardState extends State<RankCard> {
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      opacity = 1;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    DataProvider provider = Provider.of<DataProvider>(context);

    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
      child: Container(
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
            children: [
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: darkGrayTone2),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image(
                    image: AssetImage('assets/images/ranked/${widget.rank.tier}.png'),
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
              horizontalSpacer(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.rank.queueType == "RANKED_SOLO_5x5" ? const Text("Ranked Solo/Duo", style: label) : const Text("Ranked Flex", style: label),
                  verticalSpacer(3),
                  coloredRanks(),
                  verticalSpacer(3),
                  Text(
                    widget.rank.leaguePoints.toString() + " LP",
                    style: textSmallBold,
                  ),
                  verticalSpacer(3),
                  Text(
                    "WR: " + ((widget.rank.wins / (widget.rank.wins + widget.rank.losses)) * 100).toString().substring(0, 2) + "%",
                    style: label,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget coloredRanks() {
    return Row(
      children: [
        if (widget.rank.tier == "CHALLENGER") ...{
          Text(widget.rank.tier, style: textRankChallenger)
        } else if (widget.rank.tier == "GRANDMASTER") ...{
          Text(widget.rank.tier, style: textRankGrandmaster)
        } else if (widget.rank.tier == "MASTER") ...{
          Text(widget.rank.tier, style: textRankMaster)
        } else if (widget.rank.tier == "DIAMOND") ...{
          Text(widget.rank.tier + " " + widget.rank.rank, style: textRankDiamond)
        } else if (widget.rank.tier == "PLATINUM") ...{
          Text(widget.rank.tier + " " + widget.rank.rank, style: textRankPlatinum)
        } else if (widget.rank.tier == "GOLD") ...{
          Text(widget.rank.tier + " " + widget.rank.rank, style: textRankGold)
        } else if (widget.rank.tier == "SILVER") ...{
          Text(widget.rank.tier + " " + widget.rank.rank, style: textRankSilver)
        } else if (widget.rank.tier == "BRONZE") ...{
          Text(widget.rank.tier + " " + widget.rank.rank, style: textRankBronze)
        } else if (widget.rank.tier == "IRON") ...{
          Text(widget.rank.tier + " " + widget.rank.rank, style: textRankIron)
        },
      ],
    );
  }
}
