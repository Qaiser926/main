import 'package:add_2_calendar/add_2_calendar.dart';

import 'data_handling.dart';

// instructions for not opening calendar app, more information on https://pub.dev/packages/add_2_calendar
// <uses-permission android:name="android.permission.WRITE_CALENDAR" />
// <uses-permission android:name="android.permission.READ_CALENDAR" />
//
// <queries>
// <intent>
// <action android:name="android.intent.action.INSERT" />
// <data android:mimeType="vnd.android.cursor.item/event" />
// </intent>
// </queries>
//
// <key>NSCalendarsUsageDescription</key>
// <string>INSERT_REASON_HERE</string>
//
// <key>NSContactsUsageDescription</key>
// <string>INSERT_REASON_HERE</string>


Event getIcalElement({required String title, String? description, String? locationText, required String startTimeUtc, String? endTimeUtc }){
  DateTime startDate = getLocalDateTime(dateTimeUtc: startTimeUtc)!;
  var endDate = null;
  if (endTimeUtc != null) {
    endDate = getLocalDateTime(dateTimeUtc: endTimeUtc);
  } else {
    endDate = startDate.add(Duration(hours: 1));
  }
  final Event event = Event(
    title: title,
    description: description,
    location: locationText,
    startDate: startDate,
    endDate: endDate,
  );
  return event;
}