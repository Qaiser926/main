import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/ui/ui_utils.dart';

class TimeWidget extends StatelessWidget {
  final String time;

  const TimeWidget({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        getSvgImage("calender.svg", width: 20.h, height: 20.h),
        getHorSpace(5.h),
        getCustomFont(
          time,
          15.sp,
          Colors.black,
          1,
          fontWeight: FontWeight.w500,
        )
      ],
    );
  }
}