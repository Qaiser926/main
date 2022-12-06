import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import '../shared_data_models.dart';
part 'eA_summary.g.dart';

@JsonSerializable()
class SummaryEventorActivity {
  final String title;
  final String id;
  final String categoryId;
  final String? photo;
  final List<double>? prices;
  final bool isOnline;
  final Time time;
  final Location location;

  SummaryEventorActivity({
    required this.time,
    required this.location,
    required this.title,
    required this.id,
    required this.categoryId,
    this.prices,
    this.photo,
    required this.isOnline,
  });

  factory SummaryEventorActivity.fromJson(Map<String, dynamic> json) =>
      _$SummaryEventorActivityFromJson(json);
}
