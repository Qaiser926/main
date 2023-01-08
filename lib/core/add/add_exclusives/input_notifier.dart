import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:othia/constants/categories.dart';
import 'package:othia/modules/models/shared_data_models.dart';
import 'package:othia/utils/services/global_navigation_notifier.dart';
import 'package:provider/provider.dart';

import '../../../modules/models/detailed_event/detailed_event.dart';

class AddEANotifier extends ChangeNotifier {
  DetailedEventOrActivity detailedEA = DetailedEventOrActivity(
      time: Time(),
      location: Location(),
      searchEnhancement: SearchEnhancement());

  // TODO write function to input detailed event or activity

  void modify({required DetailedEventOrActivity existingDetailedEA}) {
    detailedEA = existingDetailedEA;
    handleTimes(existingDetailedEA.time);
    handleLocation(existingDetailedEA.location);
    handleOwnerId(detailedEA);
    mainCategoryId =
        mapSubcategoryToCategory(subCategoryId: existingDetailedEA.categoryId!);
    if (existingDetailedEA.status != null) {
      status = existingDetailedEA.status;
    } else {
      status = Status.LIVE;
    }
  }

  void handleTimes(Time existingTime) {
    if (existingTime.openingHours != null) {
      // set the list with bools
      times = 1;
    } else {
      times = 0;
    }
  }

  String? initStreet;
  String? initCity;
  String? initStreetNumber;
  String? initPostalCode;
  double? initLatitude;
  double? initLongitude;

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

  void handleOwnerId(DetailedEventOrActivity detailedEventOrActivity) {
    if (detailedEventOrActivity.ownerIsOrganizer!) {
      ownedOrForeign = 0;
    } else {
      ownedOrForeign = 1;
    }
  }

  // TODO write function to export detailed event or activity, special case for location

  bool isModifyMode = false;

  String? description;
  String? websiteUrl;
  String? ticketUrl;

  String? mainCategoryId;

  bool isAddressInvalid = false;

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
  int singlePersonEligibility = 0;
  bool singlePersonEligibilityActivated = false;
  int coupleEligibility = 0;
  bool coupleEligibilityActivated = false;
  int friendGroupEligibility = 0;
  bool friendGroupEligibilityActivated = false;
  int professionalEligibility = 0;
  bool professionalEligibilityActivated = false;

  bool showCopyrightErrorMessage = false;
  bool copyRightVerified = false;

  bool termsAgreed = false;
  bool termsAgreedErrorMessage = false;

  Status? status;

  List<Image> loadedImages = [];

  int activatedWeekDay = 1;

  // TODO when extracting interpret first  bool as start/ end time and second as opening times
  final List<bool> times = <bool>[true, false];

  // TODO when extracting interpret first  bool as real location and second as online
  final List<bool> locationType = <bool>[true, false];
  final List<bool> privateOrPublic = <bool>[true, false];
  final List<bool> ownedOrForeign = <bool>[true, false];

  void initializeWithExistingEA(
      {required DetailedEventOrActivity detailedEventOrActivity}) {
    handleSeveral(detailedEventOrActivity);
    handleImage(detailedEventOrActivity);
    // handlePrices(detailedEventOrActivity.prices);
    handleTimes(detailedEventOrActivity.time);
    handleLocation(detailedEventOrActivity.location);
    handleSearchenhancement(detailedEventOrActivity.searchEnhancement);
    handleOwnerId(detailedEventOrActivity);
  }

  void handleSeveral(DetailedEventOrActivity detailedEventOrActivity) {
    description = detailedEventOrActivity.description;
    websiteUrl = detailedEventOrActivity.websiteUrl;
    ticketUrl = detailedEventOrActivity.ticketUrl;
  }

  void handleSearchenhancement(SearchEnhancement? searchEnhancement) {
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

  void handleImage(DetailedEventOrActivity detailedEventOrActivity) {
    if (detailedEventOrActivity.photos != null) {
      image = detailedEventOrActivity.photos![0];
      copyRightVerified = true;
    }
  }

  // void handlePrices(List<double>? existingPrices) {
  //   if (existingPrices != null) {
  //     prices = [];
  //     for (int i = 0; i < existingPrices.length; i++) {
  //       prices.add(Price(price: existingPrices[i]));
  //     }
  //     if (prices.isEmpty) prices.add(Price());
  //   }
  // }

  set changeStatus(receivedStatus) {
    status = receivedStatus;
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
    changeSwitch(index: index, changingList: privateOrPublic);
  }

  void changeOwnedOrForeign(index, BuildContext context) {
    changeSwitch(index: index, changingList: ownedOrForeign);
  }

  set times(index) {
    changeSwitch(index: index, changingList: times);
  }

  set ownedOrForeign(index) {
    changeSwitch(index: index, changingList: ownedOrForeign);
  }

  void clearPrices() {
    for (var i = 0; i < prices.length; i++) {
      if (prices[i].price == null) {
        prices.removeAt(i);
      }
    }
    if (prices.isEmpty) {
      prices.add(Price());
    }
    notifyListeners();
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

  List<Price> prices = [Price()];

  List getOpeningTimesList() {
    return detailedEA.time.openingHours![activatedWeekDay.toString()]!;
  }

  void deleteNullOpeningTimes() {
    for (var openingTimesList in detailedEA.time.openingHours!.values) {
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
    detailedEA.time.openingHours![activatedWeekDay.toString()] = [];
    notifyListeners();
  }

  void alwaysOpenOnWeekDay() {
    detailedEA.time.openingHours![activatedWeekDay.toString()] = [
      [0, 0]
    ];
    notifyListeners();
  }

  bool isClosed() {
    if (detailedEA.time.openingHours![activatedWeekDay.toString()]!.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool isAlwaysOpen() {
    if (detailedEA.time.openingHours![activatedWeekDay.toString()]!.isEmpty) {
      return false;
    } else {
      if ((detailedEA.time.openingHours![activatedWeekDay.toString()]![0][0] ==
              0) &
          (detailedEA.time.openingHours![activatedWeekDay.toString()]![0][1] ==
              0)) {
        return true;
      } else {
        return false;
      }
    }
  }

  void resetEndDateTime() {
    detailedEA.time.endTimeUtc = null;
    // notifyListeners();
  }

  void activeWeekday(int weekday) {
    activatedWeekDay = weekday;
    notifyListeners();
  }

  void addHours() {
    detailedEA.time.openingHours![activatedWeekDay.toString()]!
        .add([null, null]);
    notifyListeners();
  }

  void changeTimeType(int index, BuildContext context) {
    // there can be either opening times or start/ end time associated -> make user aware
    bool isOpeningTimesModified = false;
    for (var openingTimesList in detailedEA.time.openingHours!.values) {
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
}
