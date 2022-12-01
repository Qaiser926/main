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
        getRichText(
            firstText: "Ticket Price ",
            firstColor: Colors.black,
      firstWeight: FontWeight.w600,
      firstSize: 15.sp,
      secondText: '(Economy)',
      secondColor: Colors.grey,
      secondWeight: FontWeight.w500,
      secondSize: 13.sp),
        getCustomFont(
            text: "\$21.00", fontSize: 20.sp, fontWeight: FontWeight.w700)
      ],
    ),
  );
}

Widget buildButtonWidget(BuildContext context) {
  // can be transformed to rating or similar
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.h),
    child: getButton(
        context: context,
        bgColor: Colors.red,
        text: "Buy Ticket",
        textColor: Colors.white,
        function: () {
          Get.toNamed(Routes.detailedEventRoute);
        },
        fontsize: 18.sp,
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
                getCustomFont(
                    text: "Bella Flores",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    txtHeight: 1.5.h),
                getVerSpace(1.h),
                getCustomFont(
                    text: "Organizer",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    txtHeight: 1.46.h)
              ],
            )
          ],
        ),
        getButton(
            context: context,
            bgColor: Colors.white,
            text: "Follow",
            textColor: Colors.black,
            function: () {},
            fontsize: 14.sp,
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
