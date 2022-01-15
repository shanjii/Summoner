import 'package:flutter/material.dart';
import 'package:league_checker/repositories/checker_repository.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/spacer.dart';
import 'package:league_checker/utils/waiter.dart';
import 'package:provider/provider.dart';

class RegionSelector extends StatelessWidget {
  const RegionSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late CheckerRepository checkerRepository;
    checkerRepository = Provider.of<CheckerRepository>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              10, checkerRepository.statusBarHeight + 10, 0, 0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const RotatedBox(
                quarterTurns: 1,
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: primaryGold,
                  size: 40,
                ),
              ),
            ),
          ),
        ),
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
              flagItem("br", checkerRepository, context),
              flagItem("eune", checkerRepository, context),
              flagItem("euw", checkerRepository, context),
              flagItem("jp", checkerRepository, context),
              flagItem("kr", checkerRepository, context),
              flagItem("lan", checkerRepository, context),
              flagItem("las", checkerRepository, context),
              flagItem("na", checkerRepository, context),
              flagItem("oce", checkerRepository, context),
              flagItem("ru", checkerRepository, context),
              flagItem("tr", checkerRepository, context),
            ],
          ),
        ),
      ],
    );
  }
}

Widget flagItem(String flag, CheckerRepository checkerRepository, context) {
  return Container(
    color:
        checkerRepository.region == flag ? Colors.white24 : Colors.transparent,
    child: InkWell(
      onTap: () async {
        checkerRepository.selectRegion(flag);
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
                image: AssetImage("assets/images/regions/regionFlag-$flag.png"),
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
  );
}