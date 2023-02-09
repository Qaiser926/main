import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const Widget defaultStillLoadingWidget = Center(
  child: CircularProgressIndicator(),
);

Widget errorMessage(String errorMessage, BuildContext context) {
  return Padding(
      padding: EdgeInsets.all(20.h),
      child: Text(AppLocalizations.of(context)!.deleteErrorMessage,
          style: TextStyle(
            color: Theme.of(context).colorScheme.error,
          )));
}

const Widget defaultWidget = Text("Ok");

Widget defaultErrorFunction(dynamic snapshot) {
  if (snapshot.error.httpStatusCode == 403) {}
  return Text("default");
}

Widget snapshotHandler(
  BuildContext context,
  snapshot,
  Function function,
  List<dynamic> functionArguments, {
  Widget loadingWidget = defaultStillLoadingWidget,
  Function defaultErrorFunction = defaultErrorFunction,
}) {
  switch (snapshot.connectionState) {
    case ConnectionState.waiting:
      return loadingWidget;
    case ConnectionState.done:
      if (snapshot.hasError) {
        return defaultErrorFunction(snapshot, context);
        //TODO (extern) implement rest error handling, please document your expected behaviour
        // throw Exception(snapshot.error);
      } else {
        RestResponse data = snapshot.data as RestResponse;
        try {
          Map<String, dynamic> decodedJson = jsonDecode(data.body);
          functionArguments.add(decodedJson);
          return Function.apply(function, functionArguments);
          return function(decodedJson);
        } catch (e) {
          //TODO (extern) catch more specific and handle accordingly
          throw e;
        }
      }
    default:
      return defaultWidget;
  }
}
