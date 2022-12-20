import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/asset_constants.dart';
import '../../../utils/ui/ui_utils.dart';

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
                // TODO
                Text("example text"),
                getVerSpace(1.h),
                Text("Organizer")
              ],
            )
          ],
        ),
        ElevatedButton(
            onPressed: () {}, child: Text(AppLocalizations.of(context)!.follow))
        // getButton(
        //     context: context,
        //     text: AppLocalizations.of(context)!.follow,
        //     function: () {},
        //     fontsize: 14.sp,
        //     buttonHeight: 40.h,
        //     buttonWidth: 76.h,
        //     isBorder: true,
        //
        //     borderColor: Colors.red,
        //     borderWidth: 1.h,
        //     borderRadius: BorderRadius.circular(14.h))
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
