import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/helpers/builders.dart';

class OthiaConstants {
  static final String awsApiEndpoint = getAwsApiEndpoint();
  static const String othiaDomain = 'www.othia.de';
}

class WidgetConstants {
  static const double categoryGridItemHeight = 170;
  static const double categoryGridItemWidth = 192.8;
  static const double categoryGridItemTextWidth = categoryGridItemWidth - 58;
}

class APIConstants {
  static const String deleteEA = 'deleteEA-dev';
  static const String createEA = 'createEA-dev';
  static const String getPrivateUserInfo = 'getUserInfo-dev';
  static const String savePrivateUserInfo = 'saveprivateuserinformation';
  static const String getMapResultIds = 'getMapResultIds-dev';
  static const String getSearchResultIds = 'getSearchResultIds-dev';
  static const String getEASummary = 'getEASummary-dev';
  static const String getEAIdsForLocation = 'getEAIdsForLocation-dev';
  static const String getEAIdsForEventSeries = 'getMapResultIds-dev';
  static const String getEAIdsForCategory = 'getEAIdsForCategory-dev';
  static const String isEALikedByUser = 'isEALikedByUser-dev';
  static const String addFavouriteEventOrActivity = 'addLikedEA-dev';
  static const String removeFavouriteEventOrActivity = 'removeFavourite-dev';
  static const String fetchFavouriteEventsAndActivities =
      'favouriteeventsandactivities';
  static const String getHomePageIds = 'getHomePageIds-dev';
  static const String deleteAccount = 'deleteaccount';
  static const String organizerDetailPath = 'organizer';
  static const String eventDetailPath = 'events';
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
  static const CategoryNameCutOff = 20;

  static const EventActivityId = 'eAId';
  static const PriceRangeStart = 0.0;
  static const PriceRangeEnd = 200.0;
}

class NavigatorConstants {
  static const SearchPageIndex = 0;
  static const ResultPageIndex = 1;
  static const ShowMorePageIndex = 2;

  static const int AddPageIndex = 2;
  static const int FavouritePageIndex = 3;
  static const int ProfilePageIndex = 4;

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
