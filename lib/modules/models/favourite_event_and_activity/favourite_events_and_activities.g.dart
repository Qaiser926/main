// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_events_and_activities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FavouriteEventsAndActivities _$$_FavouriteEventsAndActivitiesFromJson(
        Map<String, dynamic> json) =>
    _$_FavouriteEventsAndActivities(
      futureEvents: (json['futureEvents'] as List<dynamic>)
          .map((e) =>
              FavouriteEventOrActivity.fromJson(e as Map<String, dynamic>))
          .toList(),
      pastEvents: (json['pastEvents'] as List<dynamic>)
          .map((e) =>
              FavouriteEventOrActivity.fromJson(e as Map<String, dynamic>))
          .toList(),
      openActivities: (json['openActivities'] as List<dynamic>)
          .map((e) =>
              FavouriteEventOrActivity.fromJson(e as Map<String, dynamic>))
          .toList(),
      closedActivities: (json['closedActivities'] as List<dynamic>)
          .map((e) =>
              FavouriteEventOrActivity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_FavouriteEventsAndActivitiesToJson(
        _$_FavouriteEventsAndActivities instance) =>
    <String, dynamic>{
      'futureEvents': instance.futureEvents.map((e) => e.toJson()).toList(),
      'pastEvents': instance.pastEvents.map((e) => e.toJson()).toList(),
      'openActivities': instance.openActivities.map((e) => e.toJson()).toList(),
      'closedActivities':
          instance.closedActivities.map((e) => e.toJson()).toList(),
    };
