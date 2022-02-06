import 'package:flutter/material.dart';
import 'package:league_checker/summoner/widgets/screens/summoner_viewer.dart';
import 'package:league_checker/providers/summoner_provider.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/misc.dart';
import 'package:league_checker/utils/url_builder.dart';
import 'package:provider/provider.dart';

class Browser extends StatefulWidget {
  const Browser({Key? key}) : super(key: key);

  @override
  _BrowserState createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  late SummonerProvider provider;

  TextEditingController searchController = TextEditingController();
  bool retrievingUser = false;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<SummonerProvider>(context);

    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 18),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: grayTone2,
              ),
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 10,
                ),
                child: TextField(
                  controller: searchController,
                  style: input,
                  enabled: provider.showAddSummoner
                      ? false
                      : provider.updatingDevice
                          ? false
                          : true,
                  cursorColor: Colors.white,
                  onSubmitted: (value) {
                    retrieveUser();
                  },
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    suffixIcon: Image(image: AssetImage(UrlBuilder.flags(provider.region))),
                    hintText: provider.updatingDevice ? "Retrieving latest patch..." : "Find a Summoner",
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
    var response = await provider.getSummonerData(searchController.text);
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
    setState(() => retrievingUser = false);
  }
}
