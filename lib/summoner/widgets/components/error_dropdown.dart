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
  late SummonerProvider provider;
  double positionY = 0;
  
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<SummonerProvider>(context);

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 800),
      top: provider.showError == false ? -provider.statusBarHeight - 200 : positionY - 140,
      curve: Curves.elasticOut,
      child: GestureDetector(
        onVerticalDragUpdate: (details) => verticalDrag(details),
        onVerticalDragEnd: (details) => setState(() => positionY = 0),
        child: Container(
          height: provider.statusBarHeight + 200,
          width: provider.width,
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
                        provider.errorMessage,
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

  verticalDrag(details) {
    if (provider.showError == true) {
      if (positionY <= 10) {
        setState(() => positionY = positionY + details.delta.dy);
      }
      if (positionY <= -30) {
        provider.showError = false;
        provider.clearError();
      }
    }
  }
}
