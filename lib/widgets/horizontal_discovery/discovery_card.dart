import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/constants/colors.dart';
import 'package:othia/core/detailed/detailedEA.dart';
import 'package:othia/modules/models/eA_summary/eA_summary.dart';
import 'package:othia/utils/services/data_handling/data_handling.dart';
import 'package:othia/utils/ui/ui_utils.dart';

import '../vertical_discovery/favourite_list_item.dart';

class EASummaryCard extends StatelessWidget {
  final SummaryEventOrActivity eASummary;
  final int index;

  EASummaryCard({Key? key, required this.eASummary, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
      {
        Get.to(DetailedEAPage(),
            arguments: {DataConstants.EventActivityId: eASummary.id},
            preventDuplicates: false)
      },
      child: Container(
        width: 160.w,
        margin: EdgeInsets.only(right: 20.h, left: index == 0 ? 20.h : 0),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              width: 200.h,
              height: 220.h,
              child: getImageWithBackground(
                  categoryId: eASummary.categoryId,
                  photo: eASummary.photo,
                  width: 200,
                  height: 120),
            ),
            Positioned(
                top: 5.h,
                left: 12.h,
                child: getPriceWrapper(context: context, eASummary: eASummary)),
            Positioned(
              width: 131.h,
              top: 85.h,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(13.h)),
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.h),
                child: getSummaryInformation(
                    eASummary: eASummary, context: context),
                // height: 133.h,
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget getPriceWrapper(
    {required BuildContext context,
    required SummaryEventOrActivity eASummary}) {
  return Wrap(
    children: [
      Container(
        decoration: BoxDecoration(
            color: "#12212E".toColor().withOpacity(0.5),
            borderRadius: BorderRadius.circular(8.h)),
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.h),
        child: Text(
          getPriceText(
              context: context, isShort: true, prices: eASummary.prices),
          maxLines: 1,
          style: TextStyle(fontSize: 11.h),
        ),
      ),
    ],
  );
}

Widget getSummaryInformation(
    {required BuildContext context,
    required SummaryEventOrActivity eASummary}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        eASummary.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 11.h),
      ),
      getVerSpace(3.h),
      Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 11.h,
          ),
          getHorSpace(3.h),
          Expanded(
            child: Text(
              getLocationString(location: eASummary.location, isShort: true),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 11.h),
            ),
          )

// include here price information
        ],
      ),
      getVerSpace(3.h),
      Row(
        children: [
          Icon(
            Icons.access_time_outlined,
            size: 11.h,
          ),
          getHorSpace(3.h),
          Expanded(
            child: Text(
              getTimeInformation(
                  context: context,
                  startTimeUtc: eASummary.time.startTimeUtc,
                  openingTimeCode: eASummary.time.openingTimeCode),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 11.h),
            ),
          )
        ],
      ),
    ],
  );
}
