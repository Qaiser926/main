import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:othia/core/search/search.dart';
import 'package:othia/core/settings/settings.dart';
import 'package:provider/provider.dart';

import '../widgets/nav_bar/nav_bar.dart';
import '../widgets/nav_bar/nav_bar_notifier.dart';
import 'add/add.dart';
import 'detailed/detailed_event.dart';
import 'favourites/favourite_screen.dart';

class MainPage extends StatelessWidget {
  static const List<Widget> _pages = [
    // TODO insert HOME instead of EventDetail
    EventDetail(),
    SearchPage(),
    Add(),
    FavouritePage(),
    SettingsPage()
  ];
  late final PageController _pageController;

  late NavigationBarNotifier navBarNotifier;

  MainPage({Key? key = Get})
      : navBarNotifier = NavigationBarNotifier(),
        _pageController = PageController(initialPage: 0),
        super(key: key) {}

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
