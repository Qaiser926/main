import 'dart:io';

import 'package:flutter/material.dart';
import 'package:othia/config/routes/routes.dart';
import 'package:othia/modules/models/detailed_event.dart';
import 'package:uuid/uuid.dart';

import '../../core/detailed/detailed_event.dart';
import '../../widgets/splash_screen.dart';

class Pages {
  static const initialRoute = Routes.homeRoute;
  static Map<String, WidgetBuilder> routes = {
    Routes.homeRoute: (context) => const SplashScreen(),
    Routes.homeScreenRoute: (context) => FeaturedEventDetail(
          event: Future.delayed(
              const Duration(seconds: 2),
              () => const DetailedEvent(
                  id: Uuid(),
                  locationId: Uuid(),
                  locationTitle: 'loc_title',
                  price: 12.12,
                  title: 'Main_Title')),
        )
  };
}
