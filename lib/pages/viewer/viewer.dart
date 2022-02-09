import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:league_checker/pages/viewer/components/mastery-card.dart';
import 'package:league_checker/pages/viewer/components/profile-banner.dart';
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileBanner(
                  index: index,
                  region: region,
                ),
                const MasteryCard(),
              ],
            ),
          ),
          ProfileHeader(region: region)
        ],
      ),
    );
  }
}
