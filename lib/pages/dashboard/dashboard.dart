import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:league_checker/pages/dashboard/components/browser.dart';
import 'package:league_checker/pages/dashboard/components/empty_card.dart';
import 'package:league_checker/pages/dashboard/components/error_dropdown.dart';
import 'package:league_checker/pages/dashboard/components/header.dart';
import 'package:league_checker/providers/data_provider.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/pages/dashboard/components/summoner_card.dart';
import 'package:league_checker/pages/dashboard/modals/add_summoner.dart';
import 'package:league_checker/utils/device.dart';
import 'package:league_checker/utils/misc.dart';
import 'package:league_checker/utils/widget.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DashboardPage> {
  late DataProvider provider;
  double surprise = 0;

  @override
  void initState() {
    super.initState();
    verifyLocalFiles();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<DataProvider>(context);
    provider.device = Device(context);

    return WillPopScope(
      onWillPop: () {
        if (!provider.showAddSummoner) {
          surprise++;
          if (surprise > 20) {
            provider.setError("Why are you running?");
            surprise = 0;
          }
        }
        provider.activateAddSummonerScreen(false, context);
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
                provider.activateAddSummonerScreen(false, context);
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
                      child: Expanded(child: provider.summonerList.isEmpty ? noSummoner() : summonerList()),
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

  Widget noSummoner() {
    return Column(
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
    );
  }

  Widget summonerList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        if (index == provider.summonerList.length) {
          return const EmptyCard();
        } else {
          return AnimationConfiguration.staggeredList(
            delay: const Duration(milliseconds: 200),
            position: index,
            duration: const Duration(milliseconds: 900),
            child: SlideAnimation(
              horizontalOffset: -provider.device.width,
              child: SummonerCard(
                summoner: provider.summonerList[index],
                index: index,
              ),
            ),
          );
        }
      },
      itemCount: provider.summonerList.length + 1,
    );
  }

  verifyLocalFiles() {
    context.read<DataProvider>().checkApiVersion();
    context.read<DataProvider>().updateSummonerList();
  }
}
