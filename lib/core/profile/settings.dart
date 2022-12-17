import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:othia/utils/ui/ui_utils.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  void backClick() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        backClick();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: getToolBar(
          () {
            backClick();
          },
          title: Text("Settings"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Divider(
                thickness: 1.h,
              ),
              Expanded(
                  flex: 1,
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    primary: true,
                    shrinkWrap: true,
                    children: [
                      getVerSpace(20.h),
                      Text("Account Settings"),
                      getVerSpace(12.h),
                      settingContainer(() {
                        // TODO
                        () {};
                      }, "Edit Profile", "edit_profile.svg"),
                      getVerSpace(20.h),
                      settingContainer(
                          // TODO
                          () {},
                          "Change Password",
                          "change_password.svg"),
                      getVerSpace(30.h),
                      Text("Preferences"),
                      getVerSpace(12.h),
                      // settingContainer(() {
                      //   // TODO
                      //       () {};
                      // }, "Notification", "notification-image.svg"),
                      // getVerSpace(20.h),

                      settingContainer(() {
                        // TODO
                        () {};
                      }, "Privacy", "privacy.svg"),
                      getVerSpace(20.h),
                      settingContainer(
                          // TODO
                          () {},
                          "Help",
                          "info.svg"),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                          onPressed:
                              // TODO write logout logic
                              () => {},
                          child: Text("Logout"))),
                ),
              ),
              getVerSpace(30.h)
            ],
          ),
        ),
      ),
    );
  }
}

Widget settingContainer(Function function, String title, String image) {
  return GestureDetector(
    onTap: () {
      function();
    },
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22.h),
          boxShadow: [
            BoxShadow(
                // TODO style
                offset: const Offset(0, 8),
                blurRadius: 27)
          ]),
      padding: EdgeInsets.only(bottom: 3.h, left: 3.h, top: 3.h, right: 18.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 54.h,
                width: 54.h,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(22.h)),
                padding: EdgeInsets.all(15.h),
                child: getAssetImage(image, width: 24.h, height: 24.h),
              ),
              getHorSpace(16.h),
              Text(title),
            ],
          ),
          // TODO
          getAssetImage("arrow_right.svg", height: 24.h, width: 24.h)
        ],
      ),
    ),
  );
}
