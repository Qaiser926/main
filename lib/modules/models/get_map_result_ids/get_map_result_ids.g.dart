// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_map_result_ids.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapResultIds _$MapResultIdsFromJson(Map<String, dynamic> json) => MapResultIds(
      activityResults: (json['activityResults'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>?)
          .toList(),
      eventResults: (json['eventResults'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>?)
          .toList(),
    );

Map<String, dynamic> _$MapResultIdsToJson(MapResultIds instance) =>
    <String, dynamic>{
      'activityResults': instance.activityResults,
      'eventResults': instance.eventResults,
    };
