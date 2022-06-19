import 'package:flutter/material.dart';
import 'package:league_checker/providers/data_provider.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/url_builder.dart';
import 'package:league_checker/utils/widget.dart';
import 'package:provider/provider.dart';

class RegionSelector extends StatelessWidget {
  const RegionSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataProvider provider = Provider.of<DataProvider>(context);

    return Container(
      decoration: const BoxDecoration(
        color: darkGrayTone5,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Select a region",
              style: textMediumBold,
            ),
            verticalSpacer(20),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 1,
              runSpacing: 1,
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
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: SizedBox(
                    height: 50,
                    width: 80,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget flagItem(String flag, DataProvider provider, context) {
  return ClipRRect(
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
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: SizedBox(
            height: 50,
            width: 80,
            child: Column(
              children: [
                Image(
                  image: AssetImage(flags(flag)),
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
  );
}
