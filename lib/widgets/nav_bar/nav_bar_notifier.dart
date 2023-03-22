import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:othia/widgets/filter_related/notifiers/search_notifier.dart';

import '../../constants/app_constants.dart';
import '../../core/add/add.dart';

class NavigationBarNotifier extends ChangeNotifier {
  int index = 0;

  final SearchNotifier _searchNotifier;

  NavigationBarNotifier({required this.index})
      : _searchNotifier = SearchNotifier(
          pageController: PageController(initialPage: 0),
        );

  int get getIndex => index;

  SearchNotifier get getSearchNotifier => _searchNotifier;

  void setNavigationBarSiteByIndex(
      {required int index, BuildContext? context}) {
    if (index == NavigatorConstants.AddPageIndex) {
      Get.to(Add());
    } else {
      this.index = index;

      notifyListeners();
    }
  }
}
