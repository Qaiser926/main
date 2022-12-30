import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_exclusives/add_first_page.dart';
import 'add_exclusives/add_page_notifier.dart';
import 'add_exclusives/input_notifier.dart';

//TODO only for logged in users, show log in page

class Add extends StatelessWidget {
  const Add({super.key});

  static const animationDuration = Duration(milliseconds: 200);
  static const animationCurve = Curves.decelerate;

  static const int firstPage = 0;

  static final PageController _pageController =
      PageController(initialPage: firstPage);

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      print(_pageController.page);
    });
    AddPageNotifier notifier = AddPageNotifier(firstPage);

    InputNotifier inputNotifier = InputNotifier();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: notifier,
        ),
        ChangeNotifierProvider.value(
          value: inputNotifier,
        )
      ],
      child: Scaffold(
        persistentFooterButtons: [getFloatingButtons()],
        // bottomNavigationBar: getFloatingButtons(),
        // floatingActionButton: ,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: PageView(
            onPageChanged: ((value) {
              notifier.currentPage = value;
            }),
            controller: _pageController,
            children: [FirstAddPage(inputNotifier), SecondAddPage()]),
      ),
    );
  }

  Widget getFloatingButtons() {
    List<Widget> rowChildren = [];
    try {
      print(_pageController.page);
    } on AssertionError catch (e) {
      print(_pageController.initialPage);
    }

    return Consumer<AddPageNotifier>(builder: (context, model, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          model.currentPage == firstPage
              ? const SizedBox.shrink()
              : getNavigationButton(Icons.arrow_back, previousPage),
          getNavigationButton(Icons.arrow_forward, nextPage),
        ],
      );
    });
  }

  Widget getNavigationButton(IconData icon, void Function() onPressedFunction) {
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

          onPressed: () => onPressedFunction(),
          child: Icon(icon),
        ));
  }

  void nextPage() {
    _pageController.nextPage(
        duration: animationDuration, curve: animationCurve);
  }

  void previousPage() {
    _pageController.previousPage(
        duration: animationDuration, curve: animationCurve);
  }
}
