import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:league_checker/summoner/widgets/windows/summoner_viewer.dart';
import 'package:league_checker/providers/summoner_provider.dart';
import 'package:league_checker/models/summoner_model.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/indexer.dart';
import 'package:league_checker/utils/widget.dart';
import 'package:league_checker/utils/misc.dart';
import 'package:provider/provider.dart';

class EmptyCard extends StatelessWidget {
  const EmptyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late SummonerProvider summonerProvider;
    summonerProvider = Provider.of<SummonerProvider>(context);

    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Material(
                  color: darkGrayTone3,
                  child: InkWell(
                    onTap: () {
                      showRemoveSummoner(context, summonerProvider);
                    },
                    child: SizedBox(
                      width: (summonerProvider.width / 2) - 80,
                      height: 102,
                      child: const Icon(
                        Icons.clear_all_rounded,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, left: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Material(
                  color: grayTone2,
                  child: InkWell(
                    onTap: () {
                      showAddSummoner(summonerProvider, context);
                    },
                    child: SizedBox(
                      width: (summonerProvider.width / 2),
                      height: 102,
                      child: const Icon(
                        Icons.add,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        verticalSpacer(20)
      ],
    );
  }

  showAddSummoner(SummonerProvider summonerProvider, context) async {
    summonerProvider.activateAddSummonerScreen(true, context);
  }

  showRemoveSummoner(context, SummonerProvider summonerProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove all favorited Summoners?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                summonerProvider.removeSummonerList();
                Navigator.pop(context);
              },
              child: const Text('REMOVE ALL'),
            )
          ],
        );
      },
    );
  }
}
