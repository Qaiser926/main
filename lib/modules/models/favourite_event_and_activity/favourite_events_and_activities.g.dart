// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_events_and_activities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavouriteEventsAndActivities _$FavouriteEventsAndActivitiesFromJson(
        Map<String, dynamic> json) =>
    FavouriteEventsAndActivities(
      futureEvents: (json['futureEvents'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k, SummaryEventOrActivity.fromJson(e as Map<String, dynamic>)),
      ),
      pastEvents: (json['pastEvents'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k, SummaryEventOrActivity.fromJson(e as Map<String, dynamic>)),
      ),
      openActivities: (json['openActivities'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k, SummaryEventOrActivity.fromJson(e as Map<String, dynamic>)),
      ),
      closedActivities: (json['closedActivities'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k, SummaryEventOrActivity.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$FavouriteEventsAndActivitiesToJson(
        FavouriteEventsAndActivities instance) =>
    <String, dynamic>{
      'futureEvents': instance.futureEvents,
      'pastEvents': instance.pastEvents,
      'openActivities': instance.openActivities,
      'closedActivities': instance.closedActivities,
    };
