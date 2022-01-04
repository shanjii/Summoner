import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:league_checker/repositories/checker_repository.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/spacer.dart';

class SummonerViewer extends StatelessWidget {
  const SummonerViewer({Key? key, required this.vm}) : super(key: key);
  final CheckerRepository vm;

  @override
  Widget build(BuildContext context) {
    List myStats = [];

    vm.matchList
        .sort((b, a) => a.info.gameCreation.compareTo(b.info.gameCreation));

    if (vm.matchList.isNotEmpty) {
      for (var match in vm.matchList) {
        for (var participant in match.info.participants) {
          if (participant.puuid == vm.summonerData.puuid) {
            myStats.add(participant);
          }
        }
      }
    }

    getChampionImage(championId) {
      for (var element in vm.championList) {
        if (element.key == championId.toString()) {
          return element.image.full.replaceAll('.png', '');
        }
      }
      return 'Undefined';
    }

    return SizedBox.expand(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: primaryGold),
                ),
              ),
              height: 300,
              child: Stack(
                children: [
                  SizedBox(
                    height: 300,
                    child: vm.masteryList.isNotEmpty
                        ? CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                "http://ddragon.leagueoflegends.com/cdn/img/champion/splash/${getChampionImage(vm.masteryList[0].championId)}_0.jpg",
                            placeholder: (context, url) => Container(
                              color: Colors.white10,
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )
                        : const SizedBox(),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(10, vm.statusBarHeight + 10, 0, 0),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.close,
                          color: primaryGold,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 100,
                      height: 130,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: primaryGold, width: 2),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                width: 100,
                                height: 100,
                                imageUrl:
                                    "http://ddragon.leagueoflegends.com/cdn/11.23.1/img/profileicon/${vm.summonerData.profileIconId}.png",
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(
                                  color: primaryGold,
                                  strokeWidth: 10,
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: 60,
                              height: 30,
                              decoration: BoxDecoration(
                                color: secondaryDarkblue,
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: primaryGold, width: 2),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    vm.summonerData.summonerLevel.toString(),
                                    style: level,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Text(
                        vm.summonerData.name,
                        style: title,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            verticalSpacer(20),
            const Center(
              child: Text(
                "Top Masteries",
                style: titleSmall,
              ),
            ),
            verticalSpacer(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                vm.masteryList.isNotEmpty
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
                                      "http://ddragon.leagueoflegends.com/cdn/11.24.1/img/champion/${getChampionImage(vm.masteryList[1].championId)}.png",
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
                                      style: level,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
                vm.masteryList.isNotEmpty
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
                                      "http://ddragon.leagueoflegends.com/cdn/11.24.1/img/champion/${getChampionImage(vm.masteryList[0].championId)}.png",
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
                                      style: level,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
                vm.masteryList.isNotEmpty
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
                                      "http://ddragon.leagueoflegends.com/cdn/11.24.1/img/champion/${getChampionImage(vm.masteryList[2].championId)}.png",
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
                                      style: level,
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
                style: titleSmall,
              ),
            ),
            verticalSpacer(10),
            vm.rankList.isNotEmpty
                ? Column(
                    children: [
                      Center(
                        child: Text(
                          'Queue: ${vm.rankList[0].queueType}',
                          style: label,
                        ),
                      ),
                      Center(
                        child: Text(
                          'Tier: ${vm.rankList[0].tier}',
                          style: label,
                        ),
                      ),
                      Center(
                        child: Text(
                          'Rank: ${vm.rankList[0].rank}',
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
                style: titleSmall,
              ),
            ),
            verticalSpacer(10),
            Center(
              child: Text(
                myStats[0].championName,
                style: label,
              ),
            ),
            Center(
              child: Text(
                "${myStats[0].kills}/${myStats[0].deaths}/${myStats[0].assists}",
                style: label,
              ),
            ),
            Center(
              child: CachedNetworkImage(
                width: 20,
                height: 20,
                imageUrl:
                    "http://ddragon.leagueoflegends.com/cdn/11.24.1/img/item/${myStats[0].item0}.png",
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
                myStats[1].championName,
                style: label,
              ),
            ),
            Center(
              child: Text(
                "${myStats[1].kills}/${myStats[1].deaths}/${myStats[1].assists}",
                style: label,
              ),
            ),
            Center(
              child: CachedNetworkImage(
                width: 20,
                height: 20,
                imageUrl:
                    "http://ddragon.leagueoflegends.com/cdn/11.24.1/img/item/${myStats[1].item0}.png",
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
                myStats[2].championName,
                style: label,
              ),
            ),
            Center(
              child: Text(
                "${myStats[2].kills}/${myStats[2].deaths}/${myStats[2].assists}",
                style: label,
              ),
            ),
            Center(
              child: CachedNetworkImage(
                width: 20,
                height: 20,
                imageUrl:
                    "http://ddragon.leagueoflegends.com/cdn/11.24.1/img/item/${myStats[2].item0}.png",
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
