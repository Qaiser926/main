import 'package:flutter/material.dart';
import 'package:othia/config/routes/routes.dart';
import 'package:othia/core/favourites/favourite_screen.dart';

import '../../core/add/add.dart';
import '../../core/detailed/detailed_event.dart';
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
    Routes.detailedEventRoute: (context) => const EventDetail(),
    Routes.favouriteRoute: (context) => const FavouritePage(),
    Routes.searchRoute: (context) => SearchPage(),
    Routes.addScreenRoute: (context) => Add(),
    // Routes.searchResults: (context) => SearchResultsPage(),
  };
}
