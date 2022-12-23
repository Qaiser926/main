// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_map_result_ids.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapResultIds _$MapResultIdsFromJson(Map<String, dynamic> json) => MapResultIds(
      activityResults: (json['activityResults'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, e as List<dynamic>),
      ),
      eventResults: (json['eventResults'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, e as List<dynamic>),
      ),
    );

Map<String, dynamic> _$MapResultIdsToJson(MapResultIds instance) =>
    <String, dynamic>{
      'activityResults': instance.activityResults,
      'eventResults': instance.eventResults,
    };
