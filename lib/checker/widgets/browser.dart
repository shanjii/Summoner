import 'package:flutter/material.dart';
import 'package:league_checker/repositories/checker_repository.dart';
import 'package:league_checker/checker/widgets/summoner_viewer.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/spacer.dart';
import 'package:league_checker/utils/waiter.dart';

class Browser extends StatefulWidget {
  const Browser({Key? key, required this.vm}) : super(key: key);
  final CheckerRepository vm;

  @override
  _BrowserState createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  TextEditingController searchController = TextEditingController();
  bool retrievingUser = false;

  retrieveUser() async {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() => retrievingUser = true);
    var response = await widget.vm.getSummonerData(searchController.text);
    if (response == 200) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SummonerViewer(vm: widget.vm);
        },
        backgroundColor: primaryDarkblue,
        isScrollControlled: true,
      );
      await wait(200);
      setState(() => retrievingUser = false);
    } else {
      setState(() => retrievingUser = false);
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0, left: 60, right: 60),
          child: SizedBox(
            height: 50,
            child: TextField(
              controller: searchController,
              style: input,
              cursorColor: primaryGold,
              cursorHeight: 20,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(0),
                labelText: 'Search for a Summoner',
                labelStyle: label,
                alignLabelWithHint: true,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryGold),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryGold),
                ),
              ),
            ),
          ),
        ),
        verticalSpacer(20),
        SizedBox(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: primaryGold,
                highlightColor: Colors.transparent,
                onTap: () {
                  retrievingUser == false ? retrieveUser() : {};
                },
                child: retrievingUser == false
                    ? const Icon(
                        Icons.search,
                        size: 40,
                        color: primaryGold,
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
