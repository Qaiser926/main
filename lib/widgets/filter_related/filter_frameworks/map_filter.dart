import 'package:flutter/material.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/widgets/filter_related/category_filter/category_filter.dart';
import 'package:othia/widgets/filter_related/filter_frameworks/abstract_filter.dart';
import 'package:othia/widgets/filter_related/notifiers/abstract_query_notifier.dart';
import 'package:othia/widgets/filter_related/notifiers/map_notifier.dart';

import '../price_filter.dart';
import '../sort_filter.dart';
import '../time_filter.dart';
import '../type_filter.dart';

class MapFilter extends AbstractFilter<MapNotifier> {
  MapFilter({required super.context, required super.dynamicProvider});

  @override
  List<Widget> getFilters(
      {required BuildContext context,
      required AbstractQueryNotifier dynamicNotifier}) {
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
          textStyle: getTextStyle(),
          onTapFunction: isStartPage()
              ? () => {}
              : () {
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
          textStyle: getTextStyle(),
          onTapFunction: isStartPage()
              ? () => {}
              : () {
                  return priceFilterDialog(
                      context: context, dynamicProvider: dynamicNotifier);
                }),
      getFilter(
          context: context,
          index: 1,
          caption: getTypeCaption(
              context: context, dynamicProvider: dynamicNotifier),
          coloredBorder: dynamicNotifier.typeFilterActivated,
          textStyle: getTextStyle(),
          onTapFunction: isStartPage()
              ? () => {}
              : () => typeFilterDialog(
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
            onTapFunction: isStartPage()
                ? () => {}
                : () => sortFilterDialog(
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

  TextStyle getTextStyle() {
    if (isStartPage()) {
      return TextStyle(color: Colors.grey);
    } else {
      return TextStyle(color: Colors.white);
    }
  }

  bool isStartPage() {
    return dynamicProvider.currentIndex == 0;
  }
}
