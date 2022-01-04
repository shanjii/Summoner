import 'package:flutter/material.dart';
import 'package:league_checker/checker/widgets/background_selector.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/spacer.dart';
import 'package:provider/provider.dart';
import '../repositories/checker_repository.dart';
import 'widgets/browser.dart';
import 'widgets/cards.dart';
import 'widgets/logo.dart';

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
    context.read<CheckerRepository>().updateBackground();
    context.read<CheckerRepository>().updateSummonerList();
  }

  @override
  Widget build(BuildContext context) {
    checkerRepository = Provider.of<CheckerRepository>(context);
    checkerRepository.getDeviceDimensions(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: primaryDarkblue,
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox.expand(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: const ColorFilter.mode(
                        primaryDarkblueOpacity, BlendMode.srcOver),
                    image: AssetImage(
                        "assets/images/backgrounds/${checkerRepository.background}.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    verticalSpacer(checkerRepository.statusBarHeight + 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => openBackgroundSelector(),
                            child: const Icon(
                              Icons.wallpaper,
                              color: primaryGold,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
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
                            290,
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
                  color: primaryGold,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                    child: Text(
                  'Summoner not found.',
                  style: label,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  openBackgroundSelector() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const BackgroundSelector();
      },
      backgroundColor: primaryDarkblue,
    );
  }
}
