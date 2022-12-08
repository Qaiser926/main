import 'package:flutter/material.dart';
import 'package:othia/config/routes/routes.dart';
import 'package:othia/core/favourites/favourite_screen.dart';
import '../../core/detailed/detailed_event.dart';
import '../../core/search/search.dart';
import '../../widgets/splash_screen.dart';

class Pages {
  static const initialRoute = Routes.homeRoute;
  static Map<String, WidgetBuilder> routes = {
    Routes.homeRoute: (context) => const SplashScreen(),
    Routes.homeScreenRoute: (context) => const EventDetail(),
    Routes.detailedEventRoute: (context) => const EventDetail(),
    Routes.favouriteRoute: (context) => const FavouritePage(),
    Routes.searchRoute: (context) => SearchPage(),
  };
}
