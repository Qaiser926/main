import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../modules/models/detailed_event/detailed_event.dart';
import '../../../utils/services/data_handling/data_handling.dart';
import 'event_summary.dart';
import 'get_image_carousel.dart';
import 'icon_row.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

class ImageWidget extends StatelessWidget {

  final DetailedEventOrActivity detailedEventOrActivity;
  Event? iCalElement;


  ImageWidget(
      {super.key,
      required this.detailedEventOrActivity, this.iCalElement
    });

  @override
  Widget build(BuildContext context) {
    // buildImageWidget so far needs Images as variables

    // Stack to put items upon each other (here: Weiße box auf Bild)
    return Container(
      height: 330,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        // clip means that elements can go beyond borders of stack
        clipBehavior: Clip.none,
        children: [
          // first Container is picture
          Positioned(
            child: getImageCarousel(
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
                // TODO get userID from logged in details
                child: IconRow(
                    objectId: detailedEventOrActivity.id,
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
              bottom: 13,
              width: 374.w,
              child: EventSummary(
                  time: getTimeInformation(
                      context: context,
                      startTimeUtc: detailedEventOrActivity.startTimeUtc,
                      openingTimeCode: detailedEventOrActivity.openingTimeCode),
                  title: detailedEventOrActivity.title,
                  locationText: getLocationString(
                      isOnline: detailedEventOrActivity.isOnline,
                      locationTitle: detailedEventOrActivity.locationTitle,
                      city: detailedEventOrActivity.city,
                      street: detailedEventOrActivity.street,
                      streetNumber: detailedEventOrActivity.streetNumber),
                latitude: detailedEventOrActivity.latitude,
                longitude: detailedEventOrActivity.latitude,
              iCalElement: iCalElement)),

        ],
      ),
    );
  }
}
