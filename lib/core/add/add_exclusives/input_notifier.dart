import 'package:flutter/material.dart';

class AddEANotifier extends ChangeNotifier {
  final List<bool> selectedFruits = <bool>[false, false];
  final List<bool> privateOrPublic = <bool>[true, false];

  // TODO: before sending, transform to UTC
  DateTime? startDateTime;
  DateTime? endDateTime;

  Map<int, List?> openingTimes = {
    1: null,
    2: null,
    3: null,
    4: null,
    5: null,
    6: null,
    7: null
  };
  int activatedWeekDay = 1;

  void resetEndDateTime() {
    endDateTime = null;
    notifyListeners();
  }

  void activeWeekday(int weekday) {
    activatedWeekDay = weekday;
    notifyListeners();
  }

  List<Image> loadedImages = [];

  set selectedFruits(index) {
    for (int i = 0; i < selectedFruits.length; i++) {
      selectedFruits[i] = i == index;
    }
    notifyListeners();
  }

  set privateOrPublic(index) {
    for (int i = 0; i < privateOrPublic.length; i++) {
      privateOrPublic[i] = i == index;
    }
    notifyListeners();
  }

  set addImage(Image image) {
    loadedImages.add(image);
    notifyListeners();
  }
}
