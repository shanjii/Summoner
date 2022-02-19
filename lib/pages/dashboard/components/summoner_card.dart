import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:league_checker/models/summoner_model.dart';
import 'package:league_checker/pages/viewer/viewer.dart';
import 'package:league_checker/providers/data_provider.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/indexer.dart';
import 'package:league_checker/utils/misc.dart';
import 'package:league_checker/utils/url_builder.dart';
import 'package:league_checker/utils/widget.dart';
import 'package:provider/provider.dart';

class SummonerCard extends StatefulWidget {
  const SummonerCard({Key? key, required this.summoner, required this.index}) : super(key: key);

  final SummonerModel summoner;
  final int index;

  @override
  _SummonerCardState createState() => _SummonerCardState();
}

class _SummonerCardState extends State<SummonerCard> {
  late DataProvider provider;

  bool retrievingCardUser = false;
  bool deleteAction = false;
  double positionX = 0;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<DataProvider>(context);

    return SizedBox(
      height: 190,
      width: provider.device.width,
      child: AnimatedOpacity(
        opacity: deleteAction
            ? 0
            : provider.isLoadingSummoner && !retrievingCardUser
                ? 0.3
                : 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
        child: Stack(
          children: [
            deleteLayer(),
            cardLayer(),
          ],
        ),
      ),
    );
  }

  Widget deleteLayer() {
    return Padding(
      padding: const EdgeInsets.only(left: 31, right: 31, top: 1),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: positionX == 0 ? Colors.transparent : Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => tapRemove(),
          child: SizedBox(
            width: provider.device.width - 62,
            height: 168,
            child: const Padding(
              padding: EdgeInsets.only(right: 31),
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.black,
                  size: 40,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget cardLayer() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      curve: Curves.decelerate,
      left: positionX,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: 170,
            width: provider.device.width - 60,
            child: Hero(
              tag: widget.summoner.accountId + widget.index.toString(),
              child: Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onLongPress: () => longPressCover(),
                  onHorizontalDragUpdate: (details) => horizontalDragCoverUpdate(details),
                  onHorizontalDragEnd: (details) => horizontalDragCoverEnd(),
                  child: InkWell(
                    splashColor: provider.showAddSummoner ? Colors.transparent : null,
                    onTap: () => tapOpen(),
                    child: CachedNetworkImage(
                      imageUrl: UrlBuilder.championWallpaper(widget.summoner.background.isNotEmpty ? widget.summoner.background : "Teemo"),
                      imageBuilder: (context, imageProvider) => Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: imageProvider,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20, top: 20),
                                  child: CachedNetworkImage(
                                    imageUrl: UrlBuilder.profileIconUrl(widget.summoner.profileIconId, provider.apiVersion),
                                    imageBuilder: (context, imageProvider) => Ink(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: imageProvider,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.black38),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20, right: 20),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Center(
                                            child: Text(
                                              "Level ${widget.summoner.summonerLevel.toString()}",
                                              style: labelBold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                children: [
                                  Text(
                                    widget.summoner.name,
                                    style: textMediumBold,
                                  ),
                                  const Spacer(),
                                  Image.asset(
                                    UrlBuilder.flags(widget.summoner.region),
                                    width: 30,
                                  )
                                ],
                              ),
                            ),
                            verticalSpacer(20),
                          ],
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        height: 170,
                        color: grayTone2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  openSummonerCard(summonerName, accountId, region) async {
    if (!retrievingCardUser && !provider.isLoadingSummoner) {
      if (provider.recentRequests > 3) {
        provider.setError("Slow down!");
      } else {
        provider.recentRequests++;
        provider.rateLimiter();
        Navigator.of(context).push(pageBuilder());
        setState(() => retrievingCardUser = true);
        await provider.getSelectedSummonerData(summonerName, regionIndex(region));
        await provider.updateSummoner(accountId, region);
        setState(() => retrievingCardUser = false);
      }
    } else if (retrievingCardUser && provider.isLoadingSummoner) {
      Navigator.of(context).push(pageBuilder());
    }
  }

  pageBuilder() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => ViewerPage(
        index: widget.index,
        summoner: widget.summoner,
        region: widget.summoner.region,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  longPressCover() async {
    if (positionX > -30) {
      setState(() => positionX = -30);
      await wait(1000);
      setState(() => positionX = 0.1);
      await wait(300);
      setState(() => positionX = 0);
    } else {
      setState(() => positionX = 0.1);
      await wait(300);
      setState(() => positionX = 0);
    }
  }

  tapOpen() async {
    if (!provider.showAddSummoner) {
      setState(() => positionX = 0);
      openSummonerCard(widget.summoner.name, widget.summoner.accountId, widget.summoner.region);
    }
    FocusManager.instance.primaryFocus?.unfocus();
    await wait(100);
    provider.activateAddSummonerScreen(false, context);
  }

  tapRemove() async {
    setState(() => positionX = 0.1);
    await wait(300);
    setState(() => positionX = 0);
    await wait(100);
    setState(() => deleteAction = true);
    await wait(900);
    deleteAction = false;
    await provider.removeSingleSummoner(widget.index);
  }

  horizontalDragCoverEnd() async {
    if (positionX <= -40) {
      setState(() => positionX = -100);
    } else {
      setState(() => positionX = 0.1);
      await wait(300);
      setState(() => positionX = 0);
    }
  }

  horizontalDragCoverUpdate(details) async {
    if (positionX <= 10 && positionX >= -100) {
      setState(() => positionX = positionX + details.delta.dx);
    }
  }
}
