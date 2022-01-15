import 'package:flutter/material.dart';
import 'package:league_checker/repositories/checker_repository.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/spacer.dart';
import 'package:league_checker/utils/waiter.dart';
import 'package:provider/provider.dart';

class BackgroundSelector extends StatelessWidget {
  const BackgroundSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late CheckerRepository checkerRepository;
    checkerRepository = Provider.of<CheckerRepository>(context);

    return SizedBox(
      height: 320,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: primaryGold),
            ),
            height: checkerRepository.background == "rengar" ? 300 : 270,
            width: checkerRepository.width / 3 - 10,
            child: Ink(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image:
                      ExactAssetImage("assets/images/backgrounds/rengar.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: InkWell(
                onTap: () async {
                  checkerRepository.selectBackground('rengar');
                  await wait(200);
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
            width: checkerRepository.width / 3 - 10,
            child: Ink(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image:
                      ExactAssetImage("assets/images/backgrounds/aatrox.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: InkWell(
                onTap: () async {
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
            width: checkerRepository.width / 3 - 10,
            child: Ink(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage(
                      "assets/images/backgrounds/mordekaiser.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: InkWell(
                onTap: () async {
                  checkerRepository.selectBackground('mordekaiser');
                  await wait(200);
                  Navigator.pop(context);
                },
                splashColor: Colors.brown.withOpacity(0.5),
              ),
            ),
          )
        ],
      ),
    );
  }
}
