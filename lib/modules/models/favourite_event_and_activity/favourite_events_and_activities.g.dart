// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_events_and_activities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavouriteEventsAndActivities _$FavouriteEventsAndActivitiesFromJson(
        Map<String, dynamic> json) =>
    FavouriteEventsAndActivities(
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

Map<String, dynamic> _$FavouriteEventsAndActivitiesToJson(
        FavouriteEventsAndActivities instance) =>
    <String, dynamic>{
      'futureEvents': instance.futureEvents,
      'pastEvents': instance.pastEvents,
      'openActivities': instance.openActivities,
      'closedActivities': instance.closedActivities,
    };
