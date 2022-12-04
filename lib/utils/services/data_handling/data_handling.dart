import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../modules/models/favourite_event_and_activity/favourite_single_event_or_activity/favourite_event_or_activity.dart';
import '../../../modules/models/shared_data_models.dart';

Image getPhotoNullSave(
    {required String categoryId,
    double? width,
    double? height,
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

String getTimeInformation(
    {required BuildContext context,
    String? startTimeUtc,
    OpeningTimeCode? openingTimeCode}) {
  if (startTimeUtc != null) {
    return getLocalTimeString(dateTimeUtc: startTimeUtc, context: context);
  } else {
    return languageSensibleOpeningTimeCode(
        openingTimeCode: openingTimeCode!, context: context);
  }
}

DateTime getLocalDateTime({required String dateTimeUtc}) {
  final DateTime now = DateTime.now();
  final utcInLocal = DateTime.parse(dateTimeUtc);
  final datetimeutc = DateTime.utc(utcInLocal.year, utcInLocal.month,
      utcInLocal.day, utcInLocal.hour, utcInLocal.minute);
  return datetimeutc.add(now.timeZoneOffset);
}

String getLocalTimeString(
    {required String dateTimeUtc, required BuildContext context}) {
  final DateTime now = DateTime.now();
  final TimeLocal = getLocalDateTime(dateTimeUtc: dateTimeUtc);
  final String weekday =
      getWeekday(weekDayNumber: TimeLocal.weekday, context: context)[1];
  if (now.year == TimeLocal.year) {
    return "$weekday, ${TimeLocal.day.toString().padLeft(2, '0')}.${TimeLocal.month.toString().padLeft(2, '0')}, ${TimeLocal.hour.toString().padLeft(2, '0')}:${TimeLocal.minute.toString().padLeft(2, '0')}";
  } else {
    return "$weekday, ${TimeLocal.day.toString().padLeft(2, '0')}.${TimeLocal.month.toString().padLeft(2, '0')}.${TimeLocal.year}, ${TimeLocal.hour.toString().padLeft(2, '0')}:${TimeLocal.minute.toString().padLeft(2, '0')}";
  }
}

List<String> getWeekday(
    {required int weekDayNumber, required BuildContext context}) {
  Map weekDayDict = {
    1: [
      AppLocalizations.of(context)!.monday,
      AppLocalizations.of(context)!.mondayShort
    ],
    2: [
      AppLocalizations.of(context)!.tuesday,
      AppLocalizations.of(context)!.tuesdayShort
    ],
    3: [
      AppLocalizations.of(context)!.wednesday,
      AppLocalizations.of(context)!.wednesdayShort
    ],
    4: [
      AppLocalizations.of(context)!.thursday,
      AppLocalizations.of(context)!.thursdayShort
    ],
    5: [
      AppLocalizations.of(context)!.friday,
      AppLocalizations.of(context)!.fridayShort
    ],
    6: [
      AppLocalizations.of(context)!.saturday,
      AppLocalizations.of(context)!.saturdayShort
    ],
    7: [
      AppLocalizations.of(context)!.sunday,
      AppLocalizations.of(context)!.sundayShort
    ]
  };
  return weekDayDict[weekDayNumber]!;
}

String languageSensibleOpeningTimeCode(
    {required OpeningTimeCode openingTimeCode, required BuildContext context}) {
  Map weekDayDict = {
    "open": AppLocalizations.of(context)!.open,
    "closed": AppLocalizations.of(context)!.closed,
    "openSoon": AppLocalizations.of(context)!.openSoon,
    "closedSoon": AppLocalizations.of(context)!.closedSoon,
  };
  // weird code below necessary to get the enum name and access the dictionary
  return weekDayDict[openingTimeCode
      .toString()
      .substring(openingTimeCode.toString().indexOf('.') + 1)]!;
}

String formatTime({required double unformattedTime}) {
  String formattedTime = unformattedTime.toInt().toString().padLeft(4, '0');
  return "${formattedTime.substring(0, 2)}:${formattedTime.substring(2, 4)}";
}

String getLocationString(
    {String? street,
    String? streetNumber,
    String? city,
    required bool isOnline,
    String? locationTitle}) {
  if (isOnline) {
    return "Online";
  }
  if ((street != null) & (streetNumber != null)) {
    return '$city, $street $streetNumber';
  }
  if ((street != null)) {
    return '$city, $street';
  }
  if ((locationTitle != null)) {
    return '$city, $locationTitle';
  } else {
    return city!;
  }
}
