import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:othia/utils/ui/ui_utils.dart';

import 'settings/help_settings.dart';
import 'settings/language_settings.dart';
import 'settings/privacy.dart';

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
          title: Text(AppLocalizations.of(context)!.settings),
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
                      Text(AppLocalizations.of(context)!.accountSettings),
                      getVerSpace(12.h),
                      getSettingContainer(() {
                        // TODO
                        () {};
                      }, AppLocalizations.of(context)!.editProfile,
                          Icon(FontAwesomeIcons.userPen)),
                      getVerSpace(20.h),
                      getSettingContainer(
                          // TODO
                          () {},
                          AppLocalizations.of(context)!.changePassword,
                          Icon(FontAwesomeIcons.key)),
                      getVerSpace(30.h),
                      Text(AppLocalizations.of(context)!.preferences),
                      getVerSpace(12.h),
                      getSettingContainer(
                          // TODO
                          () {
                        Get.to(PrivacyScreen());
                      }, AppLocalizations.of(context)!.privacy,
                          Icon(FontAwesomeIcons.shield)),
                      getVerSpace(20.h),
                      getSettingContainer(
                          // TODO
                          () {
                        Get.to(HelpScreen());
                      },
                          AppLocalizations.of(context)!.help,
                          Icon(
                            Icons.info_outline,
                            size: 28.h,
                          )),
                      getVerSpace(20.h),
                      getSettingContainer(() {
                        Get.to(LanguageScreen());
                      }, AppLocalizations.of(context)!.language,
                          Icon(Icons.translate)),
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
                        child: Text(
                          AppLocalizations.of(context)!.logout,
                        ))),
              ),
              getVerSpace(30.h)
            ],
          ),
        ),
      ),
    );
  }
}

Widget getSettingContainer(Function function, String title, Icon icon) {
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
          Icon(
            FontAwesomeIcons.angleRight,
            size: 24.h,
          )
        ],
      ),
    ),
  );
}
