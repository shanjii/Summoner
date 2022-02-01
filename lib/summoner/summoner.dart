import 'package:flutter/material.dart';
import 'package:league_checker/summoner/widgets/components/header.dart';
import 'package:league_checker/providers/summoner_provider.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/widgetTools.dart';
import 'package:provider/provider.dart';
import 'widgets/components/browser.dart';
import 'widgets/components/cards.dart';

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

  @override
  Widget build(BuildContext context) {
    summonerProvider = Provider.of<SummonerProvider>(context);
    summonerProvider.getDeviceDimensions(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: darkGrayTone2,
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox.expand(
              child: SizedBox(
                child: Column(
                  children: [
                    const Header(),
                    const Browser(),
                    MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: SizedBox(
                        height: summonerProvider.height -
                            summonerProvider.statusBarHeight -
                            170,
                        child: summonerProvider.summonerList.isEmpty
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 200,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                            Icons.sentiment_neutral_outlined,
                                            size: 80,
                                            color: Colors.white),
                                        verticalSpacer(10),
                                        const Text(
                                          "You have no Summoners",
                                          style: textSmall,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const CardEmpty(),
                                ],
                              )
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  if (index ==
                                      summonerProvider.summonerList.length) {
                                    return const CardEmpty();
                                  } else {
                                    return CardSummoner(
                                      summoner:
                                          summonerProvider.summonerList[index],
                                    );
                                  }
                                },
                                itemCount:
                                    summonerProvider.summonerList.length + 1,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              top: summonerProvider.showUserNotFound == false
                  ? -30
                  : summonerProvider.statusBarHeight + 15,
              curve: Curves.easeOut,
              child: Container(
                height: 30,
                width: summonerProvider.width - 100,
                decoration: BoxDecoration(
                  color: primaryGoldOpacity,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                    child: Text(
                  summonerProvider.errorMessage,
                  style: label,
                )),
              ),
            ),
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
