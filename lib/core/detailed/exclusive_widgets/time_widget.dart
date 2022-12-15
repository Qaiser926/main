import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/ui/ui_utils.dart';

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
          Icon(
            Icons.access_time_outlined,
            size: 17.h,
          ),
          getHorSpace(5.h),
          Text(
            time,
            style: Theme.of(context).textTheme.bodyText2,
            maxLines: 1,
          )
        ],
      ),);
  }
}
