import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/utils/ui/ui_utils.dart';

import '../../../modules/models/shared_data_models.dart';

double roundDouble(double value, int places) {
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

Image getPhotoNullSave(
    {required String categoryId,
    double? width,
    double? height,
    String? photo}) {
  if (photo != null) {
    return Image.memory(
      base64Decode(photo),
      fit: BoxFit.contain,
      width: width,
      height: height,
      errorBuilder: (_, __, ___) {
        return getAssetImage("$categoryId.jpg", width: width, height: height)
            as Image;
      },
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

DateTime? getLocalDateTime({required String? dateTimeUtc}) {
  if (dateTimeUtc != null) {
    final DateTime now = DateTime.now();
    final utcInLocal = DateTime.parse(dateTimeUtc);
    final datetimeutc = DateTime.utc(utcInLocal.year, utcInLocal.month,
        utcInLocal.day, utcInLocal.hour, utcInLocal.minute);
    return datetimeutc.add(now.timeZoneOffset);
  } else {
    return null;
  }
}

String getUTCTimeString({required DateTime localDateTime}) {
  final DateTime now = DateTime.now();
  return localDateTime.subtract(now.timeZoneOffset).toString();
}

String getMonthName({required int month, required BuildContext context}) {
  Map monthDict = {
    1: AppLocalizations.of(context)!.januaryShort,
    2: AppLocalizations.of(context)!.februaryShort,
    3: AppLocalizations.of(context)!.marchShort,
    4: AppLocalizations.of(context)!.aprilShort,
    5: AppLocalizations.of(context)!.mayShort,
    6: AppLocalizations.of(context)!.juneShort,
    7: AppLocalizations.of(context)!.julyShort,
    8: AppLocalizations.of(context)!.augustShort,
    9: AppLocalizations.of(context)!.septemberShort,
    10: AppLocalizations.of(context)!.octoberShort,
    11: AppLocalizations.of(context)!.novemberShort,
    12: AppLocalizations.of(context)!.decemberShort,
  };
  return monthDict[month];
}

String getTimeText(
    {required DateTime localDateTime, required BuildContext context}) {
  final String weekday =
      getWeekday(weekDayNumber: localDateTime.weekday, context: context)[1];
  return "$weekday, ${localDateTime.day.toString().padLeft(2, '0')}. ${getMonthName(context: context, month: localDateTime.month)} ${localDateTime.year}, ${localDateTime.hour.toString().padLeft(2, '0')}:${localDateTime.minute.toString().padLeft(2, '0')}";
}

String getLocalTimeString(
    {required String dateTimeUtc, required BuildContext context}) {
  final DateTime now = DateTime.now();
  final TimeLocal = getLocalDateTime(dateTimeUtc: dateTimeUtc)!;
  final String weekday =
      getWeekday(weekDayNumber: TimeLocal.weekday, context: context)[1];
  if (now.year == TimeLocal.year) {
    return "$weekday, ${TimeLocal.day.toString().padLeft(2, '0')}. ${getMonthName(context: context, month: TimeLocal.month)}, ${TimeLocal.hour.toString().padLeft(2, '0')}:${TimeLocal.minute.toString().padLeft(2, '0')}";
  } else {
    return "$weekday, ${TimeLocal.day.toString().padLeft(2, '0')}. ${getMonthName(context: context, month: TimeLocal.month)} ${TimeLocal.year}, ${TimeLocal.hour.toString().padLeft(2, '0')}:${TimeLocal.minute.toString().padLeft(2, '0')}";
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
    "unknown": AppLocalizations.of(context)!.unknown,
  };
  // weird code below necessary to get the enum name and access the dictionary
  return weekDayDict[openingTimeCode
      .toString()
      .substring(openingTimeCode.toString().indexOf('.') + 1)]!;
}

String formatTime({required double? unformattedTime}) {
  if (unformattedTime != null) {
    String formattedTime = unformattedTime.toInt().toString().padLeft(4, '0');
    return "${formattedTime.substring(0, 2)}:${formattedTime.substring(2, 4)}";
  } else {
    return "";
  }
}

String getLocationString({required Location location, bool isShort = false}) {
  if (location.isOnline!) {
    return "Online";
  }
  if (location.city != null) {
    if ((location.street != null) &
        (location.streetNumber != null) &
        (!isShort)) {
      return '${location.city}, ${location.street} ${location.streetNumber}';
    }
    if ((location.street != null)) {
      if (!isShort) {
        return '${location.city}, ${location.street}';
      } else {
        return '${location.street}, ${location.city}';
      }
    }
    if ((location.locationTitle != null)) {
      if (!isShort) {
        return '${location.city}, ${location.locationTitle}';
      } else {
        return '${location.locationTitle}, ${location.city}';
      }
    } else {
      return location.city!;
    }
  } else {
    // case when no city name is given
    if (location.street != null) {
      if (location.streetNumber != null) {
        return '${location.street} ${location.streetNumber}';
      } else {
        return location.street!;
      }
    } else if (location.locationTitle != null) {
      return location.locationTitle!;
    } else {
      return "Unknown";
    }
  }
}

String getPriceText(
    {required BuildContext context,
    List<Price>? prices,
    bool isShort = false}) {
  String priceText = AppLocalizations.of(context)!.noPriceAvailable;
  if (isShort) {
    priceText = " -€ ";
  }
  if (prices != null) {
    if (prices.isEmpty) {
      return priceText;
    }
    if (prices.length == 1) {
      if (prices[0].price == 0) {
        priceText = AppLocalizations.of(context)!.isFree;
      } else {
        priceText = AppLocalizations.of(context)!
            .priceStartingAt(roundDouble(prices[0].price!, 2));
      }
    } else {
      // sometimes the same price is two times in the data base -> check for this case and only return one price
      double startPrice = roundDouble(prices[0].price!, 2);
      double endPrice = roundDouble(prices[prices.length - 1].price!, 2);
      double difference = endPrice - startPrice;
      if (difference < 1) {
        // basically same price
        priceText = AppLocalizations.of(context)!.priceStartingAt(startPrice);
      } else {
        priceText = AppLocalizations.of(context)!.priceRange(
            roundDouble(prices[0].price!, 2),
            roundDouble(prices[prices.length - 1].price!, 2));
      }
    }
  }
  return priceText;
}

String getTicketStatus({required BuildContext context, Status? status}) {
  String ticketStatus = "";
  if (status != null) {
    if (status.toString().substring(status.toString().indexOf('.') + 1) ==
        "CANCELED") {
      ticketStatus = ' | ${AppLocalizations.of(context)!.cancelled}';
    } else if (status
            .toString()
            .substring(status.toString().indexOf('.') + 1) ==
        "SOLDOUT") {
      ticketStatus = ' | ${AppLocalizations.of(context)!.soldOut}';
    }
  }
  return ticketStatus;
}

Future<String?> getFromGallery() async {
  XFile? pickedFile = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    maxWidth: DataConstants.MaxImageWidth,
    maxHeight: DataConstants.MaxImageHeight,
  );
  if (pickedFile != null) {
    return pickedFile.path;
  }
  return null;
}
