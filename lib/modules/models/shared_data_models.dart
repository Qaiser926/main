
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
  final String? postalCode;
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
    this.longitude,
    this.postalCode,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class Time {
  final String? startTimeUtc;
  final String? endTimeUtc;
  final OpeningTimeCode? openingTimeCode;
  final Map? openingTime;

  Time(
      {this.startTimeUtc,
      this.openingTimeCode,
      this.endTimeUtc,
      this.openingTime});

  factory Time.fromJson(Map<String, dynamic> json) => _$TimeFromJson(json);

  Map<String, dynamic> toJson() => _$TimeToJson(this);
}

@JsonSerializable()
class SearchEnhancement {
  final int? cognitiveLevel;
  final int? physicalLevel;
  final int? socialLevel;
  final int? singlePersonEligibility;
  final int? coupleEligibility;
  final int? friendGroupEligibility;
  final int? professionalEligibility;

  SearchEnhancement({
    this.cognitiveLevel,
    this.physicalLevel,
    this.socialLevel,
    this.singlePersonEligibility,
    this.coupleEligibility,
    this.friendGroupEligibility,
    this.professionalEligibility,
  });

  factory SearchEnhancement.fromJson(Map<String, dynamic> json) =>
      _$SearchEnhancementFromJson(json);

  Map<String, dynamic> toJson() => _$SearchEnhancementToJson(this);
}

// TODO might not be used --> delete
@JsonSerializable()
class Coordinates {
  final double latitude;
  final double longitude;

  Coordinates({required this.latitude, required this.longitude});

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);
}