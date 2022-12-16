import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';

const Widget defaultStillLoadingWidget = Center(
  child: CircularProgressIndicator(),
);
const Widget defaultErrorWidget = Text("An error accured");
const Widget defaultDefaultWidget = Text("default");

Widget snapshotHandler(
  snapshot,
  Function function,
  List<dynamic> functionArguments, {
  Widget loadingWidget = defaultStillLoadingWidget,
}) {
  switch (snapshot.connectionState) {
    case ConnectionState.waiting:
      return loadingWidget;
    case ConnectionState.done:
      if (snapshot.hasError) {
        return defaultErrorWidget;
        //TODO implement rest error handling
        // throw Exception(snapshot.error);
      } else {
        RestResponse data = snapshot.data as RestResponse;
        try {
          Map<String, dynamic> decodedJson = jsonDecode(data.body);
          functionArguments.add(decodedJson);
          return Function.apply(function, functionArguments);
          return function(decodedJson);
        } catch (e) {
          //TODO catch more specifi and handle accordingly
          throw e;
        }
      }
    default:
      return defaultDefaultWidget;
  }
}
