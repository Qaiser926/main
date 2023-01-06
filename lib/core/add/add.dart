import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/core/add/add_exclusives/basic_info_page.dart';
import 'package:othia/core/add/add_exclusives/details_page.dart';
import 'package:othia/core/add/add_exclusives/help_functions.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:othia/widgets/not_logged_in.dart';
import 'package:provider/provider.dart';

import 'add_exclusives/add_page_notifier.dart';
import 'add_exclusives/input_notifier.dart';

// TODO adjustments for modifying an event

class Add extends StatelessWidget {
  Add({super.key});

  static const int firstPage = 0;

  static final PageController pageController =
      PageController(initialPage: firstPage);
  SwitchAddPageNotifier switchPagesNotifier = SwitchAddPageNotifier(firstPage);

  AddEANotifier inputNotifier = AddEANotifier();

  // TODO
  bool isLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    SwitchPages switchPages = SwitchPages(
        inputNotifier: inputNotifier,
        pageController: pageController,
        switchPagesNotifier: switchPagesNotifier);
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
              Consumer<SwitchAddPageNotifier>(
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
            persistentFooterButtons: [getFloatingButtons(switchPages)],
            // bottomNavigationBar: getFloatingButtons(),
            // floatingActionButton: ,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: getLoggedInSensitiveBody(
                isLoggedIn: isLoggedIn,
                loggedInWidget: getLoggedInBody(switchPages),
                context: context)));
  }

  Widget getLoggedInBody(SwitchPages switchPages) {
    return PageView(
        onPageChanged: ((targetPage) {
          FocusManager.instance.primaryFocus?.unfocus(); // dismiss keyboard
          switchPages.switchPageBehaviour(targetPage);
        }),
        controller: pageController,
        children: [
          BasicInfoPage(inputNotifier),
          DetailsPage(inputNotifier),
          DetailsPage(inputNotifier),
        ]);
  }

  Widget getFloatingButtons(SwitchPages switchPages) {
    return Consumer<SwitchAddPageNotifier>(builder: (context, model, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          model.currentPage == firstPage
              ? const SizedBox.shrink()
              : getNavigationButton(
                  Icons.arrow_back, switchPages.previousPage, context),
          getNavigationButton(
              Icons.arrow_forward, switchPages.nextPage, context),
        ],
      );
    });
  }

  Widget buildUpperNavigationElement(
      {required BuildContext context,
      required SwitchAddPageNotifier switchPageModel,
      required int index}) {
    return Padding(
        padding: EdgeInsets.all(10.h),
        child: GestureDetector(
          onTap: () => {
            pageController.jumpToPage(index)},
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


}
