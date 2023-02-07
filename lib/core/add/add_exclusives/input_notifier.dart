import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:othia/constants/categories.dart';
import 'package:othia/modules/models/shared_data_models.dart';
import 'package:othia/utils/services/global_navigation_notifier.dart';
import 'package:othia/utils/services/rest-api/amplify/amp.dart';
import 'package:provider/provider.dart';

import '../../../modules/models/detailed_event/detailed_event.dart';

class AddEANotifier extends ChangeNotifier {
  late DetailedEventOrActivity detailedEA;
  bool isModifyMode = false;
  bool isAddressInvalid = false;
  bool snackBarShown =
      false; // is needed to indicate if the snackbar giving info about the adding process on the first page was already shown (did not work with stateful widget alone) and is used in order not to call the API twice in the modifying case
  bool showCopyrightErrorMessage = false;
  bool copyRightVerified = false;
  bool termsAgreed = false;
  bool termsAgreedErrorMessage = false;

  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> timeFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> basicInformationFormKey = GlobalKey<FormState>();

  Status? status = Status.LIVE;
  int activatedWeekDay = 1;
  String? initStreet;
  String? initCity;
  String? initStreetNumber;
  String? initPostalCode;
  double? initLatitude;
  double? initLongitude;
  String? mainCategoryId;

  // Level parameters
  int physicalLevel = 0;
  bool physicalLevelActivated = false;
  int cognitiveLevel = 0;
  bool cognitiveLevelActivated = false;
  int socialLevel = 0;
  bool socialLevelActivated = false;
  int singlePersonEligibility = 0;
  bool singlePersonEligibilityActivated = false;
  int coupleEligibility = 0;
  bool coupleEligibilityActivated = false;
  int friendGroupEligibility = 0;
  bool friendGroupEligibilityActivated = false;
  int professionalEligibility = 0;
  bool professionalEligibilityActivated = false;

  final List<bool> times = <bool>[true, false];
  final List<bool> locationType = <bool>[true, false];
  final List<bool> publicOrPrivate = <bool>[true, false];
  final List<bool> associateProfile = <bool>[true, false];

  AddEANotifier() {
    detailedEA = DetailedEventOrActivity(
        time: Time(),
        location: Location(isOnline: false),
        searchEnhancement: SearchEnhancement(),
        isOnline: false);
    handlePrices();
    handleTimes(detailedEA.time);
    setOwnerId();
  }

  DetailedEventOrActivity extractToSave() {
    detailedEA.status = status;
    detailedEA.eventSeriesId = null;
    detailedEA.htmlAttributions = null;
    if (detailedEA.photos == null) {
      detailedEA.photos = [];
    }
    updateSearchEnhancement();
    cleanUpTimes();
    cleanUpLocation();
    cleanUpPrices();
    publicOrPrivate[0]
        ? detailedEA.isPublic = true
        : detailedEA.isPublic = false;
    associateProfile[0]
        ? detailedEA.showOrganizer = true
        : detailedEA.showOrganizer = false;
    return detailedEA;
  }

  void cleanUpTimes() {
    if (times[0]) {
      detailedEA.time.openingTime = null;
    } else {
      detailedEA.time.startTimeUtc = null;
      detailedEA.time.endTimeUtc = null;
    }
  }

  void cleanUpLocation() {
    if (locationType[0]) {
      detailedEA.isOnline = false;
      detailedEA.location.isOnline = false;
      if (isAddressChanged()) {
        detailedEA.location.locationTitle = null;
        detailedEA.location.locationId = null;
      }
    } else {
      detailedEA.isOnline = true;
      detailedEA.location.isOnline = true;
      detailedEA.location.locationTitle = null;
      detailedEA.location.locationId = null;
      detailedEA.location.streetNumber = null;
      detailedEA.location.street = null;
      detailedEA.location.city = null;
      detailedEA.location.postalCode = null;
    }
  }

  void cleanUpPrices() {
    if (detailedEA.prices != null) {
      for (var i = 0; i < detailedEA.prices!.length; i++) {
        if (detailedEA.prices![i].price == null) {
          detailedEA.prices!.removeAt(i);
        }
      }
    }
  }

  void updateSearchEnhancement() {
    detailedEA.searchEnhancement = SearchEnhancement(
        cognitiveLevel: cognitiveLevelActivated ? cognitiveLevel : null,
        coupleEligibility:
            coupleEligibilityActivated ? coupleEligibility : null,
        friendGroupEligibility:
            friendGroupEligibilityActivated ? friendGroupEligibility : null,
        physicalLevel: physicalLevelActivated ? physicalLevel : null,
        professionalEligibility:
            professionalEligibilityActivated ? professionalEligibility : null,
        singlePersonEligibility:
            singlePersonEligibilityActivated ? singlePersonEligibility : null,
        socialLevel: socialLevelActivated ? socialLevel : null);
  }

  // to initialize in modification case
  void modify({required DetailedEventOrActivity existingDetailedEA}) {
    detailedEA = existingDetailedEA;
    setOwnerId();
    handleTimes(existingDetailedEA.time);
    handleLocation(existingDetailedEA.location);
    handleIsPublic(detailedEA);
    handlePrices();
    mainCategoryId =
        mapSubcategoryToCategory(subCategoryId: existingDetailedEA.categoryId!);
    if (existingDetailedEA.status != null) {
      status = existingDetailedEA.status;
    } else {
      status = null;
    }
    if (existingDetailedEA.photos != null) {
      if (existingDetailedEA.photos!.isNotEmpty) {
        copyRightVerified = true;
      }
    }
    handleSearchEnhancement(existingDetailedEA.searchEnhancement);
  }

  Future<void> setOwnerId() async {
    detailedEA.ownerId = await getUserId();
  }

  void handlePrices() {
    if (detailedEA.prices == null) {
      detailedEA.prices = [Price()];
    } else if (detailedEA.prices!.isEmpty) {
      detailedEA.prices = [Price()];
    }
  }

  void handleTimes(Time existingTime) {
    if (existingTime.openingTime != null) {
      // set the list with bools
      times = 1;
    } else {
      times = 0;
      detailedEA.time.openingTime = {
        "1": [],
        "2": [],
        "3": [],
        "4": [],
        "5": [],
        "6": [],
        "7": [],
      };
    }
  }

  void handleLocation(Location existingLocation) {
    if (existingLocation.isOnline!) {
      locationType = 1;
    } else {
      locationType = 0;
      initStreet = existingLocation.street;
      initCity = existingLocation.city;
      initPostalCode = existingLocation.postalCode;
      initStreetNumber = existingLocation.streetNumber;
      initLatitude = existingLocation.latitude;
      initLongitude = existingLocation.longitude;
    }
  }

  void handleIsPublic(DetailedEventOrActivity detailedEventOrActivity) {
    if (detailedEventOrActivity.isPublic!) {
      associateProfile = 0;
    } else {
      associateProfile = 1;
    }
  }

  void handleSearchEnhancement(SearchEnhancement? searchEnhancement) {
    if (searchEnhancement != null) {
      if (searchEnhancement.cognitiveLevel != null) {
        cognitiveLevel = searchEnhancement.cognitiveLevel!;
        cognitiveLevelActivated = true;
      }
      if (searchEnhancement.socialLevel != null) {
        socialLevel = searchEnhancement.socialLevel!;
        socialLevelActivated = true;
      }
      if (searchEnhancement.physicalLevel != null) {
        physicalLevel = searchEnhancement.physicalLevel!;
        physicalLevelActivated = true;
      }
      if (searchEnhancement.singlePersonEligibility != null) {
        singlePersonEligibility = searchEnhancement.singlePersonEligibility!;
        singlePersonEligibilityActivated = true;
      }
      if (searchEnhancement.coupleEligibility != null) {
        coupleEligibility = searchEnhancement.coupleEligibility!;
        coupleEligibilityActivated = true;
      }
      if (searchEnhancement.friendGroupEligibility != null) {
        friendGroupEligibility = searchEnhancement.friendGroupEligibility!;
        friendGroupEligibilityActivated = true;
      }
      if (searchEnhancement.professionalEligibility != null) {
        professionalEligibility = searchEnhancement.professionalEligibility!;
        professionalEligibilityActivated = true;
      }
    }
  }

  bool isAddressChanged() {
    return ((initStreet != detailedEA.location.street) |
        (initCity != detailedEA.location.city) |
        (initStreetNumber != detailedEA.location.streetNumber) |
        (initPostalCode != detailedEA.location.postalCode) |
        (initLongitude != detailedEA.location.longitude) |
        (initLatitude != detailedEA.location.latitude));
  }

  bool shouldCallGeolocator() {
    // only do not call if the address has not changed in modification mode
    if (!isAddressChanged() & isModifyMode) {
      return false;
    }
    return true;
  }

