import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:league_checker/providers/summoner_provider.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/summoner/widgets/components/error_dropdown.dart';
import 'package:league_checker/utils/widget.dart';
import 'package:league_checker/utils/misc.dart';
import 'package:provider/provider.dart';

class AddSummoner extends StatefulWidget {
  const AddSummoner({Key? key}) : super(key: key);

  @override
  _AddSummonerState createState() => _AddSummonerState();
}

class _AddSummonerState extends State<AddSummoner> {
  late SummonerProvider summonerProvider;

  TextEditingController addFavoriteController = TextEditingController();
  bool retrievingUser = false;
  bool addedUser = false;

  double keyboardHeight = 0;
  @override
  Widget build(BuildContext context) {
    summonerProvider = Provider.of<SummonerProvider>(context);

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      right: summonerProvider.showAddSummoner ? 0 : -summonerProvider.width,
      child: Container(
        color: darkGrayTone4,
        height: summonerProvider.height,
        width: summonerProvider.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  10, summonerProvider.statusBarHeight + 10, 15, 0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          retrievingUser == false
                              ? summonerProvider.activateAddSummonerScreen(
                                  false, context)
                              : null;
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            verticalSpacer(30),
            const Center(
              child: Text(
                'Highlight a Summoner:',
                style: textMedium,
                textAlign: TextAlign.center,
              ),
            ),
            verticalSpacer(30),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30),
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
                  controller: addFavoriteController,
                  style: input,
                  focusNode: summonerProvider.addSummonerKeyboardFocus,
                  cursorColor: Colors.white,
                  onSubmitted: (value) {
                    retrieveFavoriteUser();
                  },
                  textInputAction: TextInputAction.search,
                  decoration: const InputDecoration(
                    hintText: 'Summoner name',
                    hintStyle: label,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            verticalSpacer(40),
            Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        retrievingUser == false ? retrieveFavoriteUser() : {};
                      },
                      child: retrievingUser == true
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : addedUser == true
                              ? const Icon(
                                  Icons.task_alt_rounded,
                                  color: Colors.green,
                                  size: 50,
                                )
                              : const Icon(
                                  Icons.add_circle_outline,
                                  size: 50,
                                  color: Colors.white,
                                ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  retrieveFavoriteUser() async {
    setState(() => retrievingUser = true);
    var response =
        await summonerProvider.addFavoriteSummoner(addFavoriteController.text);
    if (response == 200) {
      setState(() {
        addedUser = true;
        retrievingUser = false;
      });
      await wait(1300);
      summonerProvider.activateAddSummonerScreen(false, context);
      setState(() => addedUser = false);
      addFavoriteController.text = '';
    } else if (response == 404) {
      setState(() => retrievingUser = false);
      await summonerProvider.setError("Summoner not found");
    } else if (response == 403) {
      setState(() => retrievingUser = false);
      await summonerProvider.setError("Type in a Summoner");
    } else if (response == 500) {
      setState(() => retrievingUser = false);
      await summonerProvider.setError("Network error");
    } else {
      setState(() => retrievingUser = false);
      await summonerProvider.setError("Unknown error");
    }
  }
}
