import 'package:flutter/material.dart';
import 'package:league_checker/checker/widgets/modals/background_selector.dart';
import 'package:league_checker/checker/widgets/modals/region_selector.dart';
import 'package:league_checker/repositories/checker_repository.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var checkerRepository = Provider.of<CheckerRepository>(context);

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => openBackgroundSelector(context),
              child: const Icon(
                Icons.wallpaper,
                color: primaryGold,
                size: 30,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => openRegionSelector(context),
              child: const Icon(
                Icons.public,
                color: primaryGold,
                size: 30,
              ),
            ),
          ),
        ),
        const Spacer(
          flex: 1,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Image(
            height: 30,
            width: 30,
            image: AssetImage(
                "assets/images/regions/regionFlag-${checkerRepository.region}.png"),
          ),
        ),
        SizedBox(
          height: 33,
          child: Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: checkerRepository.updatingDevice
                ? const Icon(
                    Icons.connect_without_contact_rounded,
                    color: primaryGold,
                    size: 30,
                  )
                : Column(
                    children: [
                      const Text(
                        "Patch",
                        style: textTiny,
                      ),
                      const Spacer(),
                      Text(
                        checkerRepository.apiVersion,
                        style: label,
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  openBackgroundSelector(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const BackgroundSelector();
      },
      backgroundColor: Colors.transparent,
    );
  }

  openRegionSelector(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const RegionSelector();
      },
      backgroundColor: primaryDarkblue,
    );
  }
}
