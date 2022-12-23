import 'package:json_annotation/json_annotation.dart';

part 'get_map_result_ids.g.dart';

@JsonSerializable()
class MapResultIds {
  final List<Map<String, dynamic>?> activityResults;
  final List<Map<String, dynamic>?> eventResults;

  MapResultIds({
    required this.activityResults,
    required this.eventResults,
  });

  factory MapResultIds.fromJson(Map<String, dynamic> json) =>
      _$MapResultIdsFromJson(json);
}
