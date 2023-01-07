import 'package:flutter/material.dart';
import 'package:othia/widgets/filter_related/notifiers/search_notifier.dart';

import '../../constants/app_constants.dart';
import '../../core/add/add.dart';

class NavigationBarNotifier extends ChangeNotifier {
  int index = 0;
  final PageController pageController;
  bool isDialogOpen = false;
  final SearchNotifier _searchNotifier;

  //TODO decide if SearchNotifier is initialized here or the fields are non-required

  NavigationBarNotifier({required this.pageController})
      : _searchNotifier = SearchNotifier(
          pageController: PageController(initialPage: 0),
        );

  int get getIndex => index;

  SearchNotifier get getSearchNotifier => _searchNotifier;

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
