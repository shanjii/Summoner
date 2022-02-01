import 'package:flutter/material.dart';
import 'package:league_checker/summoner/widgets/modals/region_selector.dart';
import 'package:league_checker/providers/summoner_provider.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/widgetTools.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var summonerProvider = Provider.of<SummonerProvider>(context);

    return Container(
      height: summonerProvider.statusBarHeight + 100,
      color: darkGrayTone2,
      child: Padding(
        padding: EdgeInsets.only(
            left: 30, top: summonerProvider.statusBarHeight + 10),
        child: Row(
          children: [
            const Image(
              width: 60,
              height: 60,
              image: AssetImage('assets/images/league_icon.png'),
            ),
            horizontalSpacer(20),
            const Text(
              "Summoners",
              style: textMediumBold,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    openRegionSelector(context);
                  },
                  child: const Icon(
                    Icons.public_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  openRegionSelector(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return const RegionSelector();
        },
        backgroundColor: Colors.transparent);
  }
}
