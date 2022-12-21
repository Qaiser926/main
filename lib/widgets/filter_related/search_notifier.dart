import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:othia/widgets/filter_related/abstract_search_notifier.dart';
import 'package:othia/widgets/filter_related/type_filter.dart';

import '../../constants/app_constants.dart';

class SearchNotifier extends AbstractSearchNotifier {
  // Pagecontroller related
  bool isControllerSet = false;

  SearchNotifier(
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
}
