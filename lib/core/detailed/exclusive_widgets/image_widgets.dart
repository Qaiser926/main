import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../modules/models/detailed_event/detailed_event.dart';
import '../../../utils/ui/ui_utils.dart';
import '../../../widgets/carousel_widget.dart';
import '../../../widgets/event_summary.dart';
import '../../../widgets/filtered_image_stack.dart';

class ImageWidget extends StatelessWidget {
  final pictures;
  final String title;
  final DetailedEventOrActivity detailedEventOrActivity;
  final street;
  final city;
  final time;
  final locationName;
  final streetNumber;

  const ImageWidget(
      {super.key,
        required this.detailedEventOrActivity,
      required this.pictures,
      required this.title,
      required this.street,
      required this.city,
      required this.time,
      required this.locationName,
      required this.streetNumber});

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
            child: Container(
              // height of picture
              height: 327.h,
              width: double.infinity,
              //decoration: BoxDecoration(
              //borderRadius:
              // radius of the picture
              //BorderRadius.vertical(bottom: Radius.circular(22.h)),
              //image: DecorationImage(
              // image: AssetImage(
              //    "${Constant.assetImagePath}white.jpg"),
              //fit: BoxFit.fill)),
              alignment: Alignment.topCenter,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                child: PictureCarousel(getFilteredImageStackList(pictures)),
              ),
            ),
          ),
          Positioned(
            child: Container(
              // in this contianer, the items are placed (back and heart)
              // height defines the hight of this box
              height: 50.h,

              // the next child is the heart
              child: Padding(
                padding: EdgeInsets.only(top: 26.h, right: 20.h, left: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("nono");
                        // backClick();
                      },
                      child: getSvgImage("arrow_back.svg",
                          width: 24.h, height: 24.h, color: Colors.white),
                    ),
                    // when clicking of favourite, business logic must define to add that event
                    GestureDetector(
                        onTap: () {
                          //TODO on click, add event to account favourites
                          print("bobo");
                          // backClick();
                        },
                        child: getSvgImage(
                          "favourite_white.svg",
                          width: 24.h,
                          height: 24.h,
                        ))
                  ],
                ),
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
              child: const EventSummary(
                street: "binse",
                city: "Kiel",
                time: 'fddsfd',
                title: 'localTitle',
                locationName: 'localLocationName',
                streetNumber: '34',
              )),
        ],
      ),
    );
  }
}
