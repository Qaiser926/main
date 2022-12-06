import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/widgets/openingtimes.dart';
import '../../../utils/ui/ui_utils.dart';

class OpeningTimesSection extends StatelessWidget {
  final Map openingTime;

  const OpeningTimesSection({super.key, required this.openingTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(thickness: 3.h),
            getVerSpace(25),
            Text(
              AppLocalizations.of(context)!.openingHours,
              style: Theme.of(context).textTheme.headline2,
            ),
            getVerSpace(25),
            OpeningTimes(openingTime: openingTime)
          ],
        ));
  }
}

