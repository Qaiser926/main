import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../shared_data_models.dart';

part 'detailed_event.g.dart';

@JsonSerializable()
class DetailedEventOrActivity {
  final String title;
  final String id;
  final String categoryId;
  final String ownerId;
  final List<String>? photos;
  final String? description;
  final String? eventSeriesId;
  final List<double>? prices;
  final String? ticketUrl;
  final String? websiteUrl;
  final Status? status;
  final bool isOnline;
  final Time time;
  final Location location;
  final Attribution? attribution;
  final SearchEnhancement? searchEnhancement;
  final bool ownerIsOrganizer;

  DetailedEventOrActivity(
      {required this.time,
      required this.location,
      required this.title,
      required this.id,
      required this.ownerIsOrganizer,
      required this.categoryId,
      required this.ownerId,
      this.searchEnhancement,
      this.eventSeriesId,
      this.photos,
      this.description,
      this.prices,
      this.ticketUrl,
      this.websiteUrl, // either ticket_url or website_url
      this.status,
      required this.isOnline,
      this.attribution});

  factory DetailedEventOrActivity.fromJson(Map<String, dynamic> json) =>
      _$DetailedEventOrActivityFromJson(json);
}
