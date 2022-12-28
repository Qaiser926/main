import 'package:flutter/material.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/widgets/filter_related/abstract_filter.dart';
import 'package:othia/widgets/filter_related/category_filter/category_filter.dart';
import 'package:othia/widgets/filter_related/notifiers/abstract_search_notifier.dart';
import 'package:othia/widgets/filter_related/notifiers/map_notifier.dart';

import 'price_filter.dart';
import 'sort_filter.dart';
import 'time_filter.dart';
import 'type_filter.dart';

class MapFilter extends AbstractFilter<MapNotifier> {
  MapFilter({required super.context, required super.dynamicProvider});

  // TODO disable buttons on first page, change behaviour
  @override
  List<Widget> getFilters(
      {required BuildContext context,
      required AbstractSearchNotifier dynamicNotifier}) {
    List<Widget> filter = [
      getFilter(
          context: context,
          index: 1,
          caption: getCategoryCaption(
              context: context, dynamicNotifier: dynamicNotifier),
          coloredBorder: dynamicNotifier.categoryFilterActivated,
          onTapFunction: () {
            return getCategoryFilterDialog(
                context: context, dynamicProvider: dynamicNotifier);
          }),
      getFilter(
          context: context,
          index: 1,
          caption: getTimeCaption(
              context: context, dynamicProvider: dynamicNotifier),
          coloredBorder: dynamicNotifier.timeFilterActivated,
          backgroundColor: Colors.grey,
          onTapFunction: () {
            return TimeFilterDialog(
                context: context, dynamicProvider: dynamicNotifier);
          }),
      // index has only effect if it is zero --> all others just 1
      getFilter(
          context: context,
          index: 1,
          caption: getPriceCaption(
              context: context, dynamicNotifier: dynamicNotifier),
          coloredBorder: dynamicNotifier.priceFilterActivated,
          onTapFunction: () {
            return priceFilterDialog(
                context: context, dynamicProvider: dynamicNotifier);
          }),
      getFilter(
          context: context,
          index: 1,
          caption: getTypeCaption(
              context: context, dynamicProvider: dynamicNotifier),
          coloredBorder: dynamicNotifier.typeFilterActivated,
          onTapFunction: () => typeFilterDialog(
              context: context, dynamicProvider: dynamicNotifier)),
      // getFilter(
      //     context: context,
      //     index: 1,
      //     caption: AppLocalizations.of(context)!.additionalFilters,
      //     coloredBorder: false,
      //     onTapFunction: () => print("addFilter")),
    ];
    // only add category if not in start screen
    if (dynamicNotifier.currentIndex != NavigatorConstants.SearchPageIndex) {
      filter.add(
        getFilter(
            context: context,
            index: 1,
            caption: getSortCaption(
                context: context, dynamicProvider: dynamicNotifier),
            coloredBorder: dynamicNotifier.sortFilterActivated,
            onTapFunction: () => sortFilterDialog(
                context: context, dynamicProvider: dynamicNotifier)),
      );
    }
    if (dynamicNotifier.anyFilterActivated()) {
      filter.insert(
        0,
        getResetFilter(context),
      );
    }
    return filter;
  }

  Color getBackgroundColor() {
    // TODO
    return Colors.grey;
  }
}
