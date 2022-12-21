import 'package:json_annotation/json_annotation.dart';

part 'get_map_result_ids.g.dart';

@JsonSerializable()
class MapResultIds {
  Map<String, List> activityResults;
  Map<String, List> eventResults;

  MapResultIds({
    required final this.activityResults,
    required final this.eventResults,
  });

  factory MapResultIds.fromJson(Map<String, dynamic> json) =>
      _$MapResultIdsFromJson(json);
}
