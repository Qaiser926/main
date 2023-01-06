import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/core/add/add.dart';

Future getInfoDialog({required String info, required BuildContext context}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(info),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      });
}

Widget getHeadlineWithInfoDialog(
    {required BuildContext context,
    required String infoText,
    required String caption}) {
  return getHeadline(
    context: context,
    caption: GestureDetector(
      onTap: () => {getInfoDialog(info: infoText, context: context)},
      child: Row(children: [
        Text(caption, style: Theme.of(context).textTheme.headlineLarge),
        Padding(
          padding: EdgeInsets.only(left: 5.h),
          child: Icon(Icons.info_outline, size: 14),
        )
      ]),
    ),
  );
}
