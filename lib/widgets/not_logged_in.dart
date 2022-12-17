import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/utils/ui/ui_utils.dart';

Widget getNotLoggedIn({required BuildContext context}) {
  return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          getVerSpace(200.h),
          Column(
            children: [
              Text(
                AppLocalizations.of(context)!.notLoggedInMessage,
                style: Theme.of(context).textTheme.headline4,
              ),
              getVerSpace(10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                          onPressed:
                              // TODO write logout logic
                              () => {},
                          child: Text("Login"))),
                ),
              ),
            ],
          )
        ],
      ));
}

Widget getLoggedInSensitiveBody(
    {required Widget loggedInWidget,
    required bool isLoggedIn,
    required BuildContext context}) {
  if (isLoggedIn) {
    return loggedInWidget;
  } else {
    return getNotLoggedIn(context: context);
  }
}
