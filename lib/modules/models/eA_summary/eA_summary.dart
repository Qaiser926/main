import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../shared_data_models.dart';

part 'eA_summary.g.dart';

@JsonSerializable()
class SummaryEventOrActivity {
  final String title;
  final String id;
  final String categoryId;
  final String? photo;
  final List<Price>? prices;
  final bool isOnline;
  final Time time;
  final Location location;

  SummaryEventOrActivity({
    required this.time,
    required this.location,
    required this.title,
    required this.id,
    required this.categoryId,
    this.prices,
    this.photo,
    required this.isOnline,
  });

  factory SummaryEventOrActivity.fromJson(Map<String, dynamic> json) =>
      _$SummaryEventOrActivityFromJson(json);

  Map<String, dynamic> toJson() => _$SummaryEventOrActivityToJson(this);
}
