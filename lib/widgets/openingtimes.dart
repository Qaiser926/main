import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/services/data_handling/data_handling.dart';
import '../utils/ui/ui_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OpeningTimes extends StatelessWidget {
  final Map openingTime;

  const OpeningTimes({super.key, required this.openingTime});

  @override
  Widget build(BuildContext context) {
    // special case of always opened is marked by the list [0,0]
    return
        Container(
            child: Column(
                children: List.generate(openingTime.length, (indexOuter) {
          var rowContent = null;
          // first Case where dictionary for weekday is a list of opening hours
          if (openingTime["${indexOuter + 1}"] != null) {
            int innerListLength = openingTime["${indexOuter + 1}"].length;
            rowContent = List.generate(
              innerListLength,
              (indexInner) {
                String openingText = "";
                if ((openingTime["${indexOuter + 1}"][indexInner][0] == 0) &
                    (openingTime["${indexOuter + 1}"][indexInner][1] == 0)) {
                  openingText = AppLocalizations.of(context)!.alwaysOpen;
                } else {
                  String startTimeFormatted = formatTime(
                      unformattedTime: openingTime["${indexOuter + 1}"]
                          [indexInner][0]);
                  String endTimeFormatted = formatTime(
                      unformattedTime: openingTime["${indexOuter + 1}"]
                          [indexInner][1]);
                  openingText = "$startTimeFormatted - $endTimeFormatted";
                }
                return Row(children: [
                  Text(
                    openingText,
                    style: Theme.of(context).textTheme.headline4,
                    maxLines: 1,
                  ),

                  getVerSpace(8.h),
                ]);
              },
            );
          }
          // case where dicitonary-list for weekday is null
          else {
            rowContent = [
              Row(children: [
                Text(
                  AppLocalizations.of(context)!.closed,
                  style: Theme.of(context).textTheme.headline4,
                  maxLines: 1,
                ),

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
                  getWeekday(
                      weekDayNumber: indexOuter + 1, context: context)[0],
                  style: Theme.of(context).textTheme.headline4,
                  maxLines: 1,
                ),
                Column(children: rowContent)
              ],
            ),
          );
        })));

  }
}
