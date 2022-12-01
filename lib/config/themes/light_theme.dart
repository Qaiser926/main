import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData getLightThemeData() {
  return ThemeData(
    primarySwatch: Colors.red,
    primaryColor: Colors.blue,

    /// A text theme that contrasts with the primary color.
    primaryTextTheme: TextTheme(
        headline4: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp),
        headline2: TextStyle(
            fontWeight: FontWeight.w700, fontSize: 19.sp, height: 1.5.h)),

    /// Text with a color that contrasts with the card and canvas colors.
    textTheme: TextTheme(
        headline4: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp),
        headline2: TextStyle(
            fontWeight: FontWeight.w700, fontSize: 19.sp, height: 1.5.h)),
  );
}
