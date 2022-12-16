import 'package:flutter/material.dart';

import '../../core/test.dart';

class NavigationBarNotifier extends ChangeNotifier {
  int index = 0;
  final PageController pageController;

  final TestNotifier _testNotifier;

  NavigationBarNotifier({required this.pageController})
      : _testNotifier =
            TestNotifier(pageController: PageController(initialPage: 0));

  int get getIndex => index;

  TestNotifier get getTestNotifier => _testNotifier;

  void setIndex({required int index, required BuildContext context}) {
    this.index = index;

    pageController.jumpToPage(index);
    notifyListeners();
  }
}
