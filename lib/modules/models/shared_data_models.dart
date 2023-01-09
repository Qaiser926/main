
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

@JsonSerializable()
class Price {
  String? label;
  double? price;

  Price({
    this.label,
    this.price,
  });

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);

  Map<String, dynamic> toJson() => _$PriceToJson(this);
}

@JsonSerializable()
class Location {
  bool? isOnline;
  String? streetNumber;
  String? street;
  String? city;
  String? locationTitle;
  String? locationId;
  String? postalCode;
  double? longitude;
  double? latitude;

  Location({
    this.isOnline,
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
  String? startTimeUtc;
  String? endTimeUtc;
  OpeningTimeCode? openingTimeCode;
  Map<String, List<List<double?>?>?>? openingTime;

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
  int? cognitiveLevel;
  int? physicalLevel;
  int? socialLevel;
  int? singlePersonEligibility;
  int? coupleEligibility;
  int? friendGroupEligibility;
  int? professionalEligibility;

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