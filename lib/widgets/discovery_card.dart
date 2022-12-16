import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/constants/colors.dart';
import 'package:othia/core/detailed/detailed_event.dart';

import '../modules/models/eA_summary/eA_summary.dart';
import '../utils/services/data_handling/data_handling.dart';
import '../utils/ui/ui_utils.dart';

class EASummaryCard extends StatelessWidget {
  final SummaryEventOrActivity eASummary;
  final int index;

  EASummaryCard({Key? key, required this.eASummary, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Get.to(EventDetail(),
            arguments: {NavigatorConstants.EventActivityId: eASummary.id})
      },
      child: Container(
        width: 185.w,
        margin: EdgeInsets.only(right: 20.h, left: index == 0 ? 20.h : 0),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22.h),
                  image: DecorationImage(
                      image: getPhotoNullSave(
                              categoryId: eASummary.categoryId,
                              photo: eASummary.photo)
                          .image,
                      fit: BoxFit.fill)),
              height: 140.h,
              width: 248.h,
              padding: EdgeInsets.only(left: 12.h, top: 12.h),
              child: getPriceWrapper(context: context, eASummary: eASummary),
            ),
            Positioned(
              width: 152.h,
              top: 100.h,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(22.h)),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
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
      ),
      getVerSpace(5.h),
      Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 14.h,
          ),
          getHorSpace(3.h),
          Text(
            getLocationString(location: eASummary.location, isShort: true),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )

// include here price information
        ],
      ),
      getVerSpace(3.h),
      Row(
        children: [
          Icon(
            Icons.access_time_outlined,
            size: 14.h,
          ),
          getHorSpace(3.h),
          Text(
            getTimeInformation(
                context: context,
                startTimeUtc: eASummary.time.startTimeUtc,
                openingTimeCode: eASummary.time.openingTimeCode),
            maxLines: 1,
          )
        ],
      ),
    ],
  );
}
