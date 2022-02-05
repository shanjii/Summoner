import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:league_checker/providers/summoner_provider.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late SummonerProvider summonerProvider;
    summonerProvider = Provider.of<SummonerProvider>(context);

    return Container(
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
            width: summonerProvider.width,
            child: summonerProvider.masteryList.isNotEmpty
                ? CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:
                        "http://ddragon.leagueoflegends.com/cdn/img/champion/splash/${summonerProvider.getChampionImage(summonerProvider.masteryList[0].championId)}_0.jpg",
                    placeholder: (context, url) => Container(
                      color: Colors.white10,
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  )
                : const SizedBox(),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, summonerProvider.statusBarHeight + 10, 0, 0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: primaryGold,
                    size: 40,
                  ),
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
                        imageUrl: "http://ddragon.leagueoflegends.com/cdn/11.23.1/img/profileicon/${summonerProvider.summonerData.profileIconId}.png",
                        placeholder: (context, url) => const CircularProgressIndicator(
                          color: primaryGold,
                          strokeWidth: 10,
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
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
                        border: Border.all(color: primaryGold, width: 2),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 3),
                          child: Text(
                            summonerProvider.summonerData.summonerLevel.toString(),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(
                summonerProvider.summonerData.name,
                style: textMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
