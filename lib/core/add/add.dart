import 'package:flutter/material.dart';

import 'add_exclusives/add_first_page.dart';

class Add extends StatelessWidget {
  const Add({super.key});

  static const animationDuration = Duration(milliseconds: 200);
  static const animationCurve = Curves.decelerate;

  static final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    PageView body = getBody();

    return Scaffold(
      body: body,
      floatingActionButton: getFloatingButtons(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void nextPage() {
    _pageController.nextPage(
        duration: animationDuration, curve: animationCurve);
  }

  void previousPage() {
    _pageController.previousPage(
        duration: animationDuration, curve: animationCurve);
  }

  PageView getBody() {
    return PageView(
        controller: _pageController,
        children: [FirstAddPage(), SecondAddPage()]);
  }

  Row getFloatingButtons() {
    List<Widget> rowChildren = [];
    try {
      print(_pageController.page);
    } on AssertionError catch (e) {
      print(_pageController.initialPage);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        getCustomFloating(Icons.arrow_back, previousPage),
        getCustomFloating(Icons.arrow_forward, nextPage),
      ],
    );
  }

  Widget getCustomFloating(IconData icon, void Function() onPressedFunction) {
    return SizedBox(
      width: 100,
      child: FloatingActionButton(
        splashColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        onPressed: () => onPressedFunction(),
        child: Icon(icon),
      ),
    );
  }
}
