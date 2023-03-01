import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:othia/core/add/add_exclusives/add_page_notifier.dart';
import 'package:othia/core/add/add_exclusives/basic_info_page.dart';
import 'package:othia/core/add/add_exclusives/details_page.dart';
import 'package:othia/core/add/add_exclusives/input_notifier.dart';
import 'package:othia/core/add/add_exclusives/publish_page.dart';
import 'package:othia/modules/models/detailed_event/detailed_event.dart';
import 'package:othia/utils/helpers/diverse.dart';
import 'package:othia/utils/services/geocoding.dart';
import 'package:othia/utils/services/global_navigation_notifier.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'forwarding_pages.dart';

Widget getFutureHandlerPageView(
  AddEANotifier inputNotifier,
  SwitchPages switchPages,
  PageController pageController,
  Map<String, dynamic> jsonResponse,
) {
  handleJsonData(
    jsonResponse: jsonResponse,
    inputNotifier: inputNotifier,
  );
  return PageView(
      onPageChanged: ((targetPage) {
        FocusManager.instance.primaryFocus?.unfocus(); // dismiss keyboard
        switchPages.switchPageBehaviour(targetPage);
      }),
      controller: pageController,
      children: [
        BasicInfoPage(inputNotifier),
        DetailsPage(inputNotifier),
        PublishPage(inputNotifier, pageController),
      ]);
}

void handleJsonData(
    {required Map<String, dynamic> jsonResponse,
    required AddEANotifier inputNotifier}) {
  if (jsonResponse.isNotEmpty) {
    DetailedEventOrActivity detailedEventOrActivity =
        DetailedEventOrActivity.fromJson(jsonResponse);
    inputNotifier.modify(existingDetailedEA: detailedEventOrActivity);
  }
}

Column getHeadline(
    {required BuildContext context,
    required Widget caption,
    bool showDivider = true}) {
  return Column(
    children: [
      showDivider
          ? Padding(
              padding: EdgeInsets.only(bottom: 15.h, top: 4.h),
              child: Divider(thickness: 2.h),
            )
          : SizedBox(),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [caption],
      ),
      getVerSpace(10.h)
    ],
  );
}

Future getInfoDialog(
    {Widget? heading, Widget? content, required BuildContext context}) {
  Provider.of<GlobalNavigationNotifier>(context, listen: false).isDialogOpen =
      true;
  dismissKeyboard();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: heading,
          content: content,
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.close),
            ),
          ],
        );
      }).then((_) {
    Provider.of<GlobalNavigationNotifier>(context, listen: false).isDialogOpen =
        false;
  });
}

Widget getHeadlineWithInfoDialog(
    {required BuildContext context,
    required String infoText,
    required String caption,
    bool showDivider = true}) {
  return getHeadline(
    showDivider: showDivider,
    context: context,
    caption: GestureDetector(
      onTap: () => {getInfoDialog(heading: Text(infoText), context: context)},
      child: Row(children: [
        Text(caption, style: Theme.of(context).textTheme.headlineLarge),
        Padding(
          padding: EdgeInsets.only(left: 5.h),
          child: Icon(Icons.info_outline, size: 14),
        )
      ]),
    ),
  );
}

Widget getSwitch(
    {required Function onPressed,
    required isSelected,
    required children,
    required BuildContext context}) {
  return ToggleButtons(
      direction: Axis.horizontal,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      constraints: const BoxConstraints(
        minHeight: 40.0,
        minWidth: 80.0,
      ),
      isSelected: isSelected,
      renderBorder: true,
      onPressed: (index) {
        dismissKeyboard();
        onPressed(index, context);
      },
      children: children);
}

// for page switching behaviour
class SwitchPages {
  static const animationDuration = Duration(milliseconds: 200);
  static const animationCurve = Curves.decelerate;
  AddEANotifier inputNotifier;
  SwitchAddPageNotifier switchPagesNotifier;
  PageController pageController;

  SwitchPages(
      {required this.inputNotifier,
      required this.switchPagesNotifier,
      required this.pageController});

  bool _isTimeCorrect() {
    return inputNotifier.timeFormKey.currentState!.validate() |
        inputNotifier.times[1];
  }

  bool _isTitleCategoryCorrect() {
    return inputNotifier.basicInformationFormKey.currentState!.validate();
  }

  void _switchPage(int value) {
    switchPagesNotifier.currentPage = value;
    pageController.jumpToPage(value);
  }

