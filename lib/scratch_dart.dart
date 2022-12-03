import 'dart:convert';

import 'package:instant/instant.dart';

main() {
  // final utcInLocal = DateTime.parse('2022-09-12 08:11:00');
  //
  // final startTimeUtc = DateTime.utc(utcInLocal.year, utcInLocal.month,
  //     utcInLocal.day, utcInLocal.hour, utcInLocal.minute);
  // final startTimeLocal = startTimeUtc.subtract(-DateTime.now().timeZoneOffset);
  // print(
  //     "${startTimeLocal.day.toString().padLeft(2, '0')}.${startTimeLocal.month.toString().padLeft(2, '0')}.${startTimeLocal.year}, ${startTimeLocal.hour.toString().padLeft(2, '0')}:${startTimeLocal.minute.toString().padLeft(2, '0')}");
  // print(startTimeLocal.weekday);

  String some =
      """{"futureEvents": [{"categoryId": "8063ce0b-3645-4fcb-8445-f9ea23243e15", "title": "test_event", "startTimeUtc": str(datetime.datetime(year=2022, month=12, day=12, hour=12, minute=00)), "id": "test_id_123", "photo": photo_binary}, {"categoryId": "8063ce0b-3645-4fcb-8445-f9ea23243e15","title": "test_event2", "startTimeUtc": str(datetime.datetime(year=2022, month=12, day=12, hour=12, minute=00)), "id": "test_id_123", "photo": photo_binary}]
    , "pastEvents": [{"categoryId": "8063ce0b-3645-4fcb-8445-f9ea23243e16","title": "test_event3", "startTimeUtc": str(datetime.datetime(year=2022, month=12, day=12, hour=12, minute=00)), "id": "test_id_123", "photo": photo_binary}],
    "openActivities": [{"categoryId": "8063ce0b-3645-4fcb-8445-f9ea23243e15","title": "test_activity", "openingTimeCode": "open", "id": "test_id_123", "photo": photo_binary}],
    "closedActivities": [{"categoryId": "8063ce0b-3645-4fcb-8445-f9ea23243e15","title": "test_activity1", "openingTimeCode": "closedSoon", "id": "test_id_123", "photo": photo_binary}]}""";


  var json = jsonDecode(some);
  print(json);
}
