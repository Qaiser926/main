import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/colors.dart';
import '../modules/models/favourite_event_and_activity/favourite_single_event_or_activity/favourite_event_or_activity.dart';
import '../utils/services/data_handling/data_handling.dart';
import '../utils/ui/app_dialogs.dart';
import '../utils/ui/ui_utils.dart';


class EventOrActivityContainer extends StatefulWidget {
  ValueNotifier<bool> isVisible = ValueNotifier(true);
  final FavouriteEventOrActivity favouriteEventOrActivity;

// TODO make events clickable and forward to their detail page
  EventOrActivityContainer(
      {required this.favouriteEventOrActivity, super.key}) {}

  @override
  State<EventOrActivityContainer> createState() =>
      _EventOrActivityContainer();
}

class _EventOrActivityContainer extends State<EventOrActivityContainer> {



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: shadowColor, blurRadius: 27, offset: const Offset(0, 8))
          ],
          borderRadius: BorderRadius.circular(22.h)),
      padding: EdgeInsets.only(top: 7.h, left: 7.h, bottom: 6.h, right: 10.h),
      child: Row(
        children: [
          Flexible(
            child: Row(
              children: [
                getRoundImage(getPhotoNullSave(
                    categoryId: widget.favouriteEventOrActivity.categoryId,
                    photo: widget.favouriteEventOrActivity.photo,
                    width: 100.h,
                    height: 82.h)),
                getHorSpace(10.h),
                Flexible(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getCustomFont(
                        text: widget.favouriteEventOrActivity.title,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        txtHeight: 1.5.h),
                    getVerSpace(4.h),
                    getCustomFont(
                        text: getTimeInformation(
                            context: context,
                            openingTimeCode:
                                widget.favouriteEventOrActivity.openingTimeCode,
                            startTimeUtc:
                                widget.favouriteEventOrActivity.startTimeUtc),
                        fontSize: 15.sp,
                        color: greyColor,
                        fontWeight: FontWeight.w500,
                        txtHeight: 1.46.h)
                  ],
                ))
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),

                  // on pressed open dialog window
                  onPressed: () async {
                    bool? removed = await showDialog<bool>(
                        context: context,
                        builder: (context) => getDialog(objectTitle: widget.favouriteEventOrActivity.title));
                  widget.isVisible.value = !removed!;
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
