import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/helpers/builders.dart';

class OthiaConstants {
  static final String awsApiEndpoint = getAwsApiEndpoint();
  static const String othiaDomain = 'www.othia.de';

  //TODO make this constant together with the link in rest api services
  static const String eventDetailPath = 'events';
  static const String organizerDetailPath = 'organizer';
}

class WidgetConstants {
  static const double categoryGridItemHeight = 170;
  static const double categoryGridItemWidth = 192.8;
  static const double categoryGridItemTextWidth = categoryGridItemWidth - 58;
}

class OtherConstants {
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 63;
}

class DataConstants {
  static const MaxDescriptionLength = 400;
  static const MaxTitleLength = 100;
  static const MaxImageWidth = 1800.0;
  static const MaxImageHeight = 1800.0;
  static const SearchEnhancementDimensionScale = 4;
  static const SearchEnhancementEligibilityScale = 3;
}

class NavigatorConstants {
  static const PriceRangeStart = 0.0;
  static const PriceRangeEnd = 200.0;

  static const SearchPageIndex = 0;
  static const ResultPageIndex = 1;
  static const ShowMorePageIndex = 2;

  static const CategoryNameCutOff = 20;

  static const EventActivityId = 'eAId';

  static const DefaultProfilePicture = "default_profile_image.jpg";

  static const MapImage = "map_image.png";

  static backToPrev() {
    Get.back();
  }

  static sendToScreen(Widget widget) {
    Get.to(widget);
  }

  static closeApp() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  static sendToNext(String route, {Object? arguments}) {
    if (arguments != null) {
      Get.toNamed(route, arguments: arguments);
    } else {
      Get.toNamed(route);
    }
  }
}
