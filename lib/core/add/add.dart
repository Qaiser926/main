import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/core/add/add_exclusives/basic_info_page.dart';
import 'package:othia/core/add/add_exclusives/location_time_page.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:othia/widgets/not_logged_in.dart';
import 'package:provider/provider.dart';

import '../../utils/services/rest-api/geocoding.dart';
import 'add_exclusives/add_first_page.dart';
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
          // the first if clause is a special case as for the address the user states,
          // latitude and longitude are requested. Until the latitude and longitude is not returned,
          // the user cannot go to the next page. If no latitude and longitude are received, the notifier value
          // of isAddressInvalid is changed which triggers a Consumer on the location page to validate the forms
          if ((switchPagesNotifier.currentPage == 1) &
              (value == 2) &
              inputNotifier.locationType[0]) {
            getLatLongFromAddress(inputNotifier.getAddressString())
                .then((latLong) {
              if (latLong != null) {
                // inputNotifier.isAddressInvalid = false;
                // inputNotifier.notifyListeners();
                inputNotifier.latLong = latLong;
                switchPagesNotifier.currentPage = value;
                _pageController.jumpToPage(value);
                inputNotifier.addressFormKey.currentState?.validate();
              } else {
                inputNotifier.isAddressInvalid = true;
                inputNotifier.addressFormKey.currentState?.validate();
                _pageController.jumpToPage(switchPagesNotifier.currentPage);
                inputNotifier.isAddressInvalid = false;
              }
            });
            // per default go not to the next page until location answer is loaded
            _pageController.jumpToPage(switchPagesNotifier.currentPage);
          } else {
            // this is the normal case without requests for the other pages
            if (inputNotifier.goToNextPage(switchPagesNotifier, value)) {
              switchPagesNotifier.currentPage = value;
            } else {
              _pageController.jumpToPage(switchPagesNotifier.currentPage);
            }
          }
        }),
        controller: _pageController,
        children: [
          BasicInfoPage(inputNotifier),
          LocationTimePage(inputNotifier),
          FirstAddPage(inputNotifier),
          SecondAddPage()
        ]);
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
        padding: EdgeInsets.only(bottom: 10.h, top: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [caption],
        ),
      ),
      Divider(thickness: 2.h),
    ],
  );
}
