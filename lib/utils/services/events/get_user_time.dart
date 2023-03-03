import 'package:device_calendar/device_calendar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tuple/tuple.dart';



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

Future<List<Tuple2<DateTime?, DateTime?>>> findFreeTimes() async {
  DateTime start = DateTime.now();
  DateTime end = DateTime.now().add(Duration(days: 7));
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
    return [];
  }

  final calendars = calendarsResult.data!;
  if (calendars.isEmpty) {
    return [];
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

  final List<Tuple2<DateTime?, DateTime?>> userTimes = [];
  for (var event in events) {
    userTimes.add(Tuple2(event.start, event.end));
  }

  return userTimes;
}
