import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/helpers/builders.dart';

class OthiaConstants {
  static final String awsApiEndpoint = getAwsApiEndpoint();
  static const String othiaDomain = 'www.othia.de';
  static const String logoName = 'othia_logo.png';
  static const String homeIcon = 'assets/icon/home.svg';
  static const String searchIcon = 'assets/icon/search.svg';
  static const String addIcon = 'assets/icon/add.svg';
  static const String favIcon = 'assets/icon/favorite.svg';
  static const String profileIcon = 'assets/icon/profile.svg';
}

class WidgetConstants {
  static const double categoryGridItemHeight = 170;
  static const double categoryGridItemWidth = 192.8;
  static const double categoryGridItemTextWidth = categoryGridItemWidth - 58;
}

class APIConstants {
  static const String addFavouriteEA = 'addfavouriteea';
  static const String createEA = 'createea';
  static const String deleteAccount = 'deleteaccount';
  static const String deleteEA = 'deleteea';
  static const String eADetailPath = 'eadetail';
  static const String getEAIdsForCategory = 'categoryids';
  static const String getEAIdsForEventSeries = 'eventseriesids';
  static const String getEAIdsForLocation = 'locationids';
  static const String getEASummary = 'easummary';
  static const String fetchFavouriteEventsAndActivities = 'favouriteea';
  static const String getHomePageIds = 'homepageids';
  static const String getMapResultIds = 'mapsearch';
  static const String getPrivateUserInfo = 'privateuser';
  static const String getPublicUserInfo = 'publicuser';
  static const String getSearchResultIds = 'search';
  static const String getUserInterests = 'getuserinterests ';
  static const String isEALikedByUser = 'isealiked';
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
  static const PriceRangeEnd = 100.0;
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
