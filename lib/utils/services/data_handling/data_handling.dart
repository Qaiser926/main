import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../modules/models/favourite_event_and_activity/favourite_single_event_or_activity/favourite_event_or_activity.dart';
import '../../../modules/models/shared_data_models.dart';

Image getPhotoNullSave(
    {required String categoryId,
    required double width,
    required double height,
    String? photo}) {
  if (photo != null) {
    return Image.memory(
      base64Decode(photo),
      width: width,
      height: height,
    );
  } else {
    return getAssetImage("$categoryId.jpg", width: width, height: height)
        as Image;
  }
}

String getTimeInformation({required BuildContext context, String? startTimeUtc, OpeningTimeCode? openingTimeCode}) {
  if (startTimeUtc != null) {
    return getLocalTime(startTimeUtc: startTimeUtc, context: context);
  } else {
    return languageSensibleOpeningTimeCode(openingTimeCode: openingTimeCode!, context: context);

  }
}

String getLocalTime({required String startTimeUtc, required BuildContext context}) {
  final DateTime now = DateTime.now();
  final utcInLocal = DateTime.parse(startTimeUtc);
  final startDatetimeUtc = DateTime.utc(utcInLocal.year, utcInLocal.month,
      utcInLocal.day, utcInLocal.hour, utcInLocal.minute);
  final startTimeLocal = startDatetimeUtc.subtract(-now.timeZoneOffset);
  final String weekday = getWeekday(weekDayNumber: startTimeLocal.weekday, context: context)[1];
  if (now.year == startTimeLocal.year) {
    return "$weekday, ${startTimeLocal.day.toString().padLeft(2, '0')}.${startTimeLocal.month.toString().padLeft(2, '0')}, ${startTimeLocal.hour.toString().padLeft(2, '0')}:${startTimeLocal.minute.toString().padLeft(2, '0')}";
  } else {
    return  "$weekday, ${startTimeLocal.day.toString().padLeft(2, '0')}.${startTimeLocal.month.toString().padLeft(2, '0')}.${startTimeLocal.year}, ${startTimeLocal.hour.toString().padLeft(2, '0')}:${startTimeLocal.minute.toString().padLeft(2, '0')}";
  }
}



List<String> getWeekday({required int weekDayNumber, required BuildContext context}) {

    Map weekDayDict = {
      1: [AppLocalizations.of(context)!.monday, AppLocalizations.of(context)!.mondayShort],
      2: [AppLocalizations.of(context)!.tuesday, AppLocalizations.of(context)!.tuesdayShort],
      3: [AppLocalizations.of(context)!.wednesday, AppLocalizations.of(context)!.wednesdayShort],
      4: [AppLocalizations.of(context)!.thursday, AppLocalizations.of(context)!.thursdayShort],
      5: [AppLocalizations.of(context)!.friday, AppLocalizations.of(context)!.fridayShort],
      6: [AppLocalizations.of(context)!.saturday, AppLocalizations.of(context)!.saturdayShort],
      7: [AppLocalizations.of(context)!.sunday, AppLocalizations.of(context)!.sundayShort]
    };
    return weekDayDict[weekDayNumber]!;
}

String languageSensibleOpeningTimeCode({required OpeningTimeCode openingTimeCode, required BuildContext context}) {

  Map weekDayDict = {
    "open": AppLocalizations.of(context)!.open,
    "closed": AppLocalizations.of(context)!.closed,
    "openSoon": AppLocalizations.of(context)!.openSoon,
    "closedSoon": AppLocalizations.of(context)!.closedSoon,
  };
  // weird code below necessary to get the enum name and access the dictionary
  return weekDayDict[openingTimeCode.toString().substring(openingTimeCode.toString().indexOf('.') + 1)]!;
}
