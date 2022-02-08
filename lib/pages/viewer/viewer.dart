import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:league_checker/pages/viewer/components/profile-header.dart';
import 'package:league_checker/providers/data_provider.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/url_builder.dart';
import 'package:league_checker/utils/widget.dart';
import 'package:provider/provider.dart';

class ViewerPage extends StatelessWidget {
  const ViewerPage({Key? key, required this.index, required this.region}) : super(key: key);
  final int index;
  final String region;

  @override
  Widget build(BuildContext context) {
    DataProvider provider = Provider.of<DataProvider>(context);

    return Scaffold(
      backgroundColor: darkGrayTone2,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeader(
              index: index,
              region: region,
            ),
            verticalSpacer(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                provider.masteryList.isNotEmpty
                    ? SizedBox(
                        height: 90,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  width: 70,
                                  height: 70,
                                  imageUrl: UrlBuilder.championIcon(provider.getChampionImage(provider.masteryList[1].championId), provider.apiVersion),
                                  placeholder: (context, url) => const CircularProgressIndicator(
                                    color: primaryGold,
                                    strokeWidth: 3,
                                  ),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: secondaryDarkblue,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(color: primaryGold, width: 1),
                                ),
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 3),
                                    child: Text(
                                      "2",
                                      style: textSmall,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
                provider.masteryList.isNotEmpty
                    ? SizedBox(
                        height: 100,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  width: 90,
                                  height: 90,
                                  imageUrl: UrlBuilder.championIcon(provider.getChampionImage(provider.masteryList[0].championId), provider.apiVersion),
                                  placeholder: (context, url) => const CircularProgressIndicator(
                                    color: primaryGold,
                                    strokeWidth: 3,
                                  ),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: secondaryDarkblue,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(color: primaryGold, width: 1),
                                ),
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 3),
                                    child: Text(
                                      "1",
                                      style: textSmall,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
                provider.masteryList.length >= 3
                    ? SizedBox(
                        height: 90,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  width: 70,
                                  height: 70,
                                  imageUrl: UrlBuilder.championIcon(provider.getChampionImage(provider.masteryList[2].championId), provider.apiVersion),
                                  placeholder: (context, url) => const CircularProgressIndicator(
                                    color: primaryGold,
                                    strokeWidth: 3,
                                  ),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: secondaryDarkblue,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(color: primaryGold, width: 1),
                                ),
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 3),
                                    child: Text(
                                      "3",
                                      style: textSmall,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            verticalSpacer(20),
            const Center(
              child: Text(
                "Ranked Info",
                style: textSmall,
              ),
            ),
            verticalSpacer(10),
            provider.rankList.isNotEmpty
                ? Column(
                    children: [
                      Center(
                        child: Text(
                          'Queue: ${provider.rankList[0].queueType}',
                          style: label,
                        ),
                      ),
                      Center(
                        child: Text(
                          'Tier: ${provider.rankList[0].tier}',
                          style: label,
                        ),
                      ),
                      Center(
                        child: Text(
                          'Rank: ${provider.rankList[0].rank}',
                          style: label,
                        ),
                      ),
                    ],
                  )
                : Container(),
            verticalSpacer(20),
            const Center(
              child: Text(
                "Last 3 matches",
                style: textSmall,
              ),
            ),
            verticalSpacer(10),
            provider.myMatchStats.isNotEmpty && provider.myMatchStats.length > 2
                ? Column(
                    children: [
                      Center(
                        child: Text(
                          provider.myMatchStats[0].championName,
                          style: label,
                        ),
                      ),
                      Center(
                        child: Text(
                          "${provider.myMatchStats[0].kills}/${provider.myMatchStats[0].deaths}/${provider.myMatchStats[0].assists}",
                          style: label,
                        ),
                      ),
                      Center(
                        child: CachedNetworkImage(
                          width: 20,
                          height: 20,
                          imageUrl: UrlBuilder.itemImage(provider.myMatchStats[0].item0, provider.apiVersion),
                          placeholder: (context, url) => const CircularProgressIndicator(
                            color: primaryGold,
                            strokeWidth: 3,
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                      verticalSpacer(10),
                      Center(
                        child: Text(
                          provider.myMatchStats[1].championName,
                          style: label,
                        ),
                      ),
                      Center(
                        child: Text(
                          "${provider.myMatchStats[1].kills}/${provider.myMatchStats[1].deaths}/${provider.myMatchStats[1].assists}",
                          style: label,
                        ),
                      ),
                      Center(
                        child: CachedNetworkImage(
                          width: 20,
                          height: 20,
                          imageUrl: UrlBuilder.itemImage(provider.myMatchStats[1].item0, provider.apiVersion),
                          placeholder: (context, url) => const CircularProgressIndicator(
                            color: primaryGold,
                            strokeWidth: 3,
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                      verticalSpacer(10),
                      Center(
                        child: Text(
                          provider.myMatchStats[2].championName,
                          style: label,
                        ),
                      ),
                      Center(
                        child: Text(
                          "${provider.myMatchStats[2].kills}/${provider.myMatchStats[2].deaths}/${provider.myMatchStats[2].assists}",
                          style: label,
                        ),
                      ),
                      Center(
                        child: CachedNetworkImage(
                          width: 20,
                          height: 20,
                          imageUrl: UrlBuilder.itemImage(provider.myMatchStats[2].item0, provider.apiVersion),
                          placeholder: (context, url) => const CircularProgressIndicator(
                            color: primaryGold,
                            strokeWidth: 3,
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
