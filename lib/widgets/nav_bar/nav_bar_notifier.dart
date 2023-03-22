import 'package:flutter/material.dart';
import 'package:othia/widgets/filter_related/notifiers/search_notifier.dart';

import '../../constants/app_constants.dart';
import '../../core/add/add.dart';

class NavigationBarNotifier extends ChangeNotifier {
  int index = 0;
  PageController pageController;
  final SearchNotifier _searchNotifier;

  NavigationBarNotifier({required this.pageController, required this.index})
      // the initialized PageController is not the one of the navigationBar in the Main menu, but in the search menu
      : _searchNotifier = SearchNotifier(
        
          pageController: PageController(initialPage: 0),
        );

  int get getIndex => index;

  SearchNotifier get getSearchNotifier => _searchNotifier;

  void setIndex({required int index, required BuildContext context}) {
    if (index == NavigatorConstants.AddPageIndex) {
      NavigatorConstants.sendToScreen(Add());
    } else {
      this.index = index;
      pageController.jumpToPage(index);
      notifyListeners();
    }
  }
}
