import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:league_checker/repositories/checker_repository.dart';
import 'package:league_checker/checker/widgets/summoner_viewer.dart';
import 'package:league_checker/model/summoner_model.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/spacer.dart';
import 'package:league_checker/utils/waiter.dart';
import 'add_summoner.dart';

class CardEmpty extends StatelessWidget {
  const CardEmpty({Key? key, required this.vm}) : super(key: key);
  final CheckerRepository vm;

  showAddSummoner(context) async {
    await wait(200);
    showModalBottomSheet(
      barrierColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      backgroundColor: primaryDarkblue,
      builder: (BuildContext context) {
        return AddSummoner(
          vm: vm,
        );
      },
    );
  }

  showRemoveSummoner(context) {
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
                vm.removeSummonerList();
                Navigator.pop(context);
              },
              child: const Text('REMOVE'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 5),
          child: Material(
            color: Colors.grey.withOpacity(0.2),
            child: InkWell(
              onTap: () {
                showRemoveSummoner(context);
              },
              child: SizedBox(
                width: (vm.width / 2) - 80,
                height: 102,
                child: const Icon(
                  Icons.delete_outline,
                  size: 40,
                  color: primaryGold,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 30, left: 5),
          child: Material(
            color: Colors.grey.withOpacity(0.2),
            child: InkWell(
              onTap: () {
                showAddSummoner(context);
              },
              child: SizedBox(
                width: (vm.width / 2) + 10,
                height: 102,
                child: const Icon(
                  Icons.add,
                  size: 40,
                  color: primaryGold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CardSummoner extends StatefulWidget {
  const CardSummoner({Key? key, required this.summoner, required this.vm})
      : super(key: key);
  final CheckerRepository vm;
  final SummonerModel summoner;

  @override
  _CardSummonerState createState() => _CardSummonerState();
}

class _CardSummonerState extends State<CardSummoner> {
  bool retrievingUser = false;

  openSummonerCard(summonerName, statusBarHeight) async {
    setState(() => retrievingUser = true);
    var response = await widget.vm.getSummonerData(summonerName);
    if (response == 200) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SummonerViewer(vm: widget.vm);
        },
        backgroundColor: primaryDarkblue,
        isScrollControlled: true,
      );
      await wait(200);
    }
    setState(() => retrievingUser = false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 30, right: 30),
      child: Material(
        color: primaryDarkblue,
        child: InkWell(
          onTap: () =>
              openSummonerCard(widget.summoner.name, widget.vm.statusBarHeight),
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: Row(
                  children: [
                    horizontalSpacer(15),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: primaryGold, width: 2),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            width: 60,
                            height: 60,
                            imageUrl:
                                "http://ddragon.leagueoflegends.com/cdn/11.23.1/img/profileicon/${widget.summoner.profileIconId}.png",
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
                    ),
                    horizontalSpacer(20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.summoner.name,
                          style: cardName,
                        ),
                        verticalSpacer(5),
                        Text(
                            "Level: " +
                                widget.summoner.summonerLevel.toString(),
                            style: cardLevel)
                      ],
                    ),
                    const Spacer(),
                    retrievingUser == true
                        ? const CircularProgressIndicator()
                        : const Icon(
                            Icons.exit_to_app_rounded,
                            color: primaryGold,
                            size: 40,
                          ),
                    horizontalSpacer(15)
                  ],
                ),
              ),
              Container(
                height: 2,
                color: primaryGold,
              )
            ],
          ),
        ),
      ),
    );
  }
}
