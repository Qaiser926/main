// import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'favourite_single_event_or_activity/favourite_event_or_activity.dart';

// part 'favourite_events_and_activities.freezed.dart';
part 'favourite_events_and_activities.g.dart';

@JsonSerializable()
class FavouriteEventsAndActivities {
  Map<String, FavouriteEventOrActivity> futureEvents;
  Map<String, FavouriteEventOrActivity> pastEvents;
  Map<String, FavouriteEventOrActivity> openActivities;
  Map<String, FavouriteEventOrActivity> closedActivities;

  FavouriteEventsAndActivities({
    required final this.futureEvents,
    required final this.pastEvents,
    required final this.openActivities,
    required final this.closedActivities,
  });

  factory FavouriteEventsAndActivities.fromJson(Map<String, dynamic> json) =>
      _$FavouriteEventsAndActivitiesFromJson(json);
}
