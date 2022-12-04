import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import '../shared_data_models.dart';

part 'detailed_event.g.dart';

@JsonSerializable()
class DetailedEventOrActivity {
  final String title;
  final String id;
  final String categoryId;
  final double? longitude;
  final String ownerId;
  final List<String>? photos;
  final String? description;
  final String? eventSeriesId;
  final double? price;
  final String? moreInformationUrl;
  final String? startTimeUtc;
  final String? endTimeUtc;
  final Status? status;
  final OpeningTimeCode? openingTimeCode;
  final Map? openingTime;
  final double? latitude;
  final bool isOnline;
  final String? locationTitle;
  final String? locationId;

  final String? street;
  final String? streetNumber;
  final String? city;
  final String? locationName;

  DetailedEventOrActivity({
    required this.title,
    required this.id,
    required this.categoryId,
    required this.ownerId,
    this.eventSeriesId,
    this.photos,
    this.description,
    this.price,
    this.moreInformationUrl, // either ticket_url or website_url
    this.status,
    this.startTimeUtc,
    this.openingTimeCode,
    this.openingTime,
    required this.isOnline,
    this.locationTitle,
    this.locationId,
    this.latitude,
    this.longitude,
    this.street,
    this.streetNumber,
    this.city,
    this.locationName,
    this.endTimeUtc,
  });

  factory DetailedEventOrActivity.fromJson(Map<String, dynamic> json) =>
      _$DetailedEventOrActivityFromJson(json);
}
