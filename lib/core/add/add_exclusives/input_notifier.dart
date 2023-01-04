import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:othia/core/add/add_exclusives/add_page_notifier.dart';

class AddEANotifier extends ChangeNotifier {
  String? title;

  String? mainCategoryId;
  String? categoryId;

  String? locationTitle;
  String? street;
  String? streetNumber;
  String? city;
  String? postalCode;
  latLng.LatLng? latLong;

  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> timeFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> basicInformationFormKey = GlobalKey<FormState>();

  bool snackBarShown = false;

  bool goToNextPage(AddPageNotifier switchPagesNotifier, int targetPage) {
    // if (switchPagesNotifier.currentPage == 0) {
    //   if (basicInformationFormKey.currentState!.validate()) {
    //     return true;
    //   } else {
    //     return false;
    //   }
    // }
    if ((switchPagesNotifier.currentPage == 1) & (targetPage == 2)) {
      if (addressFormKey.currentState!.validate()) {
        return true;
      } else {
        return false;
      }
    }
    return true;
  }

  bool isAddressInvalid = false;

  List<Image> loadedImages = [];

  // TODO when extracting interpret first  bool as start/ end time and second as opening times
  final List<bool> times = <bool>[true, false];

  // TODO when extracting interpret first  bool as real location and second as online
  final List<bool> locationType = <bool>[true, false];
  final List<bool> privateOrPublic = <bool>[true, false];

  void changeSwitch({required int index, required List<bool> changingList}) {
    for (int i = 0; i < changingList.length; i++) {
      changingList[i] = i == index;
    }
    notifyListeners();
  }

// TODO
  void changeLocationType(index, BuildContext context) {
    changeSwitch(index: index, changingList: locationType);
  }

  String getAddressString() {
    return "${locationTitle ?? ""}, ${street ?? ""} ${streetNumber ?? ""}, ${postalCode ?? ""} ${city ?? ""}";
  }

  // set locationType(index) {
  //   changeSwitch(index: index, changingList: locationType);
  // }

  // TODO: before sending, transform to UTC
  DateTime? startDateTime;
  DateTime? endDateTime;

// time related

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

  set times(index) {
    changeSwitch(index: index, changingList: times);
  }

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
    // notifyListeners();
  }

  void activeWeekday(int weekday) {
    activatedWeekDay = weekday;
    notifyListeners();
  }

  void addHours() {
    openingTimes[activatedWeekDay.toString()]!.add([null, null]);
    notifyListeners();
  }

  void changeTimeType(int index, BuildContext context) {
      times = index;
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
