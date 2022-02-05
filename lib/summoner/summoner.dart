import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:league_checker/summoner/widgets/components/error_dropdown.dart';
import 'package:league_checker/summoner/widgets/components/header.dart';
import 'package:league_checker/providers/summoner_provider.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/summoner/widgets/components/summoner_card.dart';
import 'package:league_checker/summoner/widgets/windows/add_summoner.dart';
import 'package:league_checker/utils/misc.dart';
import 'package:league_checker/utils/widget.dart';
import 'package:provider/provider.dart';
import 'widgets/components/browser.dart';
import 'widgets/components/empty_card.dart';

class SummonerPage extends StatefulWidget {
  const SummonerPage({Key? key}) : super(key: key);

  @override
  State<SummonerPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SummonerPage> {
  late SummonerProvider summonerProvider;

  @override
  void initState() {
    super.initState();
    verifyLocalFiles();
  }

  double surprise = 0;

  @override
  Widget build(BuildContext context) {
    summonerProvider = Provider.of<SummonerProvider>(context);
    summonerProvider.getDeviceDimensions(context);

    return WillPopScope(
      onWillPop: () {
        if (!summonerProvider.showAddSummoner) {
          surprise++;
          if (surprise > 20) {
            summonerProvider.setError("Why are you running?");
            surprise = 0;
          }
        }
        summonerProvider.activateAddSummonerScreen(false, context);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: darkGrayTone2,
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                await wait(100);
                summonerProvider.activateAddSummonerScreen(false, context);
              },
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    const Header(),
                    const Browser(),
                    MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: Expanded(
                        child: summonerProvider.summonerList.isEmpty
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 190,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.sentiment_neutral_outlined, size: 80, color: Colors.white),
                                        verticalSpacer(10),
                                        const Text(
                                          "You have no Summoners",
                                          style: textSmall,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const EmptyCard(),
                                ],
                              )
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  if (index == summonerProvider.summonerList.length) {
                                    return const EmptyCard();
                                  } else {
                                    return AnimationConfiguration.staggeredList(
                                      delay: const Duration(milliseconds: 200),
                                      position: index,
                                      duration: const Duration(milliseconds: 900),
                                      child: SlideAnimation(
                                        horizontalOffset: -summonerProvider.width,
                                        child: SummonerCard(
                                          summoner: summonerProvider.summonerList[index],
                                          index: index,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                itemCount: summonerProvider.summonerList.length + 1,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const AddSummoner(),
            const ErrorDropdown(),
          ],
        ),
      ),
    );
  }

  verifyLocalFiles() {
    context.read<SummonerProvider>().checkApiVersion();
    context.read<SummonerProvider>().updateSummonerList();
  }
}
