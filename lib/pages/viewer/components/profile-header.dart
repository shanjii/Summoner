import 'package:flutter/material.dart';
import 'package:league_checker/providers/data_provider.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/widget.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({Key? key, required this.region}) : super(key: key);
  final String region;
  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  bool startAnimation = false;
  bool isAddingSummoner = false;
  Duration duration = const Duration(milliseconds: 500);
  late DataProvider provider;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () => setState(() => startAnimation = true));
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<DataProvider>(context);
    return AnimatedPositioned(
      top: startAnimation ? 0 : -300,
      duration: duration,
      curve: Curves.easeOut,
      child: Column(
        children: [
          Container(
            color: Colors.black54,
            width: provider.device.width,
            height: provider.device.statusBarHeight + 102,
            child: Padding(
              padding: EdgeInsets.only(left: 30, top: provider.device.statusBarHeight + 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  horizontalSpacer(40),
                  const Text(
                    "Summoner",
                    style: textMediumBold,
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 30, bottom: 3),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Material(
                        color: Colors.transparent,
                        child: provider.hasFavoriteSummoner(provider.selectedSummonerData)
                            ? InkWell(
                                onTap: () => removeIndex(),
                                child: const Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              )
                            : InkWell(
                                onTap: () => starSummoner(),
                                child: const Icon(
                                  Icons.star_border,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: provider.device.width,
            child: LinearProgressIndicator(
              value: isAddingSummoner ? null : 0,
              backgroundColor: Colors.transparent,
              minHeight: 2,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  starSummoner() async {
    setState(() => isAddingSummoner = true);
    await provider.addFavoriteSummoner(provider.selectedSummonerData.name, widget.region);
    setState(() => isAddingSummoner = false);
  }

  removeIndex() {
    for (var i = 0; i < provider.summonerList.length; i++) {
      if (provider.summonerList[i].accountId == provider.selectedSummonerData.accountId) {
        provider.removeSingleSummoner(i);
      }
    }
  }
}
