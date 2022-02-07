import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:league_checker/providers/data_provider.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/url_builder.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  bool startAnimation = false;
  Duration duration = const Duration(milliseconds: 400);

  @override
  void initState() {
    super.initState();
    Future.delayed(duration, () => setState(() => startAnimation = true));
  }

  @override
  Widget build(BuildContext context) {
    DataProvider provider = Provider.of<DataProvider>(context);

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
          AnimatedPositioned(
            top: startAnimation ? 0 : -300,
            duration: duration,
            curve: Curves.easeInOutBack,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, provider.device.statusBarHeight + 10, 0, 0),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: startAnimation ? 1 : 0,
            duration: duration,
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 100,
                height: 130,
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
          AnimatedOpacity(
            opacity: startAnimation ? 1 : 0,
            duration: duration,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(
                  provider.summonerData.name,
                  style: textMedium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
