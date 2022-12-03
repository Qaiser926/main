import 'package:flutter/cupertino.dart';

import '../../../modules/models/favourite_event_and_activity/favourite_single_event_or_activity/favourite_event_or_activity.dart';

enum FavouriteType {
  pastEvent,
  upcomingEvent,
  pastActivity,
  upcomingActivity,
}

abstract class AbstractFavouriteNotifier extends ChangeNotifier {
  final Map<String, FavouriteEventOrActivity> listenedFavourite;
  late final FavouriteType favouriteType;

  AbstractFavouriteNotifier(
      {required this.listenedFavourite, required this.favouriteType});

  Map<String, FavouriteEventOrActivity> get getListenedFavourite =>
      listenedFavourite;

  void removeKey({required final key}) {
    listenedFavourite.remove(key);
    notifyListeners();
  }
}

//TODO alle notifier in einem vereinen und alle vier listen drinne haben.
//TODO wenn was gelöscht, suche in welcher map die id vorhanden. lösche dann in dieser map und baue alle notifier neu
class FavouritePastEventNotifier extends AbstractFavouriteNotifier {
  FavouritePastEventNotifier(
      {required super.listenedFavourite, required super.favouriteType});
}

class FavouriteUpcomingEventNotifier extends AbstractFavouriteNotifier {
  FavouriteUpcomingEventNotifier(
      {required super.listenedFavourite, required super.favouriteType});
}

class FavouriteOpenActivityNotifier extends AbstractFavouriteNotifier {
  FavouriteOpenActivityNotifier(
      {required super.listenedFavourite, required super.favouriteType});
}

class FavouriteClosedActivityNotifier extends AbstractFavouriteNotifier {
  FavouriteClosedActivityNotifier(
      {required super.listenedFavourite, required super.favouriteType});
}
