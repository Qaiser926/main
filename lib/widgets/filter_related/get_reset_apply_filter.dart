import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'search_notifier.dart';

Widget getShowResultsButton(
    {required BuildContext context, required Function function, required Map<Symbol,dynamic> functionArguments}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
          flex: 1,
          child: GestureDetector(
              onTap: () {
                Provider.of<SearchNotifier>(context, listen: false)
                    .backToDefault();
                Navigator.of(context, rootNavigator: true).pop();
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
                Function.apply(
                    function, [], functionArguments);
                Navigator.of(context, rootNavigator: true).pop();
              })),
    ],
  );
}