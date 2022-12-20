import 'package:json_annotation/json_annotation.dart';

part 'get_home_page_ids.g.dart';

@JsonSerializable()
class HomePageIds {
  final List<String?> compingUpEvents;
  final List<String?> popularEA;
  final List<String?> openActivities;
  final List<String?> universityEvents;

  HomePageIds({
    required this.compingUpEvents,
    required this.popularEA,
    required this.openActivities,
    required this.universityEvents,
  });

  factory HomePageIds.fromJson(Map<String, dynamic> json) =>
      _$HomePageIdsFromJson(json);
}
