import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:othia/utils/services/events/record_event.dart';
import 'package:permission_handler/permission_handler.dart';

import '../rest-api/amplify/amp.dart';

Future<bool> requestCalendarPermissions() async {
  var permissionStatus = await Permission.calendar.status;
  if (permissionStatus == PermissionStatus.granted) {
    // User has already granted permission to access the calendar.
    return true;
  }

  permissionStatus = await Permission.calendar.request();

  if (permissionStatus != PermissionStatus.granted) {
    //await openAppSettings();
    return false;
  }
  return true;
}

Future<void> findFreeTimes() async {
  DateTime start = DateTime.now();
  DateTime end = DateTime.now().add(Duration(days: 90));
  final DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();

  // var permissionsGranted = await _deviceCalendarPlugin.hasPermissions();
  // if (permissionsGranted.isSuccess && !(permissionsGranted.data ?? true)) {
  //   permissionsGranted = await _deviceCalendarPlugin.requestPermissions();
  //   if (!permissionsGranted.isSuccess || !(permissionsGranted.data ?? true)) {
  //     print("failure");
  //   }
  // }

  final calendarsResult = await _deviceCalendarPlugin.retrieveCalendars();

  if (!calendarsResult.isSuccess) {
    // Handle the error
    return;
  }

  final calendars = calendarsResult.data!;
  if (calendars.isEmpty) {
    return;
  }

  List<Event> events = [];
  for (var calendar in calendars) {
    final eventsResult = await _deviceCalendarPlugin.retrieveEvents(
      calendar.id,
      RetrieveEventsParams(
        startDate: start,
        endDate: end,
      ),
    );
    if (eventsResult.isSuccess && (eventsResult.data?.isNotEmpty ?? false)) {
      events.addAll(eventsResult.data!);
    }
  }

  // get the user time here to save calls
  String? userId;
  try {
    userId = await getUserId();
  } on SignedOutException catch (_) {}

  int issuingTime = DateTime.now().millisecondsSinceEpoch;
  for (var event in events) {
    recordCustomEvent(
        eventName: "userOccupiedTimeIntervals",
        userId: userId,
        eventParams: {
          'issuingTime': issuingTime,
          'start': event.start?.millisecondsSinceEpoch,
          'end': event.end?.millisecondsSinceEpoch
        });
  }
}
