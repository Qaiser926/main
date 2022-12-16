import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/widgets/filter_related/price_filter.dart';
import 'package:othia/widgets/filter_related/sort_filter.dart';
import 'package:othia/widgets/filter_related/time_filter.dart';
import 'package:othia/widgets/filter_related/type_filter.dart';
import 'package:provider/provider.dart';

import '../category_filter/category_filter.dart';
import 'search_notifier.dart';

Consumer<dynamic> buildDropdownBar({required BuildContext context}) {
  // var test = Provider.of<SearchNotifier>(context, listen: false);
  // test.activateShowSearchResults();

  return Consumer<SearchNotifier>(builder: (context, model, child) {
    final List<Widget> filters =
        getFilters(context: context, searchNotifier: model);
    return Container(
        alignment: Alignment.centerLeft,
        child: SizedBox(
            height: 35.h,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: filters.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return filters[index];
                },
              ),
            )));
  });
}

Widget getResetFilter(BuildContext context) {
  return GestureDetector(
    onTap: () => {
      Provider.of<SearchNotifier>(context, listen: false).backToDefault(),
      Provider.of<SearchNotifier>(context, listen: false).goToSearchPage(),
    },
    child: Container(
      margin: EdgeInsets.only(right: 12.h, left: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.h),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        color: Theme.of(context).colorScheme.primary,
      ),
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.all(7.h),
        child: Row(
          children: [
            Text(
              AppLocalizations.of(context)!.clearFilter,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Icon(
              Icons.close,
              size: 20.h,
              color: Colors.white,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget getFilter(
    {required BuildContext context,
    required int index,
    required String caption,
    required Function onTapFunction,
    required bool coloredBorder}) {
  Color? borderColor = null;
  if (coloredBorder) {
    borderColor = Theme.of(context).colorScheme.primary;
  } else {
    borderColor = Theme.of(context).colorScheme.tertiary;
  }
  return GestureDetector(
    onTap: () => onTapFunction(),
    child: Container(
      margin: EdgeInsets.only(right: 12.h, left: index == 0 ? 10.h : 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.h),
        border: Border.all(color: borderColor),
        color: Theme.of(context).colorScheme.tertiary,
      ),
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.all(7.h),
        child: Row(
          children: [
            Text(
              caption,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Icon(
              Icons.arrow_drop_down,
              size: 20.h,
            ),
          ],
        ),
      ),
    ),
  );
}

List<Widget> getFilters(
    {required BuildContext context, required SearchNotifier searchNotifier}) {
  List<Widget> filter = [
    // index has only effect if it is zero --> all others just 1
    getFilter(
        context: context,
        index: 1,
        caption:
            getPriceCaption(context: context, searchNotifier: searchNotifier),
        coloredBorder: searchNotifier.priceFilterActivated,
        onTapFunction: () {
          return priceFilterDialog(context: context);
        }),
    getFilter(
        context: context,
        index: 1,
        caption: getTypeCaption(context: context),
        coloredBorder: searchNotifier.typeFilterActivated,
        onTapFunction: () => typeFilterDialog(context: context)),
    // getFilter(
    //     context: context,
    //     index: 1,
    //     caption: AppLocalizations.of(context)!.additionalFilters,
    //     coloredBorder: false,
    //     onTapFunction: () => print("addFilter")),
  ];
  // only add category if not in start screen
  if (searchNotifier.currentIndex != NavigatorConstants.SearchPageIndex) {
    filter.insert(
      0,
      getFilter(
          context: context,
          index: 1,
          caption: getTimeCaption(context: context),
          coloredBorder: searchNotifier.timeFilterActivated,
          onTapFunction: () {
            return TimeFilterDialog(context: context);
          }),
    );
    filter.insert(
      0,
      getFilter(
          context: context,
          // TODO implement caption and colored Border
          index: 1,
          caption: getCategoryCaption(
              context: context, searchNotifier: searchNotifier),
          coloredBorder: searchNotifier.categoryFilterActivated,
          onTapFunction: () {
            return CategoryFilterDialog(context: context);
          }),
    );
    filter.add(
      getFilter(
          context: context,
          index: 1,
          caption: getSortCaption(context: context),
          coloredBorder: searchNotifier.sortFilterActivated,
          onTapFunction: () => sortFilterDialog(context: context)),
    );
  } else {
    filter.insert(
      0,
      getFilter(
          context: context,
          index: 1,
          caption: getTimeCaption(context: context),
          coloredBorder: searchNotifier.timeFilterActivated,
          onTapFunction: () {
            return TimeFilterDialog(context: context);
          }),
    );
  }
  if (searchNotifier.anyFilterActivated()) {
    filter.insert(
      0,
      getResetFilter(context),
    );
  }
  return filter;
}
