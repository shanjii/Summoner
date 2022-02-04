import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
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
  double positionY = 0;

  @override
  Widget build(BuildContext context) {
    summonerProvider = Provider.of<SummonerProvider>(context);

    return KeyboardVisibilityBuilder(builder: (context, visible) {
      return AnimatedPositioned(
        duration: visible
            ? const Duration(milliseconds: 100)
            : const Duration(milliseconds: 500),
        curve: visible ? Curves.linear : Curves.easeInBack,
        bottom: summonerProvider.showAddSummoner
            ? visible
                ? -summonerProvider.height +
                    MediaQuery.of(context).viewInsets.bottom +
                    180
                : -summonerProvider.height + 180
            : -summonerProvider.height,
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            positionY = positionY + details.delta.dy;
            if (positionY > 30) {
              summonerProvider.activateAddSummonerScreen(false, context);
            }
          },
          onVerticalDragEnd: (details) {
            setState(() {
              positionY = 0;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: darkGrayTone3,
            ),
            height: summonerProvider.height,
            width: summonerProvider.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                Padding(
                  padding: const EdgeInsets.only(left: 45, right: 45),
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
        ),
      );
    });
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
