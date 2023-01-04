import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData getLightThemeData() {
  return ThemeData(
    primarySwatch: Colors.red,
    primaryColor: Colors.blue,

    /// A text theme that contrasts with the primary color.
    primaryTextTheme: TextTheme(
        headlineSmall: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp),
        headlineLarge: TextStyle(
            fontWeight: FontWeight.w700, fontSize: 19.sp, height: 1.h)),

    /// Text with a color that contrasts with the card and canvas colors.
    textTheme: TextTheme(
        headlineSmall: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp),
        headlineLarge: TextStyle(
            fontWeight: FontWeight.w700, fontSize: 19.sp, height: 1.h)),

// This is the theme of your application.
//
// Try running your application with "flutter run". You'll see the
// application has a blue toolbar. Then, without quitting the app, try
// changing the primarySwatch below to Colors.green and then invoke
// "hot reload" (press "r" in the console where you ran "flutter run",
// or simply save your changes to "hot reload" in a Flutter IDE).
// Notice that the counter didn't reset back to zero; the application
// is not restarted.
  );
}
