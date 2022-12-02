import 'package:flutter/cupertino.dart';

class ListNotifier extends ChangeNotifier {
List<dynamic> _listenedList = [];
ListNotifier({required listenedList}){
  this._listenedList = listenedList;
}

List get updatedList => _listenedList;

set updatedList(List newList) {
  _listenedList = newList;
  notifyListeners();
}
}