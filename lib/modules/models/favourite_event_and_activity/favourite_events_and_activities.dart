// import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'favourite_single_event_or_activity/favourite_event_or_activity.dart';

// part 'favourite_events_and_activities.freezed.dart';
part 'favourite_events_and_activities.g.dart';

@JsonSerializable()
class FavouriteEventsAndActivities {
  List<FavouriteEventOrActivity> futureEvents;
  List<FavouriteEventOrActivity> pastEvents;
  List<FavouriteEventOrActivity> openActivities;
  List<FavouriteEventOrActivity> closedActivities;

  FavouriteEventsAndActivities({
    required final List<FavouriteEventOrActivity> this.futureEvents,
    required final List<FavouriteEventOrActivity> this.pastEvents,
    required final List<FavouriteEventOrActivity> this.openActivities,
    required final List<FavouriteEventOrActivity> this.closedActivities,
  });

  factory FavouriteEventsAndActivities.fromJson(Map<String, dynamic> json) =>
      _$FavouriteEventsAndActivitiesFromJson(json);
}
