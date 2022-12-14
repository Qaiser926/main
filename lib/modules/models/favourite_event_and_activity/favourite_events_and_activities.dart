import 'package:json_annotation/json_annotation.dart';

import '../eA_summary/eA_summary.dart';

part 'favourite_events_and_activities.g.dart';

@JsonSerializable()
class FavouriteEventsAndActivities {
  Map<String, SummaryEventOrActivity> futureEvents;
  Map<String, SummaryEventOrActivity> pastEvents;
  Map<String, SummaryEventOrActivity> openActivities;
  Map<String, SummaryEventOrActivity> closedActivities;

  FavouriteEventsAndActivities({
    required final this.futureEvents,
    required final this.pastEvents,
    required final this.openActivities,
    required final this.closedActivities,
  });

  bool allEmpty() {
    if (futureEvents.isEmpty &&
        pastEvents.isEmpty &&
        openActivities.isEmpty &&
        closedActivities.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  factory FavouriteEventsAndActivities.fromJson(Map<String, dynamic> json) =>
      _$FavouriteEventsAndActivitiesFromJson(json);
}
