import 'package:flutter/widgets.dart';
import 'package:league_checker/providers/data_provider.dart';
import 'package:league_checker/style/color_palette.dart';
import 'package:provider/provider.dart';

class MasteryCard extends StatefulWidget {
  const MasteryCard({Key? key}) : super(key: key);

  @override
  _MasteryCardState createState() => _MasteryCardState();
}

class _MasteryCardState extends State<MasteryCard> {
  @override
  Widget build(BuildContext context) {
    DataProvider provider = Provider.of<DataProvider>(context);

    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: darkGrayTone3,
      ),
      height: 2120,
    );
  }
}
