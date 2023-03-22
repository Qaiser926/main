import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:othia/utils/services/rest-api/rest_api_service.dart';
import 'package:othia/widgets/filter_related/notifiers/abstract_query_notifier.dart';
import 'package:othia/widgets/filter_related/type_filter.dart';

import '../../../constants/app_constants.dart';

class MapNotifier extends AbstractQueryNotifier {
  // Pagecontroller related
  bool isControllerSet = false;

  MapNotifier(
      {priceRange = const RangeValues(
          DataConstants.PriceRangeStart, DataConstants.PriceRangeEnd),
      startDate,
      endDate,
      super.sortCriteria = null,
      super.eAType = EAType.eventsActivities,
      selectedCategoryIds,
      required PageController pageController})
      : super(
            pageController: pageController,
            selectedCategoryIds: selectedCategoryIds,
            startDate: startDate,
            endDate: endDate,
            priceRange: priceRange);

  @override
  void goToFirstPage() {
    currentIndex = NavigatorConstants.SearchPageIndex;
    pageController.jumpToPage(currentIndex);
  }

  @override
  void sendRequest() {
    searchQueryResult =
        RestService().getMapResultIds(searchQuery: getSearchQuery());
  }
}
