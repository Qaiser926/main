import 'package:flutter/material.dart';

class AddEANotifier extends ChangeNotifier {
  final List<bool> selectedFruits = <bool>[false, false];
  final List<bool> privateOrPublic = <bool>[true, false];

  // TODO: before sending, transform to UTC
  DateTime? startDateTime;
  DateTime? endDateTime;

  Map<String, List<List<double?>>> openingTimes = {
    "1": [],
    "2": [],
    "3": [],
    "4": [],
    "5": [],
    "6": [],
    "7": []
  };
  int activatedWeekDay = 1;

  List getOpeningTimesList() {
    return openingTimes[activatedWeekDay.toString()]!;
  }

  void deleteNullOpeningTimes() {
    for (var openingTimesList in openingTimes.values) {
      for (var i = openingTimesList.length - 1; i >= 0; i--) {
        if ((openingTimesList[i][0] == null) |
            (openingTimesList[i][1] == null)) {
          openingTimesList.removeAt(i);
        }
      }
    }
    ;
    notifyListeners();
  }

  void closedOnWeekDay() {
    openingTimes[activatedWeekDay.toString()] = [];
    notifyListeners();
  }

  void alwaysOpenOnWeekDay() {
    openingTimes[activatedWeekDay.toString()] = [
      [0, 0]
    ];
    notifyListeners();
  }

  bool isClosed() {
    if (openingTimes[activatedWeekDay.toString()]!.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool isAlwaysOpen() {
    if (openingTimes[activatedWeekDay.toString()]!.isEmpty) {
      return false;
    } else {
      if ((openingTimes[activatedWeekDay.toString()]![0]![0] == 0) &
          (openingTimes[activatedWeekDay.toString()]![0]![1] == 0)) {
        return true;
      } else {
        return false;
      }
    }
  }

  void resetEndDateTime() {
    endDateTime = null;
    notifyListeners();
  }

  void activeWeekday(int weekday) {
    activatedWeekDay = weekday;
    notifyListeners();
  }

  void addHours() {
    openingTimes[activatedWeekDay.toString()]!.add([null, null]);
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
