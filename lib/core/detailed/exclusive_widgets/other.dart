import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../config/routes/routes.dart';
import '../../../constants/asset_constants.dart';
import '../../../utils/ui/ui_utils.dart';
import '../../../widgets/button.dart';

Container buildTicketPrice() {
  // must define ticket to be empty in case no price is given
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20.h),
    padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.h),
    decoration: BoxDecoration(
        color: Colors.grey, borderRadius: BorderRadius.circular(22.h)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("TEXTI TEXT")
        // getRichText("Ticket Price ", Colors.black, FontWeight.w600, 15.sp,
        //     '(Economy)', greyColor, FontWeight.w500, 13.sp),
        // getCustomFont("\$21.00", 20.sp, Colors.black, 1,
        //     fontWeight: FontWeight.w700)
      ],
    ),
  );
}

Widget buildButtonWidget(BuildContext context) {
  // can be transformed to rating or similar
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.h),
    child: getButton(context, Colors.red, "Buy Ticket", Colors.white, () {
      Get.toNamed(Routes.detailedEventRoute);
    }, 18.sp,
        weight: FontWeight.w700,
        buttonHeight: 60.h,
        borderRadius: BorderRadius.circular(22.h)),
  );
}

Widget getFollowWidget(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            getAssetImage("image.png", width: 58.h, height: 58.h),
            getHorSpace(10.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getCustomFont("Bella Flores", 18.sp, Colors.black, 1,
                    fontWeight: FontWeight.w600, txtHeight: 1.5.h),
                getVerSpace(1.h),
                getCustomFont("Organizer", 15.sp, Colors.black, 1,
                    fontWeight: FontWeight.w500, txtHeight: 1.46.h)
              ],
            )
          ],
        ),
        getButton(context, Colors.white, "Follow", Colors.black, () {}, 14.sp,
            weight: FontWeight.w700,
            buttonHeight: 40.h,
            buttonWidth: 76.h,
            isBorder: true,
            borderColor: Colors.red,
            borderWidth: 1.h,
            borderRadius: BorderRadius.circular(14.h))
      ],
    ),
  );
}

Container LocationWidget() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20.h),
    height: 116.h,
    decoration: BoxDecoration(
        image: const DecorationImage(
            image: AssetImage("${AssetConstants.imagePath}location_image.png"),
            fit: BoxFit.fill),
        borderRadius: BorderRadius.circular(22.h)),
  );
}
