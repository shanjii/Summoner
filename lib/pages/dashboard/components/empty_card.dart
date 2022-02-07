import 'package:flutter/material.dart';
import 'package:league_checker/providers/data_provider.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/utils/widget.dart';
import 'package:provider/provider.dart';

class EmptyCard extends StatelessWidget {
  const EmptyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late DataProvider provider = Provider.of<DataProvider>(context);

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
                      showRemoveSummoner(context, provider);
                    },
                    child: SizedBox(
                      width: (provider.device.width / 2) - 80,
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
                      showAddSummoner(provider, context);
                    },
                    child: SizedBox(
                      width: (provider.device.width / 2),
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

  showAddSummoner(DataProvider provider, context) async {
    provider.activateAddSummonerScreen(true, context);
  }

  showRemoveSummoner(context, DataProvider provider) {
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
                provider.removeSummonerList();
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
