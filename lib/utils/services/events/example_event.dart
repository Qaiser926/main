import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '../rest-api/amplify/amp.dart';

Future<void> recordCustomEvent(
    {required String eventName,
    required Map<String, dynamic> eventParams,
    String? userId}) async {
  Map<String, dynamic> eventParameters = {};
  if (userId == null) {
    try {
      eventParameters['userId'] = await getUserId();
    } on SignedOutException catch (_) {
      eventParameters['userId'] = '';
    }
  } else {
    eventParameters['userId'] = userId;
  }

  eventParams.forEach((key, value) {
    eventParameters[key] = json.encode(value);
  });

  if (eventParams.containsKey('selectedCategoryIds')) {
    // firebase is very restrictive regarding the length of names and values, as workaround the search query is stored for every selected category
    searchCase(
        eventParams: eventParams,
        eventParameters: eventParameters,
        eventName: eventName);
  } else {
    FirebaseAnalytics.instance.logEvent(
      name: eventName,
      parameters: eventParameters,
    );
  }
}

Future<void> searchCase(
    {required String eventName,
    required Map<String, dynamic> eventParams,
    required Map<String, dynamic> eventParameters}) async {
  // remove key "selectedCategoryIds"
  eventParameters.remove('selectedCategoryIds');
  // log for every categoryId
  eventParams['selectedCategoryIds'].forEach((categoryId) {
    eventParameters['selectedCategoryId'] = categoryId;
    FirebaseAnalytics.instance.logEvent(
      name: eventName,
      parameters: eventParameters,
    );
  });
}

// import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
// MethodChannel sdf = MethodChannel('com.amazonaws.amplify/analytics_pinpoint');
//
// final eAClickedEvent = EAClickedEvent(
//     buttonName: 'EAdetails', eAId: "EVENT ACTIVTIY ID", userId: "USER ID");
// Amplify.Analytics.recordEvent(event: eAClickedEvent);
//
// final eALikedEvent = EALikedEvent(
//     buttonName: "EALIKED", userId: "SELBER USER", eAId: "ANDERES EVENT");
// Amplify.Analytics.recordEvent(event: eALikedEvent);

// always add the userId here

// analytics.setAnalyticsCollectionEnabled(true);
// analytics.setConsent(
//     adStorageConsentGranted: true, analyticsStorageConsentGranted: true);
// analytics.setUserId(id: "newUserId");
// analytics.setSessionTimeoutDuration(Duration(seconds: 1));
// // analytics.logEvent(name: "testgoogleEvent");
// analytics.logSearch(searchTerm: "searchTerm");
//
// // use case unclear
// await FirebaseAnalytics.instance.logSelectContent(
//   contentType: "image",
//   itemId: "itemId",
// );
// analytics.setUserProperty(name: 'table', value: 'yes i am a table');

//String searchQueryJson = json.encode(eventParams['searchQuery']);
//eventParams['searchQuery'] = searchQueryJson;

//Amplify.Analytics.flushEvents();

// AnalyticsUserProfileLocation location = AnalyticsUserProfileLocation();
// location.latitude = 32.423424;
// location.longitude = -52.342342;
// location.postalCode = '98122';
// location.city = 'Seattle';
// location.region = 'WA';
// location.country = 'USA';
//
// AnalyticsProperties properties = AnalyticsProperties();
// properties.addStringProperty('phoneNumber', '+11234567890');
// properties.addIntProperty('age', 25);
//
// AnalyticsUserProfile userProfile = AnalyticsUserProfile();
// userProfile.name = username;
// userProfile.email = 'name@example.com';
// userProfile.location = location;
//
// Amplify.Analytics.identifyUser(userId: userId, userProfile: profile);
