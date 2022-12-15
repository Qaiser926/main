import 'package:flutter/material.dart';

class NavigationBarNotifier extends ChangeNotifier {
  static final NavigationBarNotifier _navigationBarNotifier =
      NavigationBarNotifier._internal();
  int index = 0;
  late final PageController pageController;

  int get getIndex => index;

  factory NavigationBarNotifier() {
    return _navigationBarNotifier;
  }

  NavigationBarNotifier._internal();

  void setPageController(PageController pageController) {
    this.pageController = pageController;
  }

  void setIndex({required int index, required BuildContext context}) {
    this.index = index;
    pageController.jumpToPage(index);
    notifyListeners();
  }
}
