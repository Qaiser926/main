import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shared_data_models.g.dart';

enum OpeningTimeCode {
  open,
  closed,
  openSoon,
  closedSoon,
  unknown,
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

enum Gender { male, female, diverse }

String? genderToString(Gender? gender, BuildContext context) {
  Map<Gender?, String?> mapGenderToString = {
    Gender.male: AppLocalizations.of(context)!.male,
    Gender.female: AppLocalizations.of(context)!.female,
    Gender.diverse: AppLocalizations.of(context)!.diverse,
    null: null,
  };
  return mapGenderToString[gender];
}

Gender? stringToGender(String? genderInput, BuildContext context) {
  Map<String?, Gender?> mapStringToGender = {
    AppLocalizations.of(context)!.male: Gender.male,
    AppLocalizations.of(context)!.female: Gender.female,
    AppLocalizations.of(context)!.diverse: Gender.diverse,
  };
  return mapStringToGender[genderInput];
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
  late String? endTimeUtc;
  OpeningTimeCode? openingTimeCode;
  Map<String, List<List<double?>?>?>? openingTime;

  Time(
      {this.startTimeUtc,
      this.openingTimeCode,
      String? endTimeUtc,
      this.openingTime}) {
    if (endTimeUtc == "None") {
      this.endTimeUtc = null;
    } else {
      this.endTimeUtc = endTimeUtc;
    }
  }

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
