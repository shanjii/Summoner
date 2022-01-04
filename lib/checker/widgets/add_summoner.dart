import 'package:flutter/material.dart';
import 'package:league_checker/repositories/checker_repository.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/spacer.dart';
import 'package:league_checker/utils/waiter.dart';

class AddSummoner extends StatefulWidget {
  const AddSummoner({Key? key, required this.vm}) : super(key: key);

  final CheckerRepository vm;

  @override
  _AddSummonerState createState() => _AddSummonerState();
}

class _AddSummonerState extends State<AddSummoner> {
  TextEditingController addFavoriteController = TextEditingController();
  bool retrievingUser = false;
  bool addedUser = false;

  retrieveFavoriteUser() async {
    setState(() => retrievingUser = true);
    var response =
        await widget.vm.addFavoriteSummoner(addFavoriteController.text);
    if (response == 200) {
      setState(() {
        addedUser = true;
        retrievingUser = false;
      });
      await wait(1300);
      Navigator.pop(context);
      setState(() => addedUser = false);
      addFavoriteController.text = '';
    } else {
      setState(() {
        retrievingUser = false;
      });
      widget.vm.showNotFoundMessage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.fromLTRB(10, widget.vm.statusBarHeight + 10, 0, 0),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: primaryGold,
                    size: 40,
                  ),
                ),
              ),
            ),
            verticalSpacer(30),
            const Center(
              child: Text(
                'Highlight a Summoner:',
                style: title,
                textAlign: TextAlign.center,
              ),
            ),
            verticalSpacer(30),
            Padding(
              padding: const EdgeInsets.only(left: 60, right: 60),
              child: SizedBox(
                height: 50,
                child: TextField(
                  autofocus: true,
                  controller: addFavoriteController,
                  style: input,
                  cursorColor: primaryGold,
                  cursorHeight: 20,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    labelText: 'Summoner name',
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
                              color: primaryGold,
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
                                  color: primaryGold,
                                ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          top: widget.vm.showUserNotFound == false
              ? -30
              : widget.vm.statusBarHeight + 15,
          curve: Curves.easeOut,
          child: Container(
            height: 30,
            width: widget.vm.width - 100,
            decoration: BoxDecoration(
              color: primaryGoldOpaque,
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
    );
  }
}
