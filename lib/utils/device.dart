import 'package:flutter/cupertino.dart';

class Device {
  Device(this.context);
  BuildContext context;

  late double statusBarHeight = MediaQuery.of(context).padding.top;
  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height;
}
