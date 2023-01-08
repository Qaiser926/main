import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../shared_data_models.dart';

part 'detailed_event.g.dart';

@JsonSerializable()
class DetailedEventOrActivity {
  String? title;
  String? id;
  String? categoryId;
  String? ownerId;
  List<String>? photos;
  String? description;
  String? eventSeriesId;
  List<Price>? prices;
  String? ticketUrl;
  String? websiteUrl;
  Status? status;
  bool? isOnline;
  Time time;
  Location location;
  Attribution? attribution;
  SearchEnhancement? searchEnhancement;
  bool? isPublic;
  bool? showOrganizer;

  DetailedEventOrActivity(
      {required this.time,
      required this.location,
      this.showOrganizer,
      this.title,
      this.id,
      this.isPublic,
      this.categoryId,
      this.ownerId,
      this.searchEnhancement,
      this.eventSeriesId,
      this.photos,
      this.description,
      this.prices,
      this.ticketUrl,
      this.websiteUrl, // either ticket_url or website_url
      this.status,
      this.isOnline,
      this.attribution});

  factory DetailedEventOrActivity.fromJson(Map<String, dynamic> json) =>
      _$DetailedEventOrActivityFromJson(json);

  Map<String, dynamic> toJson() => _$DetailedEventOrActivityToJson(this);
}
