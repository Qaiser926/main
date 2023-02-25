import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:othia/core/login/login.dart';
import 'package:othia/utils/services/global_navigation_notifier.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:provider/provider.dart';

Widget getNotLoggedIn(
    {required BuildContext context,
    required NotLoggedInMessage notLoggedInMessage}) {
  return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          getVerSpace(200.h),
          Column(
            children: [
              Text(
                getNotLoggedInMessage(notLoggedInMessage, context),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              getVerSpace(10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: FittedBox(
                  child: Padding(
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                          onPressed: () => Get.to(Login()),
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 14),
                          ))),
                ),
              ),
            ],
          )
        ],
      ));
}

Widget getLoggedInSensitiveBody(
    {required Widget loggedInWidget,
    required BuildContext context,
    NotLoggedInMessage notLoggedInMessages = NotLoggedInMessage.standard}) {
  if (Provider.of<GlobalNavigationNotifier>(context, listen: false)
      .isUserLoggedIn) {
    return loggedInWidget;
  } else {
    return getNotLoggedIn(
        context: context, notLoggedInMessage: notLoggedInMessages);
  }
}

enum NotLoggedInMessage {
  standard,
  addPage,
}

String getNotLoggedInMessage(
    NotLoggedInMessage notLoggedInMessages, BuildContext context) {
  Map messages = {
    NotLoggedInMessage.standard:
        AppLocalizations.of(context)!.notLoggedInMessage,
    NotLoggedInMessage.addPage:
        AppLocalizations.of(context)!.notLoggedInMessageAdd
  };
  return messages[notLoggedInMessages];
}