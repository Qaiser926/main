import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '../rest-api/amplify/amp.dart';

Future<void> recordCustomEvent(
    {required String eventName,
    required Map<String, dynamic> eventParams}) async {
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

  FirebaseAnalytics analytics = await FirebaseAnalytics.instance;
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
  try {
    eventParams['userId'] = await getUserId();
  } on SignedOutException catch (e) {
    eventParams['userId'] = null;
  }

  analytics.logEvent(
    name: eventName,
    parameters: eventParams,
  );

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
}

class AnalyticsConstants {
  static const String buttonClickedEventName = "ButtonClickedEvent";
  static const String buttonName = "ButtonName";
  static const String userId = "userId";
  static const String eAId = "eAId";
}

class ButtonClickedEvent extends AnalyticsEvent {
  ButtonClickedEvent({
    required String buttonName,
    required String userId,
  }) : super(AnalyticsConstants.buttonClickedEventName) {
    properties.addStringProperty(AnalyticsConstants.buttonName, buttonName);
    properties.addStringProperty(AnalyticsConstants.userId, userId);
  }
}
//warum die Daten nicht in der entsprechenden Lambda funktion erfassen?

class EAEvent extends ButtonClickedEvent {
  EAEvent(
      {required super.buttonName,
      required super.userId,
      required String eAId}) {
    properties.addStringProperty(AnalyticsConstants.eAId, eAId);
  }
}

class EAClickedEvent extends EAEvent {
  EAClickedEvent(
      {required super.buttonName,
      required super.userId,
      required super.eAId}) {}
}

class EALikedEvent extends EAEvent {
  EALikedEvent(
      {required super.buttonName,
      required super.userId,
      required super.eAId}) {}
}
