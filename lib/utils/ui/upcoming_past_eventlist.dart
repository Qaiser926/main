import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../config/themes/color_data.dart';
import '../../widgets/event_activity_list.dart';


class UpcomingAndPastEventList extends StatefulWidget {
  const UpcomingAndPastEventList({Key? key}) : super(key: key);

  @override
  State<UpcomingAndPastEventList> createState() => _UpcomingAndPastEventListState();
}

class _UpcomingAndPastEventListState extends State<UpcomingAndPastEventList> {
  void backClick() {
    Get.back();
  }


  @override
  Widget build(BuildContext context) {

    return Container(child: ListView(

      children: [

        EventActivityList(),
        Divider(
          color: Colors.black,
          thickness: 1.h,
        ),
      ],
    ),);
  }
}
