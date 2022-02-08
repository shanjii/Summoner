import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:league_checker/providers/data_provider.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/url_builder.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({Key? key, required this.index, required this.region}) : super(key: key);
  final int index;
  final String region;

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  bool startAnimation = false;
  bool isAddingSummoner = false;
  Duration duration = const Duration(milliseconds: 500);
  late DataProvider provider;

  @override
  void initState() {
    super.initState();
    Future.delayed(duration, () => setState(() => startAnimation = true));
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<DataProvider>(context);

    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          Hero(
            tag: widget.index != -1 ? provider.summonerData.accountId + widget.index.toString() : "",
            child: SizedBox(
              height: 300,
              width: provider.device.width,
              child: provider.masteryList.isNotEmpty
                  ? CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: UrlBuilder.championWallpaper(provider.getChampionImage(provider.masteryList[0].championId)),
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: imageProvider,
                            ),
                          ),
                        );
                      },
                      placeholder: (context, url) => Container(
                        color: Colors.white10,
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    )
                  : const SizedBox(),
            ),
          ),
          AnimatedOpacity(
            opacity: startAnimation ? 1 : 0,
            duration: duration,
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: SizedBox(
                  width: 100,
                  height: 110,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CachedNetworkImage(
                        width: 100,
                        height: 100,
                        imageUrl: UrlBuilder.profileIconUrl(provider.summonerData.profileIconId, provider.apiVersion),
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: imageProvider,
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          );
                        },
                        placeholder: (context, url) => const CircularProgressIndicator(
                          color: primaryGold,
                          strokeWidth: 10,
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: darkGrayTone2,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 2, bottom: 2, right: 8),
                              child: Text(
                                provider.summonerData.summonerLevel.toString(),
                                style: textSmall,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: startAnimation ? 1 : 0,
            duration: duration,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  provider.summonerData.name,
                  style: textMedium,
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            top: startAnimation ? 0 : -300,
            duration: duration,
            curve: Curves.easeOut,
            child: Container(
              width: provider.device.width,
              height: provider.device.statusBarHeight + 50,
              color: Colors.black26,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                    const Spacer(),
                    isAddingSummoner
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Material(
                            color: Colors.transparent,
                            child: provider.hasFavoriteSummoner(provider.summonerData)
                                ? InkWell(
                                    borderRadius: BorderRadius.circular(100),
                                    onTap: () {
                                      removeIndex();
                                    },
                                    child: const Icon(
                                      Icons.delete_outline_rounded,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  )
                                : InkWell(
                                    borderRadius: BorderRadius.circular(100),
                                    onTap: () {
                                      starSummoner();
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  starSummoner() async {
    setState(() => isAddingSummoner = true);
    await provider.addFavoriteSummoner(provider.summonerData.name, widget.region);
    setState(() => isAddingSummoner = false);
  }

  removeIndex() {
    for (var i = 0; i < provider.summonerList.length; i++) {
      if (provider.summonerList[i].accountId == provider.summonerData.accountId) {
        provider.removeSingleSummoner(i);
      }
    }
  }
}
