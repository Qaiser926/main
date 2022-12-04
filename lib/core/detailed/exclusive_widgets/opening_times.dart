import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/config/themes/color_data.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:othia/widgets/openingtimes.dart';

import '../../../utils/ui/ui_utils.dart';

class OpeningTimesSection extends StatelessWidget {
  final Map openingTime;

  const OpeningTimesSection({super.key, required this.openingTime});

  @override
  Widget build(BuildContext context) {
    return  Column(
    children: [
    Row(
    children: [
        getHorSpace(20),
    getCustomFont(
    text: AppLocalizations.of(context)!.openingHours,
    fontSize: getFontSize(fontSizeType: "headerFontSize"),
    color: greyColor),

    ],
    ),OpeningTimes(openingTime: openingTime)
    ],);
  }}