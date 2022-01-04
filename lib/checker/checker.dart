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
  late CheckerRepository vm;

  @override
  void initState() {
    super.initState();
    context.read<CheckerRepository>().updateBackground();
    context.read<CheckerRepository>().updateSummonerList();
  }

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<CheckerRepository>(context);
    vm.getDeviceDimensions(context);

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
                        "assets/images/backgrounds/${vm.background}.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    verticalSpacer(vm.statusBarHeight + 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () =>
                                openBackgroundSelector(vm.statusBarHeight),
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
                    Browser(vm: vm),
                    verticalSpacer(20),
                    MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: SizedBox(
                        height: vm.height - vm.statusBarHeight - 290,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (index == vm.summonerList.length) {
                              return CardEmpty(
                                vm: vm,
                              );
                            } else {
                              return CardSummoner(
                                summoner: vm.summonerList[index],
                                vm: vm,
                              );
                            }
                          },
                          itemCount: vm.summonerList.length + 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              top: vm.showUserNotFound == false ? -30 : vm.statusBarHeight + 15,
              curve: Curves.easeOut,
              child: Container(
                height: 30,
                width: vm.width - 100,
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

  openBackgroundSelector(statusBarHeight) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BackgroundSelector(
          statusBarHeight: statusBarHeight,
          selected: vm.background,
          vm: vm,
        );
      },
      backgroundColor: primaryDarkblue,
    );
  }
}
