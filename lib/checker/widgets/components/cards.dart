import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:league_checker/checker/widgets/modals/add_summoner.dart';
import 'package:league_checker/checker/widgets/modals/summoner_viewer.dart';
import 'package:league_checker/repositories/checker_repository.dart';
import 'package:league_checker/model/summoner_model.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/spacer.dart';
import 'package:league_checker/utils/waiter.dart';
import 'package:provider/provider.dart';

class CardEmpty extends StatelessWidget {
  const CardEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late CheckerRepository checkerRepository;
    checkerRepository = Provider.of<CheckerRepository>(context);

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 5),
          child: Material(
            color: Colors.grey.withOpacity(0.2),
            child: InkWell(
              onTap: () {
                showRemoveSummoner(context, checkerRepository);
              },
              child: SizedBox(
                width: (checkerRepository.width / 2) - 80,
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
                width: (checkerRepository.width / 2) + 10,
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

  showAddSummoner(context) async {
    await wait(200);
    showModalBottomSheet(
      barrierColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      backgroundColor: primaryDarkblue,
      builder: (BuildContext context) {
        return const AddSummoner();
      },
    );
  }

  showRemoveSummoner(context, checkerRepository) {
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
                checkerRepository.removeSummonerList();
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
  late CheckerRepository checkerRepository;

  bool retrievingCardUser = false;

  @override
  Widget build(BuildContext context) {
    checkerRepository = Provider.of<CheckerRepository>(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 30, right: 30),
      child: Material(
        color: primaryDarkblue,
        child: InkWell(
          onTap: () => openSummonerCard(widget.summoner.name),
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
                          style: textSmall,
                        ),
                        verticalSpacer(5),
                        Text(
                            "Level: " +
                                widget.summoner.summonerLevel.toString(),
                            style: label)
                      ],
                    ),
                    const Spacer(),
                    retrievingCardUser == true
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

  openSummonerCard(summonerName) async {
    if (!checkerRepository.isLoadingSummoner) {
      setState(() => retrievingCardUser = true);
      var response = await checkerRepository.getSummonerData(summonerName);
      if (response == 200) {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return const SummonerViewer();
          },
          backgroundColor: primaryDarkblue,
          isScrollControlled: true,
        );
        await wait(200);
      }
      setState(() => retrievingCardUser = false);
    }
  }
}
