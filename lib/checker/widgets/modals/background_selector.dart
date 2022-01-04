import 'package:flutter/material.dart';
import 'package:league_checker/repositories/checker_repository.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/utils/spacer.dart';
import 'package:provider/provider.dart';

class BackgroundSelector extends StatelessWidget {
  const BackgroundSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late CheckerRepository checkerRepository;
    checkerRepository = Provider.of<CheckerRepository>(context);

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
              height: checkerRepository.background == "rengar" ? 300 : 270,
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
                    checkerRepository.selectBackground('rengar');
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
              height: checkerRepository.background == "aatrox" ? 300 : 270,
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
                    checkerRepository.selectBackground('aatrox');
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
              height: checkerRepository.background == "mordekaiser" ? 300 : 270,
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
                    checkerRepository.selectBackground('mordekaiser');
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
