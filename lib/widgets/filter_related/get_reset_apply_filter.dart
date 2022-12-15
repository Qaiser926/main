import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../core/search/search.dart';

Widget getShowResultsButton(
    {required BuildContext context,
    required Function function,
    required Map<Symbol, dynamic> functionArguments,
    bool closeDialog = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
          flex: 1,
          child: GestureDetector(
              onTap: () {
                Get.back();
                // Navigator.popUntil(context, (route) {

                //   if (route == Routes.mainScreenRoute) {
                //     return true;
                //   } else {
                //     return false;
                //   }
                // });
                Get.offAll(
                  SearchPage(),
                );
              },
              child: Container(
                padding: EdgeInsets.all(12),
                child: Text(AppLocalizations.of(context)!.clearAll),
              ))),
      Expanded(
          flex: 1,
          child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)))),
              child: Text(AppLocalizations.of(context)!.showResults),
              onPressed: () {
                Function.apply(function, [], functionArguments);
                if (closeDialog) Get.back();
              })),
    ],
  );
}
