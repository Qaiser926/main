import 'package:flutter/material.dart';
import 'package:othia/config/routes/routes.dart';
import 'package:othia/modules/models/detailed_event/detailed_event.dart';
import 'package:uuid/uuid.dart';

import '../../core/detailed/detailed_event.dart';
import '../../widgets/splash_screen.dart';

class Pages {
  static const initialRoute = Routes.homeRoute;
  static Map<String, WidgetBuilder> routes = {
    Routes.homeRoute: (context) => const SplashScreen(),
    Routes.homeScreenRoute: (context) => const EventDetail(),
    Routes.detailedEventRoute: (context) => const EventDetail(),
  };
}
