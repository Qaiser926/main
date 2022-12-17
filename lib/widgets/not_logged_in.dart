import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/utils/ui/ui_utils.dart';

Widget getNotLoggedIn() {
  return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          getVerSpace(200.h),
          Column(
            children: [
              Text("To view this feature you must be logged in"),
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
    {required Widget loggedInWidget, required bool isLoggedIn}) {
  if (isLoggedIn) {
    return loggedInWidget;
  } else {
    return getNotLoggedIn();
  }
}
