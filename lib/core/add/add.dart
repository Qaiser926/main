import 'dart:io';

import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';

class Add extends StatelessWidget {
  const Add({super.key});

  static const Widget test = Test();

  @override
  Widget build(BuildContext context) {
    sleep(Duration(seconds: 2));
    NavigatorConstants.sendToScreen(test);
    return Text("asdasds");
  }
}

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: NavigatorConstants.backToPrev(),
      child: Scaffold(
        persistentFooterButtons: [Text("data"), Text("sfsd")],
      ),
    );
  }
}
