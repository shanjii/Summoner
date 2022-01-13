import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:league_checker/checker/widgets/components/profile-header.dart';
import 'package:league_checker/repositories/checker_repository.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/spacer.dart';
import 'package:provider/provider.dart';

class SummonerViewer extends StatelessWidget {
  const SummonerViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late CheckerRepository checkerRepository;
    checkerRepository = Provider.of<CheckerRepository>(context);

    return SizedBox.expand(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileHeader(),
            verticalSpacer(20),
            const Center(
              child: Text(
                "Top Masteries",
                style: textSmall,
              ),
            ),
            verticalSpacer(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                checkerRepository.masteryList.isNotEmpty
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
                                  imageUrl:
                                      "http://ddragon.leagueoflegends.com/cdn/11.24.1/img/champion/${checkerRepository.getChampionImage(checkerRepository.masteryList[1].championId)}.png",
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(
                                    color: primaryGold,
                                    strokeWidth: 3,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
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
                                  border:
                                      Border.all(color: primaryGold, width: 1),
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
                checkerRepository.masteryList.isNotEmpty
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
                                  imageUrl:
                                      "http://ddragon.leagueoflegends.com/cdn/11.24.1/img/champion/${checkerRepository.getChampionImage(checkerRepository.masteryList[0].championId)}.png",
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(
                                    color: primaryGold,
                                    strokeWidth: 3,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
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
                                  border:
                                      Border.all(color: primaryGold, width: 1),
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
                checkerRepository.masteryList.isNotEmpty
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
                                  imageUrl:
                                      "http://ddragon.leagueoflegends.com/cdn/11.24.1/img/champion/${checkerRepository.getChampionImage(checkerRepository.masteryList[2].championId)}.png",
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(
                                    color: primaryGold,
                                    strokeWidth: 3,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
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
                                  border:
                                      Border.all(color: primaryGold, width: 1),
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
            checkerRepository.rankList.isNotEmpty
                ? Column(
                    children: [
                      Center(
                        child: Text(
                          'Queue: ${checkerRepository.rankList[0].queueType}',
                          style: label,
                        ),
                      ),
                      Center(
                        child: Text(
                          'Tier: ${checkerRepository.rankList[0].tier}',
                          style: label,
                        ),
                      ),
                      Center(
                        child: Text(
                          'Rank: ${checkerRepository.rankList[0].rank}',
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
            Center(
              child: Text(
                checkerRepository.myMatchStats[0].championName,
                style: label,
              ),
            ),
            Center(
              child: Text(
                "${checkerRepository.myMatchStats[0].kills}/${checkerRepository.myMatchStats[0].deaths}/${checkerRepository.myMatchStats[0].assists}",
                style: label,
              ),
            ),
            Center(
              child: CachedNetworkImage(
                width: 20,
                height: 20,
                imageUrl:
                    "http://ddragon.leagueoflegends.com/cdn/11.24.1/img/item/${checkerRepository.myMatchStats[0].item0}.png",
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
                checkerRepository.myMatchStats[1].championName,
                style: label,
              ),
            ),
            Center(
              child: Text(
                "${checkerRepository.myMatchStats[1].kills}/${checkerRepository.myMatchStats[1].deaths}/${checkerRepository.myMatchStats[1].assists}",
                style: label,
              ),
            ),
            Center(
              child: CachedNetworkImage(
                width: 20,
                height: 20,
                imageUrl:
                    "http://ddragon.leagueoflegends.com/cdn/11.24.1/img/item/${checkerRepository.myMatchStats[1].item0}.png",
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
                checkerRepository.myMatchStats[2].championName,
                style: label,
              ),
            ),
            Center(
              child: Text(
                "${checkerRepository.myMatchStats[2].kills}/${checkerRepository.myMatchStats[2].deaths}/${checkerRepository.myMatchStats[2].assists}",
                style: label,
              ),
            ),
            Center(
              child: CachedNetworkImage(
                width: 20,
                height: 20,
                imageUrl:
                    "http://ddragon.leagueoflegends.com/cdn/11.24.1/img/item/${checkerRepository.myMatchStats[2].item0}.png",
                placeholder: (context, url) => const CircularProgressIndicator(
                  color: primaryGold,
                  strokeWidth: 3,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
