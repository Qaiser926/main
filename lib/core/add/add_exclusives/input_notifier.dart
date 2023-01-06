import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:othia/core/add/add_exclusives/price_picker.dart';

class AddEANotifier extends ChangeNotifier {
  String? title;

  String? description;
  String? websiteUrl;
  String? ticketUrl;

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

  // is needed to indicate if the snackbar giving info about the adding process on the first page was already shown (did not work with stateful widget alone)
  bool snackBarShown = false;

  String? image;

  // Level parameters
  int physicalLevel = 0;
  bool physicalLevelActivated = false;
  int cognitiveLevel = 0;
  bool cognitiveLevelActivated = false;
  int socialLevel = 0;
  bool socialLevelActivated = false;
  int singlePersonEligibilityLevel = 0;
  bool singlePersonEligibilityLevelActivated = false;
  int coupleEligibilityLevel = 0;
  bool coupleEligibilityLevelActivated = false;
  int friendGroupEligibilityLevel = 0;
  bool friendGroupEligibilityLevelActivated = false;
  int professionalEligibilityLevel = 0;
  bool professionalEligibilityLevelActivated = false;

  bool showCopyrightErrorMessage = false;
  bool copyRightVerified = false;

  bool termsAgreed = false;
  bool termsAgreedErrorMessage = false;

  void clearPrices() {
    for (var i = 0; i < prices.length; i++) {
      if (prices[i].price == null) {
        prices.removeAt(i);
      }
    }
    if (prices.isEmpty) {
      prices.add(InputPrice());
    }
    notifyListeners();
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

  set locationType(index) {
    changeSwitch(index: index, changingList: locationType);
  }

  void changePrivatePublic(index, BuildContext context) {
    changeSwitch(index: index, changingList: privateOrPublic);
  }

  void changeLocationType(int index, BuildContext context) {
    // there can be either an address associated or the event/ activity is online -> make user aware
    bool isAddressSet = (streetNumber != null) |
        (street != null) |
        (city != null) |
        (postalCode != null);

    bool addressCase = isAddressSet & (index == 1);
    if (addressCase) {
      notifyUsers(
          context: context,
          showFirstMessage: addressCase,
          firstText:
              "Switching will cause that the address will not be shown to users as your event or activity will be considered online",
          secondText: "",
          onPressed: () {
            locationType = index;
            Navigator.of(context, rootNavigator: true).pop();
          });
    } else {
      locationType = index;
    }
  }

  String getAddressString() {
    return "${locationTitle ?? ""}, ${street ?? ""} ${streetNumber ?? ""}, ${postalCode ?? ""} ${city ?? ""}";
  }

  List<InputPrice> prices = [InputPrice()];

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
        // first is opening time, the second closing time
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
    // there can be either opening times or start/ end time associated -> make user aware
    bool isOpeningTimesModified = false;
    for (var openingTimesList in openingTimes.values) {
      if (openingTimesList.isNotEmpty) isOpeningTimesModified = true;
    }
    bool isStartTimeModified = startDateTime != null;
    bool caseOpeningTimesReset = isOpeningTimesModified & (index == 0);
    bool caseStartTimeReset = isStartTimeModified & (index == 1);
    if (caseOpeningTimesReset | caseStartTimeReset) {
      notifyUsers(
          context: context,
          showFirstMessage: caseStartTimeReset,
          firstText:
              "Switching will cause that opening times instead of start times are considered",
          secondText:
              "Switching will cause that a start time is considered and the opening times are neglected",
          onPressed: () {
            times = index;
            // Get.back();
            Navigator.of(context, rootNavigator: true).pop();
          });
    } else {
      times = index;
    }
  }

  set privateOrPublic(index) {
    for (int i = 0; i < privateOrPublic.length; i++) {
      privateOrPublic[i] = i == index;
    }
    notifyListeners();
  }

  void notifyUsers(
      {required BuildContext context,
      required bool showFirstMessage,
      required String firstText,
      required String secondText,
      required Function() onPressed}) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              content: showFirstMessage ? Text(firstText) : Text(secondText),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    child: const Text("Cancel"),
                  ),
                ),
                TextButton(
                  onPressed: onPressed,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    child: const Text("Continue"),
                  ),
                ),
              ],
            ));
  }
}
