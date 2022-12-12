import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:othia/widgets/status_bar.dart';

import '../config/routes/routes.dart';
import '../utils/ui/ui_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _getIsFirst();
  }

  _getIsFirst() async {
    await Future.delayed(const Duration(seconds: 1));
    Get.toNamed(
      Routes.searchRoute,
      arguments: "as",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getColorStatusBar(),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: getAssetImage("splash_logo.png", width: 220, height: 107),
        ),
      ),
    );
  }
}

initializeScreenSize(BuildContext context,
    {double width = 414, double height = 896}) {
  ScreenUtil.init(context, designSize: Size(width, height), minTextAdapt: true);
}
