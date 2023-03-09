import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:othia/core/profile/profile.dart';
import 'package:othia/modules/models/user_info/user_info.dart';
import 'package:othia/utils/services/rest-api/rest_api_service.dart';
import 'package:othia/utils/ui/future_service.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:othia/widgets/keep_alive_future_builder.dart';
import 'package:progress_indicators/progress_indicators.dart';

class OrganizerSection extends StatelessWidget {
  String organizerId;

  OrganizerSection(this.organizerId);

  @override
  Widget build(BuildContext context) {
    return KeepAliveFutureBuilder(
        future: RestService().getPublicUserInfo(organizerId: organizerId),
        builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
                      return Center(child: defaultStillLoadingWidget);
                    }
          if(snapshot.hasData){
          return snapshotHandler(
              context, snapshot, getOrganizerWidget, [context]);
               }else{
                    return Center(child: Text("No Data Exit"),);
                  }
        });
  }

  Widget getOrganizerWidget(
      BuildContext context, Map<String, dynamic> jsonData) {
    UserInfo userInfo = UserInfo.fromJson(jsonData);
    ImageProvider<Object> image = getProfilePictureNullSafe(userInfo);
    Image fittedImage = Image(
      image: image,
      fit: BoxFit.cover,
    );
    // Approach with stack is necessary as the background image width would otherwise influence the horizontal distances
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Stack(children: [
        ClipOval(
          child: SizedBox.fromSize(
              size: Size.fromRadius(30.h), // Image radius
              child: ClipRect(
                child: ImageFiltered(
                    imageFilter: ImageFilter.blur(
                        sigmaX: 4.0, sigmaY: 4.0, tileMode: TileMode.mirror),
                    child: fittedImage),
              )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipOval(
                child: SizedBox.fromSize(
              size: Size.fromRadius(30.h), // Image radius
              child: Image(
                image: image,
              ),
            )),
            getHorSpace(10.h),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userInfo.profileName,
                  overflow: TextOverflow.ellipsis,
                ),
                // Text(
                //   userInfo.profileEmail,
                //   overflow: TextOverflow.ellipsis,
                // ),
                SelectableText(
                  // TODO clear (extern) email must be copyable
                  userInfo.profileEmail,
                ),
              ],
            )),
            getHorSpace(5.h),
            GestureDetector(
              onTap: () {
                Get.to(ProfilePage(
                  userInfo: userInfo,
                ));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10.h),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.h),
                  child: Text(AppLocalizations.of(context)!.more),
                ),
              ),
            )
          ],
        ),
      ]),
    );
  
  //  Scaffold(
  //   backgroundColor: Colors.red,
  //  );
  }
}
