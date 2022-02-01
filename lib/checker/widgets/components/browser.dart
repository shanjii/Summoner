import 'package:flutter/material.dart';
import 'package:league_checker/checker/widgets/modals/summoner_viewer.dart';
import 'package:league_checker/repositories/checker_repository.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/spacer.dart';
import 'package:league_checker/utils/waiter.dart';
import 'package:provider/provider.dart';

class Browser extends StatefulWidget {
  const Browser({Key? key}) : super(key: key);

  @override
  _BrowserState createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  late CheckerRepository checkerRepository;

  TextEditingController searchController = TextEditingController();
  bool retrievingUser = false;

  @override
  Widget build(BuildContext context) {
    checkerRepository = Provider.of<CheckerRepository>(context);

    return Container(
      color: darkGrayTone2,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 8),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white24,
              ),
              height: 40,
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
                    contentPadding: EdgeInsets.only(bottom: 8),
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
        await checkerRepository.getSummonerData(searchController.text);
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
      setState(() => retrievingUser = false);
    } else {
      setState(() => retrievingUser = false);
      await checkerRepository.setError("Summoner not found");
    }
  }
}
