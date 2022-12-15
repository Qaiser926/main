import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:othia/core/search/search.dart';
import 'package:othia/core/settings/settings.dart';
import 'package:provider/provider.dart';

import '../widgets/nav_bar/nav_bar.dart';
import '../widgets/nav_bar/nav_bar_notifier.dart';
import 'add/add.dart';
import 'detailed/detailed_event.dart';
import 'favourites/favourite_screen.dart';

class MainPage extends StatelessWidget {
  static final List<Widget> _pages = [
    // TODO insert HOME instead of EventDetail
    const EventDetail(),
    SearchPage(),
    const Add(),
    const FavouritePage(),
    const SettingsPage()
  ];
  late final PageController _pageController;

  late NavigationBarNotifier navBarNotifier;

  MainPage()
      : navBarNotifier = NavigationBarNotifier(),
        _pageController = PageController(initialPage: 0),
        super(key: Get.nestedKey(1));

  @override
  Widget build(BuildContext context) {
    navBarNotifier.setPageController(_pageController);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: NavigationBarNotifier(),
        )
      ],
      child: Scaffold(
          bottomNavigationBar: const CustomNavigationBar(),
          body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: _pages,
          )),
    );
  }
}
