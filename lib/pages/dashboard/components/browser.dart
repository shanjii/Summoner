import 'package:flutter/material.dart';
import 'package:league_checker/pages/viewer/viewer.dart';
import 'package:league_checker/providers/data_provider.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/url_builder.dart';
import 'package:provider/provider.dart';

class Browser extends StatefulWidget {
  const Browser({Key? key}) : super(key: key);

  @override
  _BrowserState createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  late DataProvider provider;

  TextEditingController searchController = TextEditingController();
  bool retrievingUser = false;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<DataProvider>(context);

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
      Navigator.of(context).push(pageBuilder());
    }
    setState(() => retrievingUser = false);
  }

  pageBuilder() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => ViewerPage(index: -1, region: provider.region),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