  set changeStatus(receivedStatus) {
    status = receivedStatus;
    detailedEA.status = receivedStatus;
    notifyListeners();
  }

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
    changeSwitch(index: index, changingList: publicOrPrivate);
  }

  void changeOwnedOrForeign(index, BuildContext context) {
    changeSwitch(index: index, changingList: associateProfile);
  }

  set times(index) {
    changeSwitch(index: index, changingList: times);
  }

  set associateProfile(index) {
    changeSwitch(index: index, changingList: associateProfile);
  }

  void clearPrices() {
    if (detailedEA.prices != null) {
      cleanUpPrices();
      if (detailedEA.prices!.isEmpty) {
        detailedEA.prices!.add(Price());
      }
      notifyListeners();
    }
  }

  void changeLocationType(int index, BuildContext context) {
    // there can be either an address associated or the event/ activity is online -> make user aware
    bool isAddressSet = (detailedEA.location.streetNumber != null) |
        (detailedEA.location.street != null) |
        (detailedEA.location.city != null) |
        (detailedEA.location.postalCode != null);

    bool addressCase = isAddressSet & (index == 1);
    if (addressCase) {
      notifyUsers(
          context: context,
          showFirstMessage: addressCase,
          firstText: AppLocalizations.of(context)!.locationSwitchingDialog,
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
    return "${detailedEA.location.locationTitle ?? ""}, ${detailedEA.location.street ?? ""} ${detailedEA.location.streetNumber ?? ""}, ${detailedEA.location.postalCode ?? ""} ${detailedEA.location.city ?? ""}";
  }

  // opening times related

  List getOpeningTimesList() {
    return detailedEA.time.openingTime![activatedWeekDay.toString()]!;
  }

  void deleteNullOpeningTimes() {
    for (var openingTimesList in detailedEA.time.openingTime!.values) {
      if (openingTimesList != null) {
        for (var i = openingTimesList.length - 1; i >= 0; i--) {
          // first is opening time, the second closing time
          if ((openingTimesList[i]![0] == null) |
              (openingTimesList[i]![1] == null)) {
            openingTimesList.removeAt(i);
          }
        }
      }
      notifyListeners();
    }
  }

  void closedOnWeekDay() {
    detailedEA.time.openingTime![activatedWeekDay.toString()] = [];
    notifyListeners();
  }

  void alwaysOpenOnWeekDay() {
    detailedEA.time.openingTime![activatedWeekDay.toString()] = [
      [0, 0]
    ];
    notifyListeners();
  }

  bool isClosed() {
    if (detailedEA.time.openingTime![activatedWeekDay.toString()]?.isEmpty ??
        true) {
      return true;
    } else {
      return false;
    }
  }

  bool isAlwaysOpen() {
    if (detailedEA.time.openingTime![activatedWeekDay.toString()]?.isEmpty ??
        true) {
      return false;
    } else {
      if ((detailedEA.time.openingTime![activatedWeekDay.toString()]![0]![0] ==
              0) &
          (detailedEA.time.openingTime![activatedWeekDay.toString()]![0]![1] ==
              0)) {
        return true;
      } else {
        return false;
      }
    }
  }

  void activeWeekday(int weekday) {
    activatedWeekDay = weekday;
    notifyListeners();
  }

  void addHours() {
    detailedEA.time.openingTime![activatedWeekDay.toString()]!
        .add([null, null]);
    notifyListeners();
  }

  void changeTimeType(int index, BuildContext context) {
    // there can be either opening times or start/ end time associated -> make user aware
    bool isOpeningTimesModified = false;
    for (var openingTimesList in detailedEA.time.openingTime!.values) {
      if (openingTimesList?.isNotEmpty ?? (openingTimesList != null))
        isOpeningTimesModified = true;
    }
    bool isStartTimeModified = detailedEA.time.startTimeUtc != null;
    bool caseOpeningTimesReset = isOpeningTimesModified & (index == 0);
    bool caseStartTimeReset = isStartTimeModified & (index == 1);
    if (caseOpeningTimesReset | caseStartTimeReset) {
      notifyUsers(
          context: context,
          showFirstMessage: caseStartTimeReset,
          firstText:
              AppLocalizations.of(context)!.timeSwitchingDialogOpeningHours,
          secondText:
              AppLocalizations.of(context)!.timeSwitchingDialogStartTime,
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
    for (int i = 0; i < publicOrPrivate.length; i++) {
      publicOrPrivate[i] = i == index;
    }
    notifyListeners();
  }

  void resetEndDateTime() {
    detailedEA.time.endTimeUtc = null;
  }

  void notifyUsers(
      {required BuildContext context,
      required bool showFirstMessage,
      required String firstText,
      required String secondText,
      required Function() onPressed}) {
    Provider.of<GlobalNavigationNotifier>(context, listen: false).isDialogOpen =
        true;
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
                    child: Text(
                      AppLocalizations.of(context)!.cancel,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: onPressed,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    child: Text(AppLocalizations.of(context)!.continueText),
                  ),
                ),
              ],
            )).then((_) {
      Provider.of<GlobalNavigationNotifier>(context, listen: false)
          .isDialogOpen = false;
    });
  }

  bool isPhotoSet() {
    if (detailedEA.photos == null) {
      return false;
    } else {
      if (detailedEA.photos!.isEmpty) {
        return false;
      } else {
        return true;
      }
    }
  }
}
