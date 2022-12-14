import 'package:flutter/cupertino.dart';

import '../../../modules/models/eA_summary/eA_summary.dart';

class FavouriteNotifier extends ChangeNotifier {
  final Map<String, SummaryEventOrActivity> upcomingEvents;
  final Map<String, SummaryEventOrActivity> pastEvents;
  final Map<String, SummaryEventOrActivity> closedActivities;
  final Map<String, SummaryEventOrActivity> openActivities;

  FavouriteNotifier(
      {required this.pastEvents,
      required this.closedActivities,
      required this.openActivities,
      required this.upcomingEvents});

  Map<String, SummaryEventOrActivity> get getUpcomingEvents => upcomingEvents;

  Map<String, SummaryEventOrActivity> get getPastEvents => pastEvents;

  Map<String, SummaryEventOrActivity> get getClosedActivities =>
      closedActivities;

  Map<String, SummaryEventOrActivity> get getOpenActivities => openActivities;

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
