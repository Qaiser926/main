import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import '../utils/ui/ui_utils.dart';

class TimeWidget extends StatelessWidget {
  final String time;
  Event? iCalElement;

  TimeWidget({super.key, required this.time, this.iCalElement});

  @override
  Widget build(BuildContext context) {
    Function() function = () => {};
    if (iCalElement != null) {
      function = () =>
          Add2Calendar.addEvent2Cal(iCalElement!);
    }


    return GestureDetector(
    onTap: () => function(),
    child: Row(
      children: [
        getSvgImage("calender.svg", width: 20.h, height: 20.h),
        getHorSpace(5.h),
        getCustomFont(
          text: time,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        )
      ],
    ),);
  }
}
