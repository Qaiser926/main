import 'package:flutter/material.dart';
import 'package:othia/config/routes/routes.dart';
import 'package:othia/core/favourites/favourite_screen.dart';
import 'package:othia/widgets/nav_bar/nav_bar_notifier.dart';

import '../../core/add/add.dart';
import '../../core/detailed/detailedEA.dart';
import '../../core/home/home_page.dart';
import '../../core/main_page.dart';
import '../../core/search/search.dart';
import '../../widgets/splash_screen.dart';

class Pages {
  static const initialRoute = Routes.homeRoute;
  static Map<String, WidgetBuilder> routes = {
    Routes.homeRoute: (context) => const SplashScreen(),
    Routes.mainScreenRoute: (context) => MainPage(),
    Routes.homeScreenRoute: (context) => const HomePage(),
    Routes.detailedEventRoute: (context) => const DetailedEAPage(),
    Routes.favouriteRoute: (context) => const FavouritePage(),
    Routes.searchRoute: (context) => SearchPage(),
    Routes.addScreenRoute: (context) => Add(),
    // Routes.searchResults: (context) => SearchResultsPage(),
  };
}
