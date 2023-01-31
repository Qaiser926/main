import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';

class NoAnimationColor extends MaterialStateColor {
  const NoAnimationColor() : super(_pressedColor);

  static const int _pressedColor = 0x006666;

  @override
  Color resolve(Set<MaterialState> states) {
    return const Color(_pressedColor);
  }
}

ThemeData getDarkThemeData() {
  return ThemeData(
    colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: primaryColor,
        onPrimary: Colors.white,
        secondary: bgColor,
        onSecondary: Colors.green,
        error: Colors.red,
        onError: Colors.white,
        background: bgColor,
        onBackground: Colors.yellow,
        surface: bgColor,
        onSurface: Colors.white,
        tertiary: listItemColor),
    iconTheme: IconThemeData(color: primaryColor),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
      backgroundColor: Colors.transparent,
    ),
    tabBarTheme: TabBarTheme(
      splashFactory: NoSplash.splashFactory,
      overlayColor: const NoAnimationColor(),
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(44.h),
        color: primaryColor,
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Colors.white,
      labelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),
      unselectedLabelColor: Colors.white70,
      unselectedLabelStyle:
          TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),
    ),
    scaffoldBackgroundColor: bgColor,
    // backgroundColor: bgColor,
    // scaffoldBackgroundColor: bgColor,
    // brightness: Brightness.dark,
    /// A text theme that contrasts with the primary color.

    primaryTextTheme: TextTheme(
      headlineSmall: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp),
      headlineMedium:
          const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
      headlineLarge:
          TextStyle(fontWeight: FontWeight.w700, fontSize: 19.sp, height: 1.h),
      labelSmall: const TextStyle(overflow: TextOverflow.visible),
      labelMedium: const TextStyle(color: Colors.grey),
    ),

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
