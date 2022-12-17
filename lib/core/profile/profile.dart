import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/widgets/not_logged_in.dart';

import '../../constants/colors.dart';
import '../../utils/ui/ui_utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Object> userInfo;

  bool userLoggedIn = false;

  @override
  void initState() {
    // TODO how to receive the user id?
    // String userId = Get.arguments[NavigatorConstants.EventActivityId] ?? "1";
    // if (userId != null) {
    //   // TODO get user info
    //   userInfo =
    //       RestService().fetchEventOrActivityDetails(eventOrActivityId: userId);
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    Widget appBarAction;
    if (userLoggedIn) {
      body = getProfilePage();
      appBarAction = GestureDetector(
          onTap: () {
            // TODO send to options page
            // Constant.sendToNext(context, Routes.settingRoute);
          },
          child: Icon(
            Icons.settings,
            size: 24.h,
          ));
    } else {
      body = getNotLoggedIn(context: context);
      appBarAction = SizedBox();
    }

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                toolbarHeight: 73.h,
                elevation: 0,
                title: Text(
                  // TODO
                  "Profile",
                ),
                centerTitle: true,
                actions: [appBarAction, getHorSpace(20.h)],
                automaticallyImplyLeading: false),
            body: body));
  }

  Widget getProfilePage() {
    return Expanded(
        flex: 1,
        child: ListView(
          primary: true,
          shrinkWrap: true,
          children: [
            buildProfileSection(),
            getVerSpace(20.h),
            // TODO include hosted event/ activity widget
          ],
        ));
  }
}

Container buildProfileSection() {
  return Container(
    // TODO
    color: accentColor.withOpacity(0.05),
    width: double.infinity,
    child: Column(
      children: [
        getVerSpace(31.h),
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            // TODO
            getAssetImage("profile_image.png", width: 110.h, height: 110.h),
            Positioned(
                child: Container(
              height: 30.h,
              width: 30.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.h),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: shadowColor,
                        offset: const Offset(0, 8),
                        blurRadius: 27)
                  ]),
              padding: EdgeInsets.all(5.h),
              child: getSvgImage("edit.svg", width: 20.h, height: 20.h),
            ))
          ],
        ),
        getVerSpace(15.h),
        // TODO
        Text("Jenny Wilson"),
        // Contact details
        getVerSpace(20.h),
      ],
    ),
  );
}
