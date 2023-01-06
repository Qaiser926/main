import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/core/add/add_exclusives/basic_info_page.dart';
import 'package:othia/core/add/add_exclusives/details_page.dart';
import 'package:othia/core/add/add_exclusives/location_time_page.dart';
import 'package:othia/utils/services/rest-api/geocoding.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:othia/widgets/not_logged_in.dart';
import 'package:provider/provider.dart';

import 'add_exclusives/add_page_notifier.dart';
import 'add_exclusives/input_notifier.dart';

//TODO only for logged in users, show log in page
// TODO adjustments for modifying an event

class Add extends StatelessWidget {
  Add({super.key});

  static const animationDuration = Duration(milliseconds: 200);
  static const animationCurve = Curves.decelerate;

  static const int firstPage = 0;

  static final PageController _pageController =
      PageController(initialPage: firstPage);
  AddPageNotifier switchPagesNotifier = AddPageNotifier(firstPage);

  AddEANotifier inputNotifier = AddEANotifier();

  // TODO
  bool isLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: switchPagesNotifier,
          ),
          ChangeNotifierProvider.value(
            value: inputNotifier,
          )
        ],
        child: Scaffold(
            appBar: AppBar(automaticallyImplyLeading: false, actions: [
              Consumer<AddPageNotifier>(
                  builder: (context, switchPageModel, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildUpperNavigationElement(
                        context: context,
                        index: 0,
                        switchPageModel: switchPageModel),
                    getArrowIcon(context),
                    buildUpperNavigationElement(
                        context: context,
                        index: 1,
                        switchPageModel: switchPageModel),
                    getArrowIcon(context),
                    buildUpperNavigationElement(
                        context: context,
                        index: 2,
                        switchPageModel: switchPageModel),
                    getArrowIcon(context),
                    buildUpperNavigationElement(
                        context: context,
                        index: 3,
                        switchPageModel: switchPageModel),
                    getHorSpace(16.h)
                  ],
                );
              })
            ]),
            persistentFooterButtons: [getFloatingButtons()],
            // bottomNavigationBar: getFloatingButtons(),
            // floatingActionButton: ,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: getLoggedInSensitiveBody(
                isLoggedIn: isLoggedIn,
                loggedInWidget: getLoggedInBody(),
                context: context)));
  }

  Widget getLoggedInBody() {
    return PageView(
        onPageChanged: ((value) {
          FocusManager.instance.primaryFocus?.unfocus(); // dismiss keyboard
          // TODO write as own function
          // the first if clause is a special case as for the address the user states,
          // latitude and longitude are requested. Until the latitude and longitude is not returned,
          // the user cannot go to the next page. If no latitude and longitude are received, the notifier value
          // of isAddressInvalid is changed which triggers a Consumer on the location page to validate the forms
          switchPageBehaviour(value);
        }),
        controller: _pageController,
        children: [
          BasicInfoPage(inputNotifier),
          LocationTimePage(inputNotifier),
          DetailsPage(inputNotifier),
        ]);
  }

  bool isTimeCorrect() {
    return inputNotifier.timeFormKey.currentState!.validate() |
        inputNotifier.times[1];
  }

  bool isTitleCategoryCorrect() {
    return inputNotifier.basicInformationFormKey.currentState!.validate();
  }

  void switchPage(int value) {
    switchPagesNotifier.currentPage = value;
    _pageController.jumpToPage(value);
  }

  void notSwitchPage(int value) {
    inputNotifier.isAddressInvalid = true;
    inputNotifier.addressFormKey.currentState?.validate();
    _pageController.jumpToPage(switchPagesNotifier.currentPage);
    inputNotifier.isAddressInvalid = false;
  }

  void switchPageBehaviour(int value) {
    // case switching from basic info page to additional info page
    if ((switchPagesNotifier.currentPage == 0) & (value == 1)) {
      if (isTimeCorrect() & isTitleCategoryCorrect()) {
        // request latitude and longitude for stated address and test if a result was found
        getLatLongFromAddress(inputNotifier.getAddressString()).then((latLong) {
          if (latLong != null) {
            inputNotifier.latLong = latLong; // save requested lat/ long
            switchPage(value);
          } else {
            notSwitchPage(value);
          }
        });
      }

      // per default page is not switched
      notSwitchPage(value);
      // notSwitchPage(value);
    } else {
      // TODO write logic for additional page
      switchPagesNotifier.currentPage = value;
    }
  }

  Widget getFloatingButtons() {
    return Consumer<AddPageNotifier>(builder: (context, model, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          model.currentPage == firstPage
              ? const SizedBox.shrink()
              : getNavigationButton(Icons.arrow_back, previousPage, context),
          getNavigationButton(Icons.arrow_forward, nextPage, context),
        ],
      );
    });
  }

  Widget buildUpperNavigationElement(
      {required BuildContext context,
      required AddPageNotifier switchPageModel,
      required int index}) {
    return Padding(
        padding: EdgeInsets.all(10.h),
        child: GestureDetector(
          onTap: () => {
            _pageController.jumpToPage(index)
          },
          child: Container(
            decoration: BoxDecoration(
                color: switchPageModel.currentPage == index
                    ? Theme.of(context).colorScheme.primary
                    : null,
                shape: BoxShape.circle,
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary)),
            width: 40.h,
            height: 40.h,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                (index + 1).toString(),
              ),
            ),
          ),
        ));
  }

  Icon getArrowIcon(BuildContext context) {
    return Icon(
      Icons.arrow_forward,
      size: 20.h,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  // TODO when switching pages, the left button changes its position
  Widget getNavigationButton(
      IconData icon,
      void Function(BuildContext context) onPressedFunction,
      BuildContext context) {
    return SizedBox(
        width: 100,
        child: ElevatedButton(
          style: const ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ),
          // splashColor: Colors.transparent,

          onPressed: () => onPressedFunction(context),
          child: Icon(icon),
        ));
  }

  void nextPage(BuildContext context) {
    _pageController.nextPage(
        duration: animationDuration, curve: animationCurve);
    Provider.of<AddPageNotifier>(context, listen: false).currentPage =
        _pageController.page as int;
  }

  void previousPage(BuildContext context) {
    _pageController.previousPage(
        duration: animationDuration, curve: animationCurve);
    Provider.of<AddPageNotifier>(context, listen: false).currentPage =
        _pageController.page as int;
  }
}

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
