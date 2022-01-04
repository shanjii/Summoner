import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:league_checker/repositories/checker_repository.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/spacer.dart';

class BackgroundSelector extends StatelessWidget {
  const BackgroundSelector(
      {Key? key,
      required this.statusBarHeight,
      required this.selected,
      required this.vm})
      : super(key: key);
  final String selected;
  final double statusBarHeight;
  final CheckerRepository vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(40, 40, 30, 0),
            child: Container(
              height: 5,
              decoration: BoxDecoration(
                color: primaryGold,
                borderRadius: BorderRadius.circular(100),
              ),
            )),
        verticalSpacer(40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: primaryGold),
              ),
              height: selected == "rengar" ? 300 : 270,
              width: 100,
              child: Ink(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image:
                        ExactAssetImage("assets/images/backgrounds/rengar.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    vm.selectBackground('rengar');
                    Navigator.pop(context);
                  },
                  splashColor: Colors.brown.withOpacity(0.5),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: primaryGold),
              ),
              height: selected == "aatrox" ? 300 : 270,
              width: 100,
              child: Ink(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image:
                        ExactAssetImage("assets/images/backgrounds/aatrox.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    vm.selectBackground('aatrox');
                    Navigator.pop(context);
                  },
                  splashColor: Colors.brown.withOpacity(0.5),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: primaryGold),
              ),
              height: selected == "mordekaiser" ? 300 : 270,
              width: 100,
              child: Ink(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage(
                        "assets/images/backgrounds/mordekaiser.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    vm.selectBackground('mordekaiser');
                    Navigator.pop(context);
                  },
                  splashColor: Colors.brown.withOpacity(0.5),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
