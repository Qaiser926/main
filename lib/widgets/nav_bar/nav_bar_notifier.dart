import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../../core/add/add.dart';

class NavigationBarNotifier extends ChangeNotifier {
  int index = 0;
  final PageController pageController;

  NavigationBarNotifier({required this.pageController});

  int get getIndex => index;

  static const int addPageIndex = 2;

  void setIndex({required int index, required BuildContext context}) {
    if (index == addPageIndex) {
      NavigatorConstants.sendToScreen(Add());
    } else {
      this.index = index;
      pageController.jumpToPage(index);
      notifyListeners();
    }
  }
}
