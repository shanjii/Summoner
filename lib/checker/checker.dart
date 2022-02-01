import 'package:flutter/material.dart';
import 'package:league_checker/checker/widgets/components/header.dart';
import 'package:league_checker/checker/widgets/modals/background_selector.dart';
import 'package:league_checker/checker/widgets/modals/region_selector.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/spacer.dart';
import 'package:provider/provider.dart';
import '../repositories/checker_repository.dart';
import 'widgets/components/browser.dart';
import 'widgets/components/cards.dart';
import 'widgets/components/logo.dart';

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
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox.expand(
              child: SizedBox(
                child: Column(
                  children: [
                    verticalSpacer(checkerRepository.statusBarHeight + 20),
                    const Header(),
                    verticalSpacer(10),
                    titleLogo(),
                    verticalSpacer(20),
                    const Browser(),
                    verticalSpacer(20),
                    MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: SizedBox(
                        height: checkerRepository.height -
                            checkerRepository.statusBarHeight -
                            293,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (index ==
                                checkerRepository.summonerList.length) {
                              return const CardEmpty();
                            } else {
                              return CardSummoner(
                                summoner: checkerRepository.summonerList[index],
                              );
                            }
                          },
                          itemCount: checkerRepository.summonerList.length + 1,
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
