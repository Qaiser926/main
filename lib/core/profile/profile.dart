import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/modules/models/user_info/user_info.dart';
import 'package:othia/utils/services/data_handling/keep_alive_future_builder.dart';
import 'package:othia/utils/services/rest-api/rest_api_service.dart';
import 'package:othia/utils/ui/future_service.dart';
import 'package:othia/widgets/not_logged_in.dart';
import 'package:othia/widgets/vertical_discovery/vertical_discovery_framework.dart';

import '../../constants/colors.dart';
import '../../utils/ui/ui_utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Object> userInfo;

  // TODO
  bool userLoggedIn = true;

  @override
  void initState() {
    // TODO how to receive the user id?
    // String userId = Get.arguments[NavigatorConstants.EventActivityId] ?? "1";
    // if (userId != null) {
    //   // TODO get user info
    //   userInfo =
    //       RestService().fetchEventOrActivityDetails(eventOrActivityId: userId);
    // }
    userInfo = RestService().getUserInfo(userId: "123");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                toolbarHeight: 53.h,
                elevation: 0,
                title: Text(
                  AppLocalizations.of(context)!.profile,
                ),
                centerTitle: true,
                actions: [
                  GestureDetector(
                      onTap: () {
                        // TODO send to options page
                        // Constant.sendToNext(context, Routes.settingRoute);
                      },
                      child: Icon(
                        Icons.settings,
                        size: 24.h,
                      )),
                  getHorSpace(20.h)
                ],
                automaticallyImplyLeading: false),
            body: getLoggedInSensitiveBody(
                context: context,
                loggedInWidget: ProfilePageFuturreBuilder(),
                isLoggedIn: userLoggedIn)));
  }

  Widget ProfilePageFuturreBuilder() {
    return KeepAliveFutureBuilder(
        future: userInfo,
        builder: (context, snapshot) {
          return snapshotHandler(snapshot, getProfilePage, []);
        });
  }

  Widget getProfilePage(Map<String, dynamic> jsonData) {
    UserInfo userInfo = UserInfo.fromJson(jsonData);
    List<Widget> slivers = [
      SliverToBoxAdapter(
        child: buildProfileSection(context: context, userInfo: userInfo),
      ),
      buildVerticalDiscovery(
          caption: "hosted upcoming events",
          Ids: userInfo.upcomingEventIds,
          actionButtonType: ActionButtonType.likeButton),
      buildVerticalDiscovery(
          caption: "hosted activities",
          Ids: userInfo.activityIds,
          actionButtonType: ActionButtonType.likeButton),
      buildVerticalDiscovery(
          caption: "hosted past events",
          Ids: userInfo.pastEventIds,
          actionButtonType: ActionButtonType.likeButton)
    ];

    return CustomScrollView(slivers: slivers);
  }

  Container buildProfileSection(
      {required BuildContext context, required UserInfo userInfo}) {
    return Container(
      // TODO, user our color
      color: accentColor.withOpacity(0.05),
      width: double.infinity,
      child: Column(
        children: [
          getVerSpace(20.h),
          getProfilePhotoStack(userInfo),
          getVerSpace(15.h),
          // TODO
          Text(
            userInfo.profileName,
            style: Theme.of(context).textTheme.headline4,
          ),
          getVerSpace(15.h),
          Text(
            userInfo.profileEMail,
            style: Theme.of(context).textTheme.headline4,
          ),
          getVerSpace(20.h),
        ],
      ),
    );
  }


  ImageProvider getProfilePictureNullSafe(UserInfo userInfo) {
    if (userInfo.profilePhoto != null) {
      return Image.memory(
        base64Decode(userInfo.profilePhoto!),
        width: 100.h,
        height: 100.h,
        fit: BoxFit.contain,
      ).image;
    } else {
      return getAssetImageProvider("default_profile_image.jpg",
          width: 100.h, height: 100.h);
    }
  }

  Stack getProfilePhotoStack(UserInfo userInfo) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // TODO null save profile image

        CircleAvatar(
            radius: 90, backgroundImage: getProfilePictureNullSafe(userInfo)),
        Positioned(
            child: Container(
          height: 30.h,
          width: 30.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.h),
              color: Theme.of(context).colorScheme.primary,
              boxShadow: [
                BoxShadow(
                    color: shadowColor,
                    offset: const Offset(0, 8),
                    blurRadius: 27)
              ]),
          padding: EdgeInsets.all(5.h),
          child: GestureDetector(
            // TODO forward to change profile page
            onTap: () => {},
            child: Icon(
              Icons.edit,
              size: 20.h,
              color: Colors.white,
            ),
          ),
        ))
      ],
    );
  }
}
