import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/helpers/builders.dart';

class OthiaConstants {
  static final String awsApiEndpoint = getAwsApiEndpoint();
  static const String othiaDomain = 'www.othia.de';
  static const String logoName = 'othia_logo.png';
}

class WidgetConstants {
  static const double categoryGridItemHeight = 170;
  static const double categoryGridItemWidth = 192.8;
  static const double categoryGridItemTextWidth = categoryGridItemWidth - 58;
}

class APIConstants {
  static const String addFavouriteEA = 'addfavouriteea';
  static const String createEA = 'createEA';
  static const String deleteAccount = 'deleteAccount';
  static const String deleteEA = 'deleteEA';
  static const String eventDetailPath = 'event';
  static const String getEAIdsForCategory = 'getEAIdsForCategory';
  static const String getEAIdsForEventSeries = 'geteaidsforeventseries';
  static const String getEAIdsForLocation = 'geteaidsforlocation';
  static const String getEASummary = 'geteasummary';
  static const String fetchFavouriteEventsAndActivities =
      'getfavouriteeventsandactivities';
  static const String getHomePageIds = 'gethomepageids';
  static const String getHostedEA = 'gethostedea';
  static const String getMapResultIds = 'getmapresultids';
  static const String getPrivateUserInfo = 'getprivateuserinfo';
  static const String getPublicUserInfo = 'getpublicuserinfo';
  static const String getSearchResultIds = 'getsearchresultids';
  static const String getUserInterests = 'getuserinterests ';
  static const String isEALikedByUser = 'isealikedbyuser';
  static const String removeFavouriteEventOrActivity = 'removefavouriteea';
  static const String savePrivateUserInfo = 'saveprivateuserinformation';

  static const String organizerDetailPath = 'organizer';
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
  static const MaxPriceLength = 20;

  static const EventActivityId = 'eAId';
  static const notGoBack = 'notGoBack';
  static const PriceRangeStart = 0.0;
  static const PriceRangeEnd = 200.0;
}

class NavigatorConstants {
  static const SearchPageIndex = 0;
  static const ResultPageIndex = 1;
  static const ShowMorePageIndex = 2;

  static const int HomePageIndex = 0;
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
