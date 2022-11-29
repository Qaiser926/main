import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:othia/constants/asset_constants.dart';

import '../../config/themes/color_data.dart';
import '../../widgets/event_activity_list.dart';
import '../services/from_bought_ui/widget_utils.dart';
import 'event_section.dart';

class UpcomingAndPastEventList extends StatefulWidget {
  const UpcomingAndPastEventList({Key? key}) : super(key: key);

  @override
  State<UpcomingAndPastEventList> createState() =>
      _UpcomingAndPastEventListState();
}

class _UpcomingAndPastEventListState extends State<UpcomingAndPastEventList> {
  void backClick() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          EventActivityList(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
          children: [getHorSpace(20), getCustomFont("Zurückliegende Events", 16, greyColor, 1, fontWeight: FontWeight.w600,
              txtHeight: 1.5.h)],),
          Divider(
            color: greyColor,
            thickness: 2.h,
            indent: 20.h,
            endIndent: 20.h,
          ),
          getVerSpace(10),
          EventActivityList(),
        ],
      ),
    );
  }
}
