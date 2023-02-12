import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

Future<void> recordCustomEvent() async {
  final eAClickedEvent = EAClickedEvent(
      buttonName: 'EAdetails', eAId: "EVENT ACTIVTIY ID", userId: "USER ID");
  Amplify.Analytics.recordEvent(event: eAClickedEvent);

  final eALikedEvent = EALikedEvent(
      buttonName: "EALIKED", userId: "SELBER USER", eAId: "ANDERES EVENT");
  Amplify.Analytics.recordEvent(event: eALikedEvent);

  Amplify.Analytics.flushEvents();
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
