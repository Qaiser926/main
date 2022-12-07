import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/widgets/dropdown_bar.dart';

import '../../../config/themes/theme_config.dart';
import '../../../constants/colors.dart';
import '../../../utils/ui/ui_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DropDownAppBar extends AppBar {
  final String appBarTitle;
  final BuildContext context;

  DropDownAppBar(
      {
        required this.appBarTitle,
        required this.context,
        super.key})
      : super(
    title: Text(appBarTitle),
    elevation: 0,
    bottom: PreferredSize(
      preferredSize: const Size(double.infinity, 50),

        child: buildDropdownBar(context: context),
      ),

  );
}
