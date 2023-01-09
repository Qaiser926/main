import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

Widget getSection(
    {required BuildContext context,
    required String caption,
    required Widget contentWidget}) {
  return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(thickness: 3.h),
          getVerSpace(25),
          Text(
            caption,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          getVerSpace(25),
          contentWidget,
          getVerSpace(25.h),
        ],
      ));
}
