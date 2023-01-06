import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/core/add/add_exclusives/add_page_notifier.dart';
import 'package:othia/core/add/add_exclusives/input_notifier.dart';

Column getHeadline({required BuildContext context, required Widget caption}) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(bottom: 4.h, top: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [caption],
        ),
      ),
      Divider(thickness: 2.h),
    ],
  );
}

Future getInfoDialog({required String info, required BuildContext context}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(info),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      });
}

Widget getHeadlineWithInfoDialog(
    {required BuildContext context,
    required String infoText,
    required String caption}) {
  return getHeadline(
    context: context,
    caption: GestureDetector(
      onTap: () => {getInfoDialog(info: infoText, context: context)},
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

  void _notSwitchPage(int value) {
    inputNotifier.isAddressInvalid = true;
    inputNotifier.addressFormKey.currentState?.validate();
    pageController.jumpToPage(switchPagesNotifier.currentPage);
    inputNotifier.isAddressInvalid = false;
  }

  void switchPageBehaviour(int targetPage) {
    // // case switching from basic info page to additional info page
    // if ((switchPagesNotifier.currentPage == 0) & (targetPage == 1)) {
    //   if (_isTimeCorrect() & _isTitleCategoryCorrect()) {
    //     // request latitude and longitude for stated address and test if a result was found
    //     getLatLongFromAddress(inputNotifier.getAddressString()).then((latLong) {
    //       if (latLong != null) {
    //         inputNotifier.latLong = latLong; // save requested lat/ long
    //         _switchPage(targetPage);
    //       } else {
    //         _notSwitchPage(targetPage);
    //       }
    //     });
    //   }
    //
    //   // per default page is not switched
    //   _notSwitchPage(targetPage);
    //   // notSwitchPage(value);
    // } else {
    //   // TODO write logic for additional page
    //   switchPagesNotifier.currentPage = targetPage;
    // }

    if (targetPage == 1) {
      // clear the added prices without content
      inputNotifier.clearPrices();
    }
    // case when rights for pictures were not given
    if ((switchPagesNotifier.currentPage == 1) &
        (targetPage == 2) &
        ((inputNotifier.image != null) & !inputNotifier.copyRightVerified)) {
      inputNotifier.showCopyrightErrorMessage = true;
      pageController.jumpToPage(switchPagesNotifier.currentPage);
    }

    // default too change page
    _switchPage(targetPage);
  }

  void nextPage(BuildContext context) {
    pageController.nextPage(duration: animationDuration, curve: animationCurve);
    switchPagesNotifier.currentPage = pageController.page as int;
  }

  void previousPage(BuildContext context) {
    pageController.previousPage(
        duration: animationDuration, curve: animationCurve);
    switchPagesNotifier.currentPage = pageController.page as int;
  }
}
