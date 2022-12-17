import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/asset_constants.dart';
import '../../../utils/ui/ui_utils.dart';
import '../../../widgets/button.dart';

Widget buildButtonWidget(BuildContext context) {
  // can be transformed to rating or similar
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.h),
    child: getButton(
        context: context,
        bgColor: Colors.red,
        text: "Buy Ticket",
        function: () {
          throw Exception();
          // Get.toNamed(Routes.detailedEventRoute);
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
            text: AppLocalizations.of(context)!.follow,
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
