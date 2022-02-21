import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:league_checker/models/summoner_model.dart';
import 'package:league_checker/pages/viewer/components/mastery-card.dart';
import 'package:league_checker/pages/viewer/components/profile-banner.dart';
import 'package:league_checker/pages/viewer/components/profile-header.dart';
import 'package:league_checker/providers/data_provider.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:provider/provider.dart';

class ViewerPage extends StatelessWidget {
  const ViewerPage({Key? key, required this.index, required this.region, this.summoner}) : super(key: key);
  final int index;
  final String region;
  final SummonerModel? summoner;

  @override
  Widget build(BuildContext context) {

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
                const MasteryCard(),
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
}
