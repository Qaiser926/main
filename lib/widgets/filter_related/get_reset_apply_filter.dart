import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Widget getShowResultsButton(
    {required BuildContext context,
    required Function functionAccept,
    required Map<Symbol, dynamic> functionArgumentsAccept,
    required Function functionReset,
    required Map<Symbol, dynamic> functionArgumentsReset,
    bool closeDialog = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            Function.apply(functionReset, [], functionArgumentsReset);
          },
          child: Container(
            padding: EdgeInsets.all(12),
            child: Text(AppLocalizations.of(context)!.clear),
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)))),
            child: Text(AppLocalizations.of(context)!.showResults),
            onPressed: () {
              Function.apply(functionAccept, [], functionArgumentsAccept);
              if (closeDialog) Get.back();
            }),
      ),
    ],
  );
}
