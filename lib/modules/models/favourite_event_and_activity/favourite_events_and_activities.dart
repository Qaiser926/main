
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'favourite_single_event_or_activity/favourite_event_or_activity.dart';
part 'favourite_events_and_activities.freezed.dart';
part 'favourite_events_and_activities.g.dart';

@freezed
class FavouriteEventsAndActivities with _$FavouriteEventsAndActivities {
  @JsonSerializable(explicitToJson: true)
  const factory FavouriteEventsAndActivities({
    required final List<FavouriteEventOrActivity> futureEvents,
    required final List<FavouriteEventOrActivity> pastEvents,
    required final List<FavouriteEventOrActivity> openActivities,
    required final List<FavouriteEventOrActivity> closedActivities,


  }) = _FavouriteEventsAndActivities;

  factory FavouriteEventsAndActivities.fromJson(Map<String, dynamic> json)
  => _$FavouriteEventsAndActivitiesFromJson(json);
}
