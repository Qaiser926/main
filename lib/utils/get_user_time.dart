import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<List<TimeOfDay>> findFreeTimes() async {
  DateTime start = DateTime.now();
  DateTime end = DateTime.now().add(Duration(days: 7));
  final DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();

  Future<void> requestCalendarPermissions() async {
    var permissionStatus = await _deviceCalendarPlugin.hasPermissions();
    if (permissionStatus == PermissionStatus.granted) {
      // User has already granted permission to access the calendar.
      return;
    }

    permissionStatus = await _deviceCalendarPlugin.requestPermissions();

    if (permissionStatus != PermissionStatus.granted) {
      throw Exception('User did not grant permission to access the calendar');
    }
  }

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

  List<TimeOfDay> freeTimes = [];
  DateTime current = start;
  while (current.isBefore(end)) {
    bool isFree = true;
    for (var event in events) {
      if (event.start!.isBefore(current.add(Duration(hours: 1))) &&
          event.end!.isAfter(current)) {
        isFree = false;
        break;
      }
    }
    if (isFree) {
      freeTimes.add(TimeOfDay.fromDateTime(current));
    }
    current = current.add(Duration(hours: 1));
  }

  return freeTimes;
}
