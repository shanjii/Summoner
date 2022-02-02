import 'package:flutter/material.dart';
import 'package:league_checker/summoner/widgets/modals/summoner_viewer.dart';
import 'package:league_checker/providers/summoner_provider.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/widgetTools.dart';
import 'package:league_checker/utils/misc.dart';
import 'package:provider/provider.dart';

class Browser extends StatefulWidget {
  const Browser({Key? key}) : super(key: key);

  @override
  _BrowserState createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  late SummonerProvider summonerProvider;

  TextEditingController searchController = TextEditingController();
  bool retrievingUser = false;

  @override
  Widget build(BuildContext context) {
    summonerProvider = Provider.of<SummonerProvider>(context);

    return Container(
      color: darkGrayTone2,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 18),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white24,
              ),
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: TextField(
                  controller: searchController,
                  style: input,
                  cursorColor: Colors.white,
                  onSubmitted: (value) {
                    retrieveUser();
                  },
                  textInputAction: TextInputAction.search,
                  decoration: const InputDecoration(
                    hintText: 'Search for a Summoner...',
                    hintStyle: label,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  color: Colors.white,
                  backgroundColor: Colors.transparent,
                  value: retrievingUser ? null : 0,
                  minHeight: 2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  retrieveUser() async {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() => retrievingUser = true);
    var response =
        await summonerProvider.getSummonerData(searchController.text);
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
    } else if (response == 404) {
      await summonerProvider.setError("Summoner not found");
    } else if (response == 500) {
      await summonerProvider.setError("Network error");
    } else {
      await summonerProvider.setError("Unknown error");
    }
    setState(() => retrievingUser = false);
  }
}
