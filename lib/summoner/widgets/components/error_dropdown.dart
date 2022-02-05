import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:league_checker/providers/summoner_provider.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:league_checker/style/stylesheet.dart';
import 'package:league_checker/utils/widget.dart';
import 'package:provider/provider.dart';

class ErrorDropdown extends StatefulWidget {
  const ErrorDropdown({Key? key}) : super(key: key);

  @override
  State<ErrorDropdown> createState() => _ErrorDropdownState();
}

class _ErrorDropdownState extends State<ErrorDropdown> {
  double positionY = 0;
  @override
  Widget build(BuildContext context) {
    SummonerProvider summonerProvider = Provider.of<SummonerProvider>(context);
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 800),
      top: summonerProvider.showError == false ? -summonerProvider.statusBarHeight - 200 : positionY - 140,
      curve: Curves.elasticOut,
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (summonerProvider.showError == true) {
            if (positionY <= 10) {
              setState(() {
                positionY = positionY + details.delta.dy;
              });
            }
            if (positionY <= -30) {
              summonerProvider.showError = false;
              summonerProvider.clearError();
            }
          }
        },
        onVerticalDragEnd: (details) {
          setState(() {
            positionY = 0;
          });
        },
        child: Container(
          height: summonerProvider.statusBarHeight + 200,
          width: summonerProvider.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                height: 40,
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: darkGrayTone4,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.white,
                        ),
                      ),
                      horizontalSpacer(10),
                      Text(
                        summonerProvider.errorMessage,
                        style: label,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
