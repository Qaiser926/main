import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../modules/models/detailed_event/detailed_event.dart';
import '../../../utils/services/data_handling/data_handling.dart';
import 'event_summary.dart';
import 'get_image_carousel.dart';
import 'icon_row.dart';

class ImageWidget extends StatelessWidget {

  final DetailedEventOrActivity detailedEventOrActivity;
  final Event? iCalElement;

  const ImageWidget(
      {super.key, required this.detailedEventOrActivity, this.iCalElement});

  @override
  Widget build(BuildContext context) {
    // buildImageWidget so far needs Images as variables

    // Stack to put items upon each other (here: Weiße box auf Bild)
    return Container(
      height: 320.h,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        // clip means that elements can go beyond borders of stack
        clipBehavior: Clip.none,
        children: [
          // first Container is picture
          Positioned(
            child: ImageCarousel(
                categoryId: detailedEventOrActivity.categoryId,
                pictures: detailedEventOrActivity.photos),
          ),
          Positioned(
            child: Container(
              // in this contianer, the items are placed (back and heart)
              // height defines the hight of this box
              height: 50.h,
              // the next child is the heart
              child: Padding(
                padding: EdgeInsets.only(top: 20.h, right: 20.h, left: 20.h),
                // TODO get userID from logged in details + decide what to do if user performs action that requires login
                // idea would be to open a notification window and inform user that she/ he needs to be logged in to perform this action
                // user can either cancel or is forwarded to login screen
                child: IconRow(
                    eAId: detailedEventOrActivity.id,
                    isLiked: true,
                    userId: "something"),
              ),
            ),
          ),
          // define radius of picture
          Positioned(
              // not in the container, but on top of it
              // defines postition of detail box of event in terms of upper
              // position is fixed from bottom, so with increasing text, the summary box will go into the picture
              bottom: 13.h,
              width: 325.w,
              child: EventSummary(
                timeText: getTimeInformation(
                    context: context,
                    startTimeUtc: detailedEventOrActivity.time.startTimeUtc,
                    openingTimeCode:
                        detailedEventOrActivity.time.openingTimeCode),
                title: detailedEventOrActivity.title,
                location: detailedEventOrActivity.location,
                iCalElement: iCalElement,
                prices: detailedEventOrActivity.prices,
                ticketUrl: detailedEventOrActivity.ticketUrl,
                websiteUrl: detailedEventOrActivity.websiteUrl,
                status: detailedEventOrActivity.status,)),
        ],
      ),
    );
  }
}
