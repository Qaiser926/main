import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/ui/ui_utils.dart';

class LocationInformationWidget extends StatelessWidget {
  final String city;
  String? locationTitle;
  String? street;
  String? streetNumber;
  Widget finalStringWidget = Text("Error 404 Location not found");

  LocationInformationWidget(this.city, {locationTitle, street, streetNumber}) {
    // depending on the final implementation a dictionary is given
    if ((street != null) & (streetNumber != null)) {
      finalStringWidget = getCustomFont(
          '${this.city}, ${street} ${streetNumber}', 15.sp, Colors.black, 1,
          fontWeight: FontWeight.w500);
    }
    if ((street != null)) {
      finalStringWidget = getCustomFont(
          '${this.city}, ${street}', 15.sp, Colors.black, 1,
          fontWeight: FontWeight.w500);
    }
    if ((locationTitle != null)) {
      finalStringWidget = getCustomFont(
          '${this.city}, ${locationTitle}', 15.sp, Colors.black, 1,
          fontWeight: FontWeight.w500);
    } else {
      finalStringWidget = getCustomFont('${this.city}', 15.sp, Colors.black, 1,
          fontWeight: FontWeight.w500);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        getSvgImage("location.svg",
            height: 20.h, width: 20.h, color: Colors.grey),
        getHorSpace(5.h),
        finalStringWidget
      ],
    );
  }
}
