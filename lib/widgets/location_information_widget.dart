import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/ui/ui_utils.dart';

class LocationInformationWidget extends StatelessWidget {
  final String city;
  final String? locationTitle;
  final String? street;
  final String? streetNumber;

  const LocationInformationWidget(
      {super.key,
      this.locationTitle,
      this.street,
      this.streetNumber,
      required this.city});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        getSvgImage("location.svg",
            height: 20.h, width: 20.h, color: Colors.grey),
        getHorSpace(5.h),
        getFinalStringWidget(context)
      ],
    );
  }

  Widget getFinalStringWidget(context) {
    if ((street != null) & (streetNumber != null)) {
      return Text(
        '$city, $street $streetNumber',
        style: Theme.of(context).textTheme.headline4,
        maxLines: 1,
      );
    }
    if ((street != null)) {
      return Text(
        '$city, $street',
        style: Theme.of(context).textTheme.headline4,
        maxLines: 1,
      );
    }
    if ((locationTitle != null)) {
      return Text(
        '$city, $locationTitle',
        style: Theme.of(context).textTheme.headline4,
        maxLines: 1,
      );
    } else {
      return Text(
        city,
        style: Theme.of(context).textTheme.headline4,
        maxLines: 1,
      );
    }
  }
}
