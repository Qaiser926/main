import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../modules/models/detailed_event/detailed_event.dart';
import '../../../utils/services/data_handling/data_handling.dart';
import 'diverse.dart';
import 'event_summary.dart';

class ImageWidget extends StatelessWidget {

  final DetailedEventOrActivity detailedEventOrActivity;
  final Event? iCalElement;

  const ImageWidget(
      {super.key, required this.detailedEventOrActivity, this.iCalElement});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320.h,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        // clip means that elements can go beyond borders of stack
        clipBehavior: Clip.none,
        children: [
          Positioned(
            child: ImageCarousel(
                categoryId: detailedEventOrActivity.categoryId!,
                pictures: detailedEventOrActivity.photos),
          ),
          Positioned(
            child: Container(
              height: 50.h,
              child: Padding(
                padding: EdgeInsets.only(top: 20.h, right: 20.h, left: 20.h),
                child: IconRow(
                  eAId: detailedEventOrActivity.id!,
                ),
              ),
            ),
          ),
          // define radius of picture
          Positioned(
              bottom: 13.h,
              width: 325.w,
              child: EventSummary(
                timeText: getTimeInformation(
                    context: context,
                    startTimeUtc: detailedEventOrActivity.time.startTimeUtc,
                    openingTimeCode:
                        detailedEventOrActivity.time.openingTimeCode),
                title: detailedEventOrActivity.title!,
                location: detailedEventOrActivity.location,
                iCalElement: iCalElement,
                prices: detailedEventOrActivity.prices,
                ticketUrl: detailedEventOrActivity.ticketUrl,
                websiteUrl: detailedEventOrActivity.websiteUrl,
                status: detailedEventOrActivity.status,
              )),
        ],
      ),
    );
  }
}
