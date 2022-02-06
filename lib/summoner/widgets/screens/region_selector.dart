import 'package:flutter/material.dart';
import 'package:league_checker/providers/summoner_provider.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/url_builder.dart';
import 'package:league_checker/utils/widget.dart';
import 'package:league_checker/utils/misc.dart';
import 'package:provider/provider.dart';

class RegionSelector extends StatelessWidget {
  const RegionSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SummonerProvider provider = Provider.of<SummonerProvider>(context);

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
                flagItem("br", provider, context),
                flagItem("eune", provider, context),
                flagItem("euw", provider, context),
                flagItem("jp", provider, context),
                flagItem("kr", provider, context),
                flagItem("lan", provider, context),
                flagItem("las", provider, context),
                flagItem("na", provider, context),
                flagItem("oce", provider, context),
                flagItem("ru", provider, context),
                flagItem("tr", provider, context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget flagItem(String flag, SummonerProvider provider, context) {
  return Padding(
    padding: const EdgeInsets.all(1),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        color: provider.region == flag ? Colors.white24 : Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () async {
            provider.selectRegion(flag);
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
                    image: AssetImage(UrlBuilder.flags(flag)),
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