  void _notSwitchPageAddressInvalid() {
    inputNotifier.isAddressInvalid = true;
    inputNotifier.addressFormKey.currentState?.validate();
    inputNotifier.timeFormKey.currentState?.validate();
    inputNotifier.basicInformationFormKey.currentState?.validate();
    pageController.jumpToPage(switchPagesNotifier.currentPage);
    inputNotifier.isAddressInvalid = false;
  }

  void _notSwitchPageAddressValid() {
    inputNotifier.isAddressInvalid = false;
    inputNotifier.addressFormKey.currentState?.validate();
    pageController.jumpToPage(switchPagesNotifier.currentPage);
  }

  void switchPageBehaviour(int targetPage) {
    // the overall logic of this function is not trivial. The issue is that flutter forms do not accept async functions
    // which is needed to verify the address. Therefore, whether the address form is valid or not, is controlled via
    // the input Notifier variable "isAddressInvalid" which is set to true if no latitude and longitude were found for the
    // stated address. In order not to be async, the "then" statement is used. This causes the pages to change
    // even after the normal procedure has ended.
    // The normal procedure is, that upon page switch, the validity of the forms is checked and only if they
    // are valid, the pageNotifier (which controls the highlighted box in the appbar) is changed.
    // It is important to note, that this function is called when "onPageChanged" of the PageView is called
    // If no jumpToPage is called, then the page is just switched according to the target Page
    // If jumped to Page, the function calls itself again, yet with another target Page

    // to delete prices with null values on additional page
    if (targetPage == 1) {
      inputNotifier.clearPrices();
    }
    // case switching from basic info page to additional info page
    if ((switchPagesNotifier.currentPage == 0) &
        ((targetPage == 1) | (targetPage == 2))) {
      // request latitude and longitude for stated address and test if a result was found only if not online is selected
      if (inputNotifier.locationType[0] &
          (inputNotifier.shouldCallGeolocator())) {
        getLatLongFromAddress(inputNotifier.getAddressString()).then((latLong) {
          if (latLong != null) {
            inputNotifier.detailedEA.location.longitude = latLong.longitude;
            inputNotifier.detailedEA.location.latitude =
                latLong.latitude; // save requested lat/ long
            if (_isTimeCorrect() & _isTitleCategoryCorrect()) {
              _switchPage(targetPage);
            }
            _notSwitchPageAddressValid();
          } else {
            _notSwitchPageAddressInvalid();
          }
        });
      } else {
        if (_isTimeCorrect() & _isTitleCategoryCorrect()) {
          _switchPage(targetPage);
        }
      }
      // per default page is not switched, here another function could be written that opens a loading screen
      _notSwitchPageAddressValid();
    } else if ((switchPagesNotifier.currentPage == 1) &
        (targetPage == 2) &
        ((inputNotifier.isPhotoSet()) & !inputNotifier.copyRightVerified)) {
      inputNotifier.showCopyrightErrorMessage = true;
      pageController.jumpToPage(switchPagesNotifier.currentPage);
    } else {
      switchPagesNotifier.currentPage = targetPage;
    }
  }

  void nextPage(BuildContext context) {
    pageController.nextPage(duration: animationDuration, curve: animationCurve);
    switchPagesNotifier.currentPage = pageController.page!.toInt();
  }

  void previousPage(BuildContext context) {
    pageController.previousPage(
        duration: animationDuration, curve: animationCurve);
    switchPagesNotifier.currentPage = pageController.page!.toInt();
  }
}

void publishFunction(BuildContext context) {
  Provider.of<AddEANotifier>(context, listen: false).termsAgreed
      ? forwardFunction(context)
      : termsNotAgreed(context);
}

DetailedEventOrActivity setEAId(
    DetailedEventOrActivity detailedEventOrActivity) {
  if (detailedEventOrActivity.id == null) {
    detailedEventOrActivity.id = Uuid().v4();
  }
  return detailedEventOrActivity;
}

void forwardFunction(BuildContext context) {
  DetailedEventOrActivity detailedEA =
      Provider.of<AddEANotifier>(context, listen: false).extractToSave();
  detailedEA = setEAId(detailedEA);
  Get.to(SaveForwardingPage(detailedEA));
}

void termsNotAgreed(BuildContext context) {
  Provider.of<AddEANotifier>(context, listen: false).termsAgreedErrorMessage =
      true;
  Provider.of<AddEANotifier>(context, listen: false).notifyListeners();
}

class DeleteEA {
  final String userId;
  final String eAId;

  DeleteEA({required this.userId, required this.eAId});

  Map toJson() {
    return {"userId": userId, "eAId": eAId};
  }
}