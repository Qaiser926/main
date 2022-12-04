import 'package:flutter/cupertino.dart';

import '../../../modules/models/favourite_event_and_activity/favourite_single_event_or_activity/favourite_event_or_activity.dart';

class FavouriteNotifier extends ChangeNotifier {
  final Map<String, FavouriteEventOrActivity> upcomingEvents;
  final Map<String, FavouriteEventOrActivity> pastEvents;
  final Map<String, FavouriteEventOrActivity> closedActivities;
  final Map<String, FavouriteEventOrActivity> openActivities;

  FavouriteNotifier(
      {required this.pastEvents,
      required this.closedActivities,
      required this.openActivities,
      required this.upcomingEvents});

  Map<String, FavouriteEventOrActivity> get getUpcomingEvents => upcomingEvents;

  Map<String, FavouriteEventOrActivity> get getPastEvents => pastEvents;

  Map<String, FavouriteEventOrActivity> get getClosedActivities =>
      closedActivities;

  Map<String, FavouriteEventOrActivity> get getOpenActivities => openActivities;

  void removeKey({required final key}) {
    if (upcomingEvents.containsKey(key)) {
      upcomingEvents.remove(key);
    } else if (pastEvents.containsKey(key)) {
      pastEvents.remove(key);
    } else if (closedActivities.containsKey(key)) {
      closedActivities.remove(key);
    } else if (openActivities.containsKey(key)) {
      openActivities.remove(key);
    }
    notifyListeners();
  }
}
