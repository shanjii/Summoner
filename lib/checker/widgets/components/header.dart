import 'package:flutter/material.dart';
import 'package:league_checker/checker/widgets/modals/region_selector.dart';
import 'package:league_checker/repositories/checker_repository.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/spacer.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var checkerRepository = Provider.of<CheckerRepository>(context);

    return Container(
      height: checkerRepository.statusBarHeight + 100,
      color: darkGrayTone2,
      child: Padding(
        padding:
            EdgeInsets.only(left: 30, top: checkerRepository.statusBarHeight + 10),
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
      backgroundColor: Colors.transparent
    );
  }
}
