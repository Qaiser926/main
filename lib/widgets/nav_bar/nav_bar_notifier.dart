import 'package:flutter/material.dart';

class NavigationBarNotifier extends ChangeNotifier {
  int index = 0;

  final PageController pageController;

  NavigationBarNotifier({required this.pageController});

  int get getIndex => index;

  void setIndex({required int index, required BuildContext context}) {
    this.index = index;
    pageController.jumpToPage(index);
    notifyListeners();
  }
}
