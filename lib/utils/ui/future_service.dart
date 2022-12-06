import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';

class StillLoading implements Exception {}

Map<String, dynamic> snapshotHandler(snapshot) {
  if (snapshot.connectionState != ConnectionState.done) {
    throw StillLoading();
  } else {
    if (snapshot.hasError) {
      //TODO implement rest error handling
      throw Exception(snapshot.error);
    } else {
      RestResponse data = snapshot.data as RestResponse;
      try {
        Map<String, dynamic> decodedJson = jsonDecode(data.body);
        return decodedJson;
      } catch (e) {
        //TODO catch more specifi and handle accordingly
        throw e;
      }
    }
  }
}
