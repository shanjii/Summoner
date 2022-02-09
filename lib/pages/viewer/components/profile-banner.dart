import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:league_checker/providers/data_provider.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/url_builder.dart';
import 'package:provider/provider.dart';

class ProfileBanner extends StatefulWidget {
  const ProfileBanner({Key? key, required this.index, required this.region}) : super(key: key);
  final int index;
  final String region;

  @override
  State<ProfileBanner> createState() => _ProfileBannerState();
}

class _ProfileBannerState extends State<ProfileBanner> {
  bool startAnimation = false;
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

    return Padding(
      padding: EdgeInsets.fromLTRB(10, provider.device.statusBarHeight + 102, 10, 10),
      child: SizedBox(
        height: 200,
        child: Stack(
          children: [
            Hero(
              tag: widget.index != -1 ? provider.selectedSummonerData.accountId + widget.index.toString() : "",
              child: SizedBox(
                height: 200,
                width: provider.device.width,
                child: provider.masteryList.isNotEmpty
                    ? CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: UrlBuilder.championWallpaper(provider.getChampionImage(provider.masteryList[0].championId)),
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
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
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: 100,
                    height: 110,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CachedNetworkImage(
                          width: 100,
                          height: 100,
                          imageUrl: UrlBuilder.profileIconUrl(provider.selectedSummonerData.profileIconId, provider.apiVersion),
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
                                  provider.selectedSummonerData.summonerLevel.toString(),
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
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    provider.selectedSummonerData.name,
                    style: textMedium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
