import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:othia/widgets/filter_related/notifiers/abstract_search_notifier.dart';
import 'package:othia/widgets/filter_related/type_filter.dart';

import '../../../constants/app_constants.dart';

class MapNotifier extends AbstractSearchNotifier {
  // Pagecontroller related
  bool isControllerSet = false;

  MapNotifier(
      {priceRange = const RangeValues(
          NavigatorConstants.PriceRangeStart, NavigatorConstants.PriceRangeEnd),
      startDate,
      endDate,
      super.sortCriteria = null,
      super.eAType = EAType.eventsActivites,
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
}
