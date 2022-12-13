
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shared_data_models.g.dart';

enum OpeningTimeCode {
  open,
  closed,
  openSoon,
  closedSoon,
}

enum Status {
  PUBLIC,
  PRIVATE,
  DELETED,
  DRAFT,
  LIVE,
  STARTED,
  ENDED,
  COMPLETED,
  CANCELED,
  SOLDOUT,
}

enum Attribution {
  google,
}

@JsonSerializable()
class Location {
  final bool isOnline;
  final String? streetNumber;
  final String? street;
  final String? city;
  final String? locationTitle;
  final String? locationId;
  final double? longitude;
  final double? latitude;
  Location({
    required this.isOnline,
    this.locationId,
    this.streetNumber,
    this.street,
    this.city,
    this.locationTitle,
    this.latitude,
    this.longitude
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

@JsonSerializable()
class Time {
  final String? startTimeUtc;
  final String? endTimeUtc;
  final OpeningTimeCode? openingTimeCode;
  final Map? openingTime;

  Time({
    this.startTimeUtc,
    this.openingTimeCode,
    this.endTimeUtc,
    this.openingTime
  });

  factory Time.fromJson(Map<String, dynamic> json) =>
      _$TimeFromJson(json);
}
