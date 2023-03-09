import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/constants/no_internet.dart';
import 'package:othia/constants/no_internet_controller.dart';
import 'package:othia/core/profile/settings.dart';
import 'package:othia/core/profile/user_info_notifier.dart';
import 'package:othia/modules/models/shared_data_models.dart';
import 'package:othia/modules/models/user_info/user_info.dart';
import 'package:othia/utils/helpers/diverse.dart';
import 'package:othia/utils/services/global_navigation_notifier.dart';
import 'package:othia/utils/services/rest-api/rest_api_service.dart';
import 'package:othia/utils/ui/future_service.dart';
import 'package:othia/widgets/action_buttons.dart';
import 'package:othia/widgets/keep_alive_future_builder.dart';
import 'package:othia/widgets/not_logged_in.dart';
import 'package:othia/widgets/vertical_discovery/vertical_discovery_framework.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../constants/colors.dart';
import '../../utils/services/events/example_event.dart';
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
  final connectivity=Connectivity();
   final StudentLocationController studentFindTutorsController=Get.put(StudentLocationController());

  @override
  void initState() {
    isProfileView = widget.userInfo == null;
    GlobalNavigationNotifier globalNot =
        Provider.of<GlobalNavigationNotifier>(context, listen: false);
    userInfoFuture = isProfileView
        ? globalNot.isUserLoggedIn
            ? RestService().getPrivateUserInfo()
            : Future.value(UserInfo(
                activityIds: [],
                pastEventIds: [],
                upcomingEventIds: [],
                profileEmail: "",
                profileName: "",
                userId: "",
                birthdate: null,
                profilePhoto: "",
                gender: Gender.male))
        : RestService().getPublicUserInfo(organizerId: widget.userInfo!.userId);
    isProfileView
        ? FirebaseAnalytics.instance.setCurrentScreen(
            screenName: 'profileScreen',
          )
        : {
            FirebaseAnalytics.instance.setCurrentScreen(
              screenName: 'publisherScreen',
            ),
            recordCustomEvent(
                eventName: "viewPublisher",
                eventParams: {'publisherId': widget.userInfo!.userId}),
          };
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
                automaticallyImplyLeading: false,
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
                      : Container(),
                  isProfileView
                        ? SizedBox()
                      : GestureDetector(
                          onTap: () {
                             openShare('organizerShareLinkBuilder', context);
                             },
                          child: Icon(
                            Icons.share,
                            size: 24.h,
                          )),
                  getHorSpace(20.h)
                ],
              ),
              body: Obx(()=>Container(
        child: studentFindTutorsController.connectionStatus.value==1? isProfileView
                  ? getLoggedInSensitiveBody(
                      context: context,
                      loggedInWidget: profilePageFutureBuilder(context),
                    )
                  : profilePageFutureBuilder(context)
      :studentFindTutorsController.connectionStatus.value==2? isProfileView
                  ? getLoggedInSensitiveBody(
                      context: context,
                      loggedInWidget: profilePageFutureBuilder(context),
                    )
                  : profilePageFutureBuilder(context):Container(
        width: Get.size.width,
        height: Get.size.height,
        child: Column(
          children: [
            Lottie.asset('assets/lottiesfile/no_internet.json',fit: BoxFit.cover),
         
          ],
        ),
      )))
             
                  
                  );
        },
      ),
    );
  }
mainBody(){
  return   isProfileView
                  ? getLoggedInSensitiveBody(
                      context: context,
                      loggedInWidget: profilePageFutureBuilder(context),
                    )
                  : profilePageFutureBuilder(context);
                  
}
  Widget profilePageFutureBuilder(BuildContext context) {
    UserInfoNotifier userInfoNotifier =
        Provider.of<UserInfoNotifier>(context, listen: false);
    return KeepAliveFutureBuilder(
        future: userInfoFuture,
        builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
                      return Center(child: defaultStillLoadingWidget);
                    }
          if(snapshot.hasData){
          return MultiProvider(
              providers: [
                ChangeNotifierProvider.value(
                  value: userInfoNotifier,
                )
              ],
              child: snapshotHandler(
                  context, snapshot, getProfilePage, [context],
                  defaultErrorFunction: messageErrorFunction));
        }else{
                    return Center(child: Text("No Data Exit"),);
                  }
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
              actionButtonType: isProfileView
                  ? ActionButtonType.settingsButton
                  : ActionButtonType.addLikeButton),
          buildVerticalDiscovery(
              caption: isProfileView
                  ? AppLocalizations.of(context)!.hostedActivities
                  : AppLocalizations.of(context)!.pastHostedEventsOrganizer,
              Ids: model.newUserInfo.activityIds,
              actionButtonType: isProfileView
                  ? ActionButtonType.settingsButton
                  : ActionButtonType.addLikeButton),
          buildVerticalDiscovery(
              caption: isProfileView
                  ? AppLocalizations.of(context)!.pastHostedEvents
                  : AppLocalizations.of(context)!.hostedActivitiesOrganizer,
              Ids: model.newUserInfo.pastEventIds,
              actionButtonType: isProfileView
                  ? ActionButtonType.settingsButton
                  : ActionButtonType.addLikeButton)
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
  // TODO clear (extern) email must be copyable
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
        InkWell(
          onTap: () {
            Clipboard.setData(ClipboardData(
              text: userInfo.profileEmail,
            ));
          },
          child: Text(
            userInfo.profileEmail,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        getVerSpace(20.h),
      ],
    ),
  );

}
