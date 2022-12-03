import 'package:flutter/cupertino.dart';

import '../../../modules/models/favourite_event_and_activity/favourite_single_event_or_activity/favourite_event_or_activity.dart';

class ListNotifier extends ChangeNotifier {
  List<FavouriteEventOrActivity> _listenedList = [];

  ListNotifier({listenedList}) {}

  List<FavouriteEventOrActivity> get updatedList => _listenedList;


  set updatedList(List<FavouriteEventOrActivity> newList) {
    if (_listenedList.isEmpty) {
      _listenedList = newList;
    }
  }

  void removeAt(index) {
    _listenedList.removeAt(index);
    notifyListeners();
  }


}
