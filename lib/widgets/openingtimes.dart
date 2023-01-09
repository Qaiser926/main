import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/core/add/add_exclusives/opening_hours_selector.dart';

import '../utils/services/data_handling/data_handling.dart';
import '../utils/ui/ui_utils.dart';

class OpeningTimes extends StatelessWidget {
  final Map openingTime;
  final bool isChangeable;

  const OpeningTimes(
      {super.key, required this.openingTime, this.isChangeable = false});

  @override
  Widget build(BuildContext context) {
    // special case of always opened is marked by the list [0,0]
    return Container(
        child: Column(
            children: List.generate(openingTime.length, (indexOuter) {
      var rowContent = null;
      // index outer + 1 = weekday
      // first Case where dictionary for weekday is a list of opening hours
      if (openingTime["${indexOuter + 1}"] != null) {
        int innerListLength = openingTime["${indexOuter + 1}"].length;
        rowContent = List.generate(
          innerListLength,
          (indexInner) {
            String openingText = "";
            // e.g.: always open on Monday: "1": [[[0], [0]]]
            if ((openingTime["${indexOuter + 1}"][indexInner][0] == 0) &
                (openingTime["${indexOuter + 1}"][indexInner][1] == 0)) {
              openingText = AppLocalizations.of(context)!.alwaysOpen;
            } else {
              String startTimeFormatted = formatTime(
                  unformattedTime: openingTime["${indexOuter + 1}"][indexInner]
                      [0]);
              String endTimeFormatted = formatTime(
                  unformattedTime: openingTime["${indexOuter + 1}"][indexInner]
                      [1]);
              openingText = "$startTimeFormatted - $endTimeFormatted";
            }
            return Row(children: [
              Text(
                openingText,
                style: Theme.of(context).textTheme.headlineSmall,
                maxLines: 1,
              ),
              getVerSpace(8.h),
              if (isChangeable)
                getEditOpeningTimeButton(
                    weekDay: indexOuter + 1, context: context),
            ]);
          },
        );
      }
      // case where dicitonary-list for weekday is null or the list is empty, both indicating activity is closed
      // e.g. closed on Tuesday "2": [] or "2": null
      if (rowContent == null) rowContent = [];
      if (rowContent.isEmpty) {
        rowContent = [
          Row(children: [
            Text(
              AppLocalizations.of(context)!.closed,
              style: Theme.of(context).textTheme.headlineSmall,
              maxLines: 1,
            ),
            if (isChangeable)
              getEditOpeningTimeButton(
                  weekDay: indexOuter + 1, context: context),
          ])
        ];
      }

      return Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getWeekday(weekDayNumber: indexOuter + 1, context: context)[0],
              style: Theme.of(context).textTheme.headlineSmall,
              maxLines: 1,
            ),
            Column(children: rowContent)
          ],
        ),
      );
    })));
  }
}
