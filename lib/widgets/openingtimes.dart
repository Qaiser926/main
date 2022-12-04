import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/config/themes/color_data.dart';
import '../utils/ui/ui_utils.dart';
import '../../utils/ui/ui_utils.dart';

class OpeningTimes extends StatelessWidget {
  final List openingTimes;


  OpeningTimes({super.key, required this.openingTimes});



  @override
  Widget build(BuildContext context) {
    openingTimesDict = getOpeningTimesDict();
    return Row(
      children: [
        Column(
          children: [
            getCustomFont(
                text: AppLocalizations.of(context)!.monday,
                color: greyColor,
                fontSize: 12),
            getVerSpace(8.h),
          ],
        )
      ],
    );
  }
}
