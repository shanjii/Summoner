import 'package:flutter/material.dart';
import 'package:league_checker/checker/widgets/components/header.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/spacer.dart';
import 'package:provider/provider.dart';
import '../repositories/checker_repository.dart';
import 'widgets/components/browser.dart';
import 'widgets/components/cards.dart';

class CheckerPage extends StatefulWidget {
  const CheckerPage({Key? key}) : super(key: key);

  @override
  State<CheckerPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CheckerPage> {
  late CheckerRepository checkerRepository;

  @override
  void initState() {
    super.initState();
    verifyLocalFiles();
  }

  @override
  Widget build(BuildContext context) {
    checkerRepository = Provider.of<CheckerRepository>(context);
    checkerRepository.getDeviceDimensions(context);

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
                        height: checkerRepository.height -
                            checkerRepository.statusBarHeight -
                            170,
                        child: checkerRepository.summonerList.isEmpty
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
                                      checkerRepository.summonerList.length) {
                                    return const CardEmpty();
                                  } else {
                                    return CardSummoner(
                                      summoner:
                                          checkerRepository.summonerList[index],
                                    );
                                  }
                                },
                                itemCount:
                                    checkerRepository.summonerList.length + 1,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              top: checkerRepository.showUserNotFound == false
                  ? -30
                  : checkerRepository.statusBarHeight + 15,
              curve: Curves.easeOut,
              child: Container(
                height: 30,
                width: checkerRepository.width - 100,
                decoration: BoxDecoration(
                  color: primaryGoldOpacity,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                    child: Text(
                  checkerRepository.errorMessage,
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
    context.read<CheckerRepository>().checkApiVersion();
    context.read<CheckerRepository>().updateSummonerList();
  }
}
