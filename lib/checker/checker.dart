import 'package:flutter/material.dart';
import 'package:league_checker/api/summoner_api.dart';
import 'package:league_checker/checker/widgets/modals/background_selector.dart';
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
  late List<Image> backgrounds = [];

  @override
  void initState() {
    super.initState();
    verifyLocalFiles();
    loadBackgrounds();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (var background in backgrounds) {
      precacheImage(background.image, context);
    }
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
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
                        SizedBox(
                          height: 30,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: checkerRepository.updatingDevice
                                ? const Icon(
                                    Icons.connect_without_contact_rounded,
                                    color: primaryGold,
                                    size: 30,
                                  )
                                : Column(
                                    children: [
                                      const Text(
                                        "Patch",
                                        style: textTiny,
                                      ),
                                      Text(
                                        checkerRepository.apiVersion,
                                        style: label,
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ],
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
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const BackgroundSelector();
      },
      backgroundColor: Colors.transparent,
    );
  }

  verifyLocalFiles() {
    context.read<CheckerRepository>().updateBackground();
    context.read<CheckerRepository>().checkApiVersion();
    context.read<CheckerRepository>().updateSummonerList();
  }

  loadBackgrounds() {
    backgrounds.add(Image.asset("assets/images/backgrounds/rengar.jpg"));
    backgrounds.add(Image.asset("assets/images/backgrounds/aatrox.jpg"));
    backgrounds.add(Image.asset("assets/images/backgrounds/mordekaiser.jpg"));
  }
}
