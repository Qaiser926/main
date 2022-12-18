import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:othia/constants/locales_settings.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
        // TODO align colors
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,

        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: SafeArea(
          child: Column(
            children: [
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
                      }, "Edit Profile", Icon(FontAwesomeIcons.userEdit)),
                      getVerSpace(20.h),
                      settingContainer(
                          // TODO
                          () {},
                          "Change Password",
                          Icon(FontAwesomeIcons.key)),
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
                      }, "Privacy", Icon(FontAwesomeIcons.shield)),
                      getVerSpace(20.h),
                      settingContainer(
                          // TODO
                          () {},
                          "Help",
                          Icon(Icons.info_outline)),
                      getVerSpace(20.h),
                      settingContainer(
                          // TODO
                          () {
                        context
                            .read<LocaleProvider>()
                            .setLocale(Locale('de', ''));
                      }, AppLocalizations.of(context)!.hostedActivities,
                          Icon(Icons.info_outline)),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity,
                              35.h), // <--- this line helped me
                        ),
                        onPressed:
                            // TODO write logout logic
                            () => {},
                        child: Text("Logout"))),
              ),
              getVerSpace(30.h)
            ],
          ),
        ),
      ),
    );
  }
}

Widget settingContainer(Function function, String title, Icon icon) {
  return GestureDetector(
    onTap: () {
      function();
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.h),
      ),
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
                child: icon,
              ),
              getHorSpace(16.h),
              Text(title),
            ],
          ),
          // TODO, maybe keyboard_arrow_right
          Icon(
            FontAwesomeIcons.angleRight,
            size: 24.h,
          )
        ],
      ),
    ),
  );
}
