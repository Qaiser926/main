import 'package:flutter/material.dart';
import 'package:othia/widgets/filter_related/search_notifier.dart';

class NavigationBarNotifier extends ChangeNotifier {
  int index = 0;
  final PageController pageController;

  final SearchNotifier _searchNotifier;

  //TODO decide if SearchNotifier is initialized here or the fields are non-required

  NavigationBarNotifier({required this.pageController})
      : _searchNotifier = SearchNotifier(
          pageController: PageController(initialPage: 0),
        );

  int get getIndex => index;

  SearchNotifier get getSearchNotifier => _searchNotifier;

  void setIndex({required int index, required BuildContext context}) {
    this.index = index;

    pageController.jumpToPage(index);
    notifyListeners();
  }
}
