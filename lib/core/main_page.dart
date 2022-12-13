import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:othia/core/search/search.dart';
import 'package:othia/core/settings/settings.dart';
import 'package:provider/provider.dart';

import '../widgets/nav_bar/nav_bar.dart';
import '../widgets/nav_bar/nav_bar_notifier.dart';
import 'add/add.dart';
import 'favourites/favourite_screen.dart';
import 'home/home_page.dart';

class MainPage extends StatelessWidget {
  static const List<Widget> _pages = [
    Home(),
    SearchPage(),
    Add(),
    FavouritePage(),
    SettingsPage()
  ];
  final PageController _pageController = PageController(initialPage: 0);

  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: NavigationBarNotifier(pageController: _pageController),
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
