import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/utils/ui/ui_utils.dart';

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
    return getAssetImage("${categoryId}.jpg", width: width, height: height)
        as Image;
  }
}

// String getLocalTime({required String startTimeUtc) {
// final now = DateTime.now();
// final UtcInLocal = DateTime.parse('2022-12-12 12:00:00');
// final StartTimeUtc = dateTimeToZone(zone: "UTC", datetime: DateTime.parse('2022-12-12 12:00:00'));
// final StartTimeLocal = dateTimeToZone(zone: now.timeZoneName, datetime: StartTimeUtc);
// }
