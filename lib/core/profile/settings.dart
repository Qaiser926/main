import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:othia/core/main_page.dart';
import 'package:othia/core/profile/profile.dart';
import 'package:othia/core/profile/settings/change_password.dart';
import 'package:othia/core/profile/settings/edit_profile.dart';
import 'package:othia/core/profile/user_info_notifier.dart';
import 'package:othia/utils/services/global_navigation_notifier.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:othia/widgets/nav_bar/nav_bar_notifier.dart';
import 'package:provider/provider.dart';

import '../login/login.dart';
import 'settings/help_settings.dart';
import 'settings/language_settings.dart';
import 'settings/privacy.dart';

class SettingsScreen extends StatefulWidget {
  final UserInfoNotifier userInfoNotifier;

  const SettingsScreen(UserInfoNotifier this.userInfoNotifier, {Key? key})
      : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void backClick() {
    Get.back();
  }
   late bool isProfileView;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        backClick();
        return false;
      },
      child: Scaffold(
        // TODO clear (extern) align color of appbar
        // TODO clear (extern) align buttons left at height of caption

        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.primary,
                )),
            toolbarHeight: 53.h,
            elevation: 0,
            title: Text(AppLocalizations.of(context)!.settings),
            centerTitle: true,
            automaticallyImplyLeading: false),
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
                      buildAccountSettings(),
                      Text(AppLocalizations.of(context)!.preferences,
                          style: Theme.of(context).textTheme.headlineLarge),
                      getVerSpace(12.h),
                      getSettingContainer(() {
                        Get.to(const PrivacyScreen());
                      }, AppLocalizations.of(context)!.privacy,
                          const Icon(FontAwesomeIcons.shield)),
                      getVerSpace(20.h),
                      getSettingContainer(() {
                        Get.to(const HelpScreen());
                      },
                          AppLocalizations.of(context)!.help,
                          Icon(
                            Icons.info_outline,
                            size: 28.h,
                          )),
                      getVerSpace(20.h),
                      getSettingContainer(() {
                        Get.to(const LanguageScreen());
                      }, AppLocalizations.of(context)!.language,
                          const Icon(Icons.translate)),
                    ],
                  )),
              Provider.of<GlobalNavigationNotifier>(context, listen: false)
                      .isUserLoggedIn
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity,
                                    35.h), // <--- this line helped me
                              ),
                              onPressed: () {
                                setState(() {
                                  Provider.of<GlobalNavigationNotifier>(context,
                                          listen: false)
                                      .logout();
                                      Get.off(  MainPage(),transition: Transition.fadeIn);
                                    // TODO clear (extern) improve design, only show this if logout was indeed successful


                                  Get.snackbar("", "",titleText:  Text(
                                        AppLocalizations.of(context)!
                                            .successfulLogoutMessage,style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                                        textAlign: TextAlign.center),snackPosition: SnackPosition.BOTTOM);
                                });
                              },
                              child: Text(
                                AppLocalizations.of(context)!.logout,
                              ))),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity,
                                    35.h), // <--- this line helped me
                              ),
                              onPressed: () => Get.to(Login()),
                              //TODO internationalization
                              child: Text(
                                "Login",
                              ))),
                    ),
              getVerSpace(30.h)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAccountSettings() {
    return Provider.of<GlobalNavigationNotifier>(context, listen: false)
            .isUserLoggedIn
        ? Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(AppLocalizations.of(context)!.accountSettings,
                    style: Theme.of(context).textTheme.headlineLarge),
              ),
              getVerSpace(12.h),
              getSettingContainer(() {
                Get.to(EditProfile(widget.userInfoNotifier));
              }, AppLocalizations.of(context)!.editProfile,
                  const Icon(FontAwesomeIcons.userPen)),
              getVerSpace(20.h),
              getSettingContainer(() {
                Get.to(ChangePasswordScreen());
              }, AppLocalizations.of(context)!.changePassword,
                  const Icon(FontAwesomeIcons.key)),
              getVerSpace(30.h),
            ],
          )
        : SizedBox();
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
              getHorSpace(19.h),
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
