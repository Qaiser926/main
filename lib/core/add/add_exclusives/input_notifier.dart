import 'package:flutter/material.dart';
import 'package:othia/core/add/add_exclusives/add_page_notifier.dart';

class AddEANotifier extends ChangeNotifier {
  String? title;

  String? mainCategoryId;

  // TODO before sending, transform to UUID
  String? categoryId;

  GlobalKey<FormState> titleKey = GlobalKey<FormState>();
  GlobalKey<FormState> basicInformation = GlobalKey<FormState>();

  bool goToNextPage(AddPageNotifier switchPagesNotifier) {
    if (switchPagesNotifier.currentPage == 0) {
      if (basicInformation.currentState!.validate()) {
        return true;
      } else {
        return false;
      }
    }
    return true;
  }

  final List<bool> times = <bool>[false, false];
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
      if ((openingTimes[activatedWeekDay.toString()]![0][0] == 0) &
      (openingTimes[activatedWeekDay.toString()]![0][1] == 0)) {
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

  set times(index) {
    for (int i = 0; i < times.length; i++) {
      times[i] = i == index;
    }
    notifyListeners();
  }

  void changeTimeType(int index, BuildContext context) {
    // there can be either opening times or start/ end time associated -> make user aware
    bool isOpeningTimesModified = false;
    for (var openingTimesList in openingTimes.values) {
      if (openingTimesList.isNotEmpty) isOpeningTimesModified = true;
    }
    bool isStartTimeModified = startDateTime != null;
    bool caseOpeningTimesReset = isOpeningTimesModified & (index == 0);
    bool caseStartTimeReset = isStartTimeModified & (index == 1);
    if (caseOpeningTimesReset | caseStartTimeReset) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            content: caseStartTimeReset
                ? Text(
                "Switching will cause your stated Start Time to be lost")
                : Text(
                "Switching will cause you stated Opening Times to be lost"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  child: const Text("Cancel"),
                ),
              ),
              TextButton(
                onPressed: () {
                  times = index;
                  resetOtherType(index);
                  Navigator.of(ctx).pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  child: const Text("Continue"),
                ),
              ),
            ],
          ));
    } else {
      times = index;
    }
  }

  void resetOtherType(int index) {
    if (index == 0) {
      openingTimes.forEach((k, v) => openingTimes[k] = []);
    } else {
      startDateTime = endDateTime = null;
    }
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
