import 'package:flutter/material.dart';
import 'package:othia/config/themes/dark_theme.dart';

import '../../constants/colors.dart';
import '../../utils/ui/ui_utils.dart';

Widget getHeader({required final String text}) {
  return Container(
    color: sliverListHeaderColor,
    child: Column(
      children: [
        getVerSpace(8),
        Text(
          text,
          style: getDarkThemeData().primaryTextTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        getVerSpace(8),
      ],
    ),
  );
}
