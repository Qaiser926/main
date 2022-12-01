import 'package:instant/instant.dart';

main() {
  final utcInLocal = DateTime.parse('2022-09-12 08:11:00');

  final startTimeUtc = DateTime.utc(utcInLocal.year, utcInLocal.month,
      utcInLocal.day, utcInLocal.hour, utcInLocal.minute);
  final startTimeLocal = startTimeUtc.subtract(-DateTime.now().timeZoneOffset);
  print(
      "${startTimeLocal.day.toString().padLeft(2, '0')}.${startTimeLocal.month.toString().padLeft(2, '0')}.${startTimeLocal.year}, ${startTimeLocal.hour.toString().padLeft(2, '0')}:${startTimeLocal.minute.toString().padLeft(2, '0')}");
  print(startTimeLocal.weekday);
}
