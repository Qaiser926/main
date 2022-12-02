import 'package:flutter/cupertino.dart';

import '../../../modules/models/favourite_event_and_activity/favourite_single_event_or_activity/favourite_event_or_activity.dart';

class ListNotifier extends ChangeNotifier {
  List<FavouriteEventOrActivity> _listenedList = [];
ListNotifier({required listenedList}){
  this._listenedList = listenedList;
}

  List<FavouriteEventOrActivity> get updatedList => _listenedList;

set updatedList(List<FavouriteEventOrActivity> newList) {
  _listenedList = newList;
  notifyListeners();
}
}