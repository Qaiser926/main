import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

const Widget defaultStillLoadingWidget = 
Center(
  child: Shimmer(
    gradient: LinearGradient(
      colors: [Colors.grey, Colors.white, Colors.grey],
      stops: [0.1, 0.3, 0.4],
      begin: Alignment(-1.0, -0.3),
      end: Alignment(1.0, 0.3),
      tileMode: TileMode.repeated,
    ),
    child: Center(
      child: Shimmer(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.white, Colors.white],
          stops: [0.1, 0.3, 0.4],
          begin: Alignment(-1.0, -0.3),
          end: Alignment(1.0, 0.3),
          tileMode: TileMode.clamp,
        ),
        child: Center(
          child: Text(
            "   . . .   ",
            style: TextStyle(
                color: Colors.grey, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          // child: CircularProgressIndicator(),
        ),
      ),
    ),
  ),
);

Widget errorMessage(String errorMessage, BuildContext context) {
  return Padding(
      padding: EdgeInsets.all(20.h),
      child: Text(errorMessage,
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          )));
}

const Widget defaultWidget = Text("Ok");

Widget defaultErrorFunction(dynamic snapshot, BuildContext context) {
  int firstDigit = 4;
  try {
    int firstDigit = int.parse(snapshot.error.httpStatusCode.toString()[0]);
  } catch (e) {}

  if (firstDigit == 5) {
    return errorMessage(
        AppLocalizations.of(context)!.internalServerError, context);
  } else if (snapshot.error.httpStatusCode == 403) {
    return errorMessage(
        AppLocalizations.of(context)!.forbiddenErrorMessage, context);
  } else if (snapshot.error.httpStatusCode == 404) {
    return errorMessage(
        AppLocalizations.of(context)!.notFoundErrorMessage, context);
  } else {
    return errorMessage(
        AppLocalizations.of(context)!.defaultRequestErrorMessage, context);
  }
}

Widget messageErrorFunction(dynamic snapshot, BuildContext context) {
  int firstDigit = int.parse(snapshot.error.httpStatusCode.toString()[0]);
  String? jsonMessage = jsonDecode(snapshot.error.message);
  if (firstDigit == 5) {
    return errorMessage(
        jsonMessage ?? AppLocalizations.of(context)!.internalServerError,
        context);
  } else if (snapshot.error.httpStatusCode == 403) {
    return errorMessage(
        AppLocalizations.of(context)!.forbiddenErrorMessage, context);
  } else if (snapshot.error.httpStatusCode == 404) {
    return errorMessage(
        AppLocalizations.of(context)!.notFoundErrorMessage, context);
  } else {
    return errorMessage(
        AppLocalizations.of(context)!.defaultRequestErrorMessage, context);
  }
}

Widget snapshotHandler(
  BuildContext context,
  snapshot,
  Function function,
  List<dynamic> functionArguments, {
  Widget loadingWidget = defaultStillLoadingWidget,
  Function defaultErrorFunction = defaultErrorFunction,
}) 
{
  switch (snapshot.connectionState) {
    case ConnectionState.waiting:
      return loadingWidget;
    case ConnectionState.done:
      if (snapshot.hasError) {
        Get.snackbar("", "",
            titleText: Text(snapshot.error),
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white);
        return defaultErrorFunction(snapshot, context);
        //TODO clear  (extern) implement rest error handling, please document your expected behaviour

        throw Exception(snapshot.error);
      } else {
        RestResponse data = snapshot.data as RestResponse;
        try {
          Map<String, dynamic> decodedJson = jsonDecode(data.body);
          functionArguments.add(decodedJson);
          return Function.apply(function, functionArguments);
          return function(decodedJson);
        } catch (e) {
          //TODO clear (extern) catch more specific and handle accordingly
          Get.snackbar("", "",
              titleText: Text(e.toString()),
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white);
          throw e;
          
        }
      }
    default:
      return defaultWidget;
  }
}
