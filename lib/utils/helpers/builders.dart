import 'dart:convert';

import 'package:othia/amplifyconfiguration.dart';
import 'package:othia/constants/app_constants.dart';

String eAShareLinkBuilder(String eAId) {
  String shareLink = OthiaConstants.othiaDomain;
  shareLink += "/";
  shareLink += OthiaConstants.eventDetailPath;
  shareLink += "/";
  shareLink += eAId;
  return shareLink;
}

String organizerShareLinkBuilder(String eAId) {
  String shareLink = OthiaConstants.othiaDomain;
  shareLink += "/";
  shareLink += OthiaConstants.organizerDetailPath;
  shareLink += "/";
  shareLink += eAId;
  return shareLink;
}

String getAwsApiEndpoint() {
  String result = "";
  final String amplifyConfig = amplifyconfig;
  final dynamic amplifyConfigJson = json.decode(amplifyConfig);
  result = amplifyConfigJson["api"]["plugins"]["awsAPIPlugin"]["othiaApi"]
      ["endpoint"];
  return result;
}
