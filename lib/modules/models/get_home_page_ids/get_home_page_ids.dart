import 'package:json_annotation/json_annotation.dart';

part 'get_home_page_ids.g.dart';

@JsonSerializable()
class HomePageIds {
  final List<String?> compingUpEvents;
  final List<String?> popularEvents;
  final List<String?> popularActivities;
  final List<String?> openActivities;
  final List<String?> universityEvents;

  HomePageIds({
    required this.compingUpEvents,
    required this.popularEvents,
    required this.popularActivities,
    required this.openActivities,
    required this.universityEvents,
  });

  factory HomePageIds.fromJson(Map<String, dynamic> json) =>
      _$HomePageIdsFromJson(json);
}
