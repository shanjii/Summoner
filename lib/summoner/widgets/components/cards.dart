import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:league_checker/summoner/widgets/modals/add_summoner.dart';
import 'package:league_checker/summoner/widgets/modals/summoner_viewer.dart';
import 'package:league_checker/providers/summoner_provider.dart';
import 'package:league_checker/models/summoner_model.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/indexer.dart';
import 'package:league_checker/utils/widget.dart';
import 'package:league_checker/utils/misc.dart';
import 'package:provider/provider.dart';

class CardEmpty extends StatelessWidget {
  const CardEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late SummonerProvider summonerProvider;
    summonerProvider = Provider.of<SummonerProvider>(context);

    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Material(
                  color: darkGrayTone3,
                  child: InkWell(
                    onTap: () {
                      showRemoveSummoner(context, summonerProvider);
                    },
                    child: SizedBox(
                      width: (summonerProvider.width / 2) - 80,
                      height: 102,
                      child: const Icon(
                        Icons.delete_outline,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, left: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Material(
                  color: grayTone2,
                  child: InkWell(
                    onTap: () {
                      showAddSummoner(summonerProvider, context);
                    },
                    child: SizedBox(
                      width: (summonerProvider.width / 2),
                      height: 102,
                      child: const Icon(
                        Icons.add,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        verticalSpacer(20)
      ],
    );
  }

  showAddSummoner(SummonerProvider summonerProvider, context) async {
    // showBottomSheet(
    //   context: context,
    //   constraints: BoxConstraints(minHeight: 100),
    //   backgroundColor: darkGrayTone4,
    //   builder: (BuildContext context) {
    //     return const AddSummoner();
    //   },
    // );
    summonerProvider.activateAddSummonerScreen(true, context);
  }

  showRemoveSummoner(context, SummonerProvider summonerProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove all favorited Summoners?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                summonerProvider.removeSummonerList();
                Navigator.pop(context);
              },
              child: const Text('REMOVE'),
            )
          ],
        );
      },
    );
  }
}

class CardSummoner extends StatefulWidget {
  const CardSummoner({Key? key, required this.summoner}) : super(key: key);

  final SummonerModel summoner;

  @override
  _CardSummonerState createState() => _CardSummonerState();
}

class _CardSummonerState extends State<CardSummoner> {
  late SummonerProvider summonerProvider;

  bool retrievingCardUser = false;

  @override
  Widget build(BuildContext context) {
    summonerProvider = Provider.of<SummonerProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 30, right: 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            openSummonerCard(widget.summoner.name, widget.summoner.region);
          },
          child: SizedBox(
            height: 170,
            child: Ink(
              decoration: widget.summoner.background != ""
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            darkGrayTone2.withOpacity(0.3), BlendMode.srcOver),
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "http://ddragon.leagueoflegends.com/cdn/img/champion/splash/${widget.summoner.background}_0.jpg"),
                      ),
                    )
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: grayTone1),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    horizontalSpacer(15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          width: 60,
                          height: 60,
                          imageUrl:
                              "http://ddragon.leagueoflegends.com/cdn/11.23.1/img/profileicon/${widget.summoner.profileIconId}.png",
                          imageBuilder: (context, imageProvider) => Ink(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                image: imageProvider,
                              ),
                            ),
                          ),
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(
                            color: grayTone1,
                            strokeWidth: 2,
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        const Spacer(),
                        Ink(
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Center(
                                  child: Text(
                                    widget.summoner.summonerLevel.toString(),
                                    style: textSmallBold,
                                  ),
                                ),
                                horizontalSpacer(10),
                                Image.asset(
                                  "assets/images/regions/regionFlag-${widget.summoner.region}.png",
                                  width: 20,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    Text(
                      widget.summoner.name,
                      style: textMediumBold,
                    ),
                    verticalSpacer(10),
                    LinearProgressIndicator(
                      color: Colors.white,
                      backgroundColor: Colors.transparent,
                      value: retrievingCardUser ? null : 0,
                      minHeight: 2,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  openSummonerCard(summonerName, region) async {
    if (!summonerProvider.isLoadingSummoner) {
      setState(() => retrievingCardUser = true);
      // await summonerProvider.selectRegion(region);
      var response = await summonerProvider.getSummonerData(
          summonerName, regionIndex(region));
      if (response == 200) {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return const SummonerViewer();
          },
          backgroundColor: primaryDarkblue,
          isScrollControlled: true,
        );
      } else {
        summonerProvider.setError("Failed to retrieve Summoner");
      }
      await wait(200);
      setState(() => retrievingCardUser = false);
    }
  }
}
