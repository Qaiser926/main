import 'package:flutter/material.dart';
import 'package:othia/core/home/home_page.dart';
import 'package:othia/core/profile/profile.dart';
import 'package:othia/core/search/search.dart';
import 'package:othia/main.dart';
import 'package:provider/provider.dart';

import '../widgets/nav_bar/nav_bar.dart';
import '../widgets/nav_bar/nav_bar_notifier.dart';
import 'add/add.dart';
import 'favourites/favourite_screen.dart';

class MainPage extends StatelessWidget {
  static final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    Add(),
    const FavouritePage(),
    const ProfilePage(),
  ];

  MainPage({Key? key}) : super(key: key);

  @override
  Consumer build(BuildContext context) {
    // navBarNotifier.setPageController(_pageController);
    return Consumer<NavigationBarNotifier>(
        builder: (context, navigationBarNotifier, child) {
      return WillPopScope(
          onWillPop: () {
            return closeAppDialog(context, navigationBarNotifier);
          },
          child: Scaffold(
            bottomNavigationBar: const CustomNavigationBar(),
            body: PageView(
              controller: navigationBarNotifier.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _pages,
            ),
          ));
    });
  }
}
