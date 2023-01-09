import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/core/profile/settings.dart';
import 'package:othia/core/profile/user_info_notifier.dart';
import 'package:othia/modules/models/user_info/user_info.dart';
import 'package:othia/utils/helpers/builders.dart';
import 'package:othia/utils/helpers/diverse.dart';
import 'package:othia/utils/services/data_handling/keep_alive_future_builder.dart';
import 'package:othia/utils/services/rest-api/rest_api_service.dart';
import 'package:othia/utils/ui/future_service.dart';
import 'package:othia/widgets/action_buttons.dart';
import 'package:othia/widgets/not_logged_in.dart';
import 'package:othia/widgets/vertical_discovery/vertical_discovery_framework.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../utils/ui/ui_utils.dart';
import '../add/add.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key, this.userInfo}) : super(key: key);
  UserInfo? userInfo;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Object> userInfoFuture;
  late bool isProfileView;

  // TODO
  bool userLoggedIn = true;

  @override
  void initState() {
    isProfileView = widget.userInfo == null;
    // TODO how to receive the user id?
    // String userId = Get.arguments[NavigatorConstants.EventActivityId] ?? "1";
    // if (userId != null) {
    //   // TODO get user info
    //   userInfo =
    //       RestService().fetchEventOrActivityDetails(eventOrActivityId: userId);
    // }
    // it could be improved that the already requested information is utilized instead of a
    userInfoFuture = isProfileView
        ? RestService().getPrivateUserInfo(userId: "123")
        : RestService().getPublicUserInfo(organizerId: widget.userInfo!.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserInfoNotifier userInfoNotifier = UserInfoNotifier();

    return SafeArea(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: userInfoNotifier,
          )
        ],
        builder: (context, child) {
          return Scaffold(
              appBar: AppBar(
                  toolbarHeight: 53.h,
                  elevation: 0,
                  title: Text(
                    AppLocalizations.of(context)!.profile,
                  ),
                  centerTitle: true,
                  actions: [
                    widget.userInfo == null
                        ? GestureDetector(
                            onTap: () {
                              Get.to(SettingsScreen(userInfoNotifier));
                            },
                            child: Icon(
                              Icons.settings,
                              size: 24.h,
                            ))
                        : GestureDetector(
                            onTap: () {
                              openShare(organizerShareLinkBuilder(
                                  widget.userInfo!.userId!));
                            },
                            child: Icon(
                              Icons.share,
                              size: 24.h,
                            )),
                    getHorSpace(20.h)
                  ],
                  automaticallyImplyLeading: false),
              body: isProfileView
                  ? getLoggedInSensitiveBody(
                      context: context,
                      loggedInWidget: profilePageFutureBuilder(context),
                      isLoggedIn: userLoggedIn)
                  : profilePageFutureBuilder(context));
        },
      ),
    );
  }

  Widget profilePageFutureBuilder(BuildContext context) {
    UserInfoNotifier userInfoNotifier =
        Provider.of<UserInfoNotifier>(context, listen: false);
    return KeepAliveFutureBuilder(
        future: userInfoFuture,
        builder: (context, snapshot) {
          return MultiProvider(providers: [
            ChangeNotifierProvider.value(
              value: userInfoNotifier,
            )
          ], child: snapshotHandler(snapshot, getProfilePage, [context]));
        });
  }

  Widget getProfilePage(BuildContext context, Map<String, dynamic> jsonData) {
    UserInfo userInfo = UserInfo.fromJson(jsonData);
    Provider.of<UserInfoNotifier>(context, listen: false).userInfo = userInfo;
    return Consumer<UserInfoNotifier>(builder: (context, model, child) {
      if (model.newUserInfo.upcomingEventIds.isEmpty &
          model.newUserInfo.activityIds.isEmpty &
          model.newUserInfo.pastEventIds.isEmpty) {
        return noHostedEA(model.newUserInfo);
      } else {
        List<Widget> slivers = [
          SliverToBoxAdapter(
            child: getProfileSection(
                context: context, userInfo: model.newUserInfo),
          ),
          buildVerticalDiscovery(
              caption: isProfileView
                  ? AppLocalizations.of(context)!.futureHostedEvents
                  : AppLocalizations.of(context)!.futureHostedEventsOrganizer,
              Ids: model.newUserInfo.upcomingEventIds,
              actionButtonType: ActionButtonType.settingsButton),
          buildVerticalDiscovery(
              caption: isProfileView
                  ? AppLocalizations.of(context)!.hostedActivities
                  : AppLocalizations.of(context)!.pastHostedEventsOrganizer,
              Ids: model.newUserInfo.activityIds,
              actionButtonType: ActionButtonType.settingsButton),
          buildVerticalDiscovery(
              caption: isProfileView
                  ? AppLocalizations.of(context)!.pastHostedEvents
                  : AppLocalizations.of(context)!.hostedActivitiesOrganizer,
              Ids: model.newUserInfo.pastEventIds,
              actionButtonType: ActionButtonType.settingsButtonDisabled)
        ];
        return CustomScrollView(slivers: slivers);
      }
    });
  }

  Widget noHostedEA(UserInfo userInfo) {
    return Column(
      children: [
        getProfileSection(context: context, userInfo: userInfo),
        getVerSpace(90.h),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20.h),
          child: Text(
            isProfileView
                ? AppLocalizations.of(context)!.noAssociatedEAMessage
                : AppLocalizations.of(context)!.noAssociatedEAOrganizer,
            textAlign: TextAlign.center,
          ),
        ),
        getVerSpace(3.h),
        if (widget.userInfo == null)
          ElevatedButton(
              onPressed: () => {Get.to(Add())},
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(5.h),
              ),
              child: Icon(Icons.add))
      ],
    );
  }
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
    return getAssetImageProvider(NavigatorConstants.DefaultProfilePicture,
        width: 100.h, height: 100.h);
  }
}

Container getProfileSection(
    {required BuildContext context, required UserInfo userInfo}) {
  return Container(
    color: bgColor,
    width: double.infinity,
    child: Column(
      children: [
        getVerSpace(20.h),
        CircleAvatar(
            radius: 90, backgroundImage: getProfilePictureNullSafe(userInfo)),
        getVerSpace(15.h),
        Text(
          userInfo.profileName,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        getVerSpace(15.h),
        Text(
          userInfo.profileEMail,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        getVerSpace(20.h),
      ],
    ),
  );
}
