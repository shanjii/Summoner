import 'package:flutter/material.dart';
import 'package:league_checker/providers/summoner_provider.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/widgetTools.dart';
import 'package:league_checker/utils/misc.dart';
import 'package:provider/provider.dart';

class RegionSelector extends StatelessWidget {
  const RegionSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late SummonerProvider summonerProvider;
    summonerProvider = Provider.of<SummonerProvider>(context);

    return Container(
      decoration: const BoxDecoration(
        color: darkGrayTone4,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      height: 470,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpacer(30),
          const Center(
            child: Text(
              "Select a region",
              style: textMedium,
            ),
          ),
          verticalSpacer(30),
          Center(
            child: Wrap(
              children: [
                flagItem("br", summonerProvider, context),
                flagItem("eune", summonerProvider, context),
                flagItem("euw", summonerProvider, context),
                flagItem("jp", summonerProvider, context),
                flagItem("kr", summonerProvider, context),
                flagItem("lan", summonerProvider, context),
                flagItem("las", summonerProvider, context),
                flagItem("na", summonerProvider, context),
                flagItem("oce", summonerProvider, context),
                flagItem("ru", summonerProvider, context),
                flagItem("tr", summonerProvider, context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget flagItem(String flag, SummonerProvider summonerProvider, context) {
  return Padding(
    padding: const EdgeInsets.all(1),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: summonerProvider.region == flag
            ? Colors.white24
            : Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () async {
            summonerProvider.selectRegion(flag);
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 50,
              width: 80,
              child: Column(
                children: [
                  Image(
                    image: AssetImage(
                        "assets/images/regions/regionFlag-$flag.png"),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Text(
                    flag.toUpperCase(),
                    style: textTiny,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
