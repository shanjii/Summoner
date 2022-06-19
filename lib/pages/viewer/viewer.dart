import 'package:flutter/material.dart';
import 'package:league_checker/models/summoner_model.dart';
import 'package:league_checker/pages/viewer/components/norank_card.dart';
import 'package:league_checker/pages/viewer/components/rank_card.dart';
import 'package:league_checker/pages/viewer/components/profile_banner.dart';
import 'package:league_checker/pages/viewer/components/profile_header.dart';
import 'package:league_checker/providers/data_provider.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/widget.dart';
import 'package:provider/provider.dart';

class ViewerPage extends StatelessWidget {
  const ViewerPage({Key? key, required this.index, required this.region, this.summoner}) : super(key: key);
  final int index;
  final String region;
  final SummonerModel? summoner;

  @override
  Widget build(BuildContext context) {
    DataProvider provider = Provider.of<DataProvider>(context);

    return Scaffold(
      backgroundColor: darkGrayTone2,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileBanner(
                  index: index,
                  summoner: summoner,
                ),
                provider.isLoadingSummoner
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                        child: Center(
                          child: Column(
                            children: [
                              const CircularProgressIndicator(color: Colors.white),
                              verticalSpacer(10),
                              const Text(
                                "Retrieving user data...",
                                style: textSmall,
                              ),
                            ],
                          ),
                        ),
                      )
                    : rankCards(provider)
              ],
            ),
          ),
          ProfileHeader(
            summoner: summoner,
            region: region,
          )
        ],
      ),
    );
  }

  Widget rankCards(DataProvider provider) {
    return SizedBox(
      child: provider.rankList.isNotEmpty
          ? provider.rankList.length == 2
              ? Column(
                  children: [RankCard(rank: provider.rankList[0]), RankCard(rank: provider.rankList[1])],
                )
              : RankCard(rank: provider.rankList[0])
          : const NoRankCard(),
    );
  }
}
