import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:othia/widgets/filter_related/price_filter.dart';
import 'package:othia/widgets/filter_related/sort_filter.dart';
import 'package:othia/widgets/filter_related/time_filter.dart';
import 'package:othia/widgets/filter_related/type_filter.dart';
import 'package:provider/provider.dart';

import '../../core/search/search.dart';
import '../../utils/ui/ui_utils.dart';
import '../category_filter/category_filter.dart';
import 'search_notifier.dart';

Container buildDropdownBar({required BuildContext context}) {
  // var test = Provider.of<SearchNotifier>(context, listen: false);
  // test.activateShowSearchResults();
  final List<Widget> filters = getFilters(context: context);
  return Container(
    alignment: Alignment.centerLeft,
    child: SizedBox(
      height: 35.h,
      // disable color scheme
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
        )),
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
            getCustomFont(
              text: caption,
              fontSize: 16.sp,
              maxLine: 1,
              fontWeight: FontWeight.w600,
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

List<Widget> getFilters({required BuildContext context}) {
  List<Widget> filter = [
    // index has only effect if it is zero --> all others just 1
    getFilter(
        context: context,
        index: 1,
        caption: getPriceCaption(context: context),
        coloredBorder: Provider.of<SearchNotifier>(context, listen: false)
            .priceFilterActivated,
        onTapFunction: () {
          return priceFilterDialog(context: context);
        }),
    getFilter(
        context: context,
        index: 1,
        caption: getTypeCaption(context: context),
        coloredBorder: Provider.of<SearchNotifier>(context, listen: false)
            .typeFilterActivated,
        onTapFunction: () => typeFilterDialog(context: context)),
    // getFilter(
    //     context: context,
    //     index: 1,
    //     caption: AppLocalizations.of(context)!.additionalFilters,
    //     coloredBorder: false,
    //     onTapFunction: () => print("addFilter")),
  ];
  // only add category if not in start screen
  if (Provider.of<SearchNotifier>(context, listen: false).showCategoryFilter) {
    filter.insert(
      0,
      getFilter(
          context: context,
          index: 1,
          caption: getTimeCaption(context: context),
          coloredBorder: Provider.of<SearchNotifier>(context, listen: false)
              .timeFilterActivated,
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
          caption: getCategoryCaption(context: context),
          coloredBorder: Provider.of<SearchNotifier>(context, listen: false)
              .categoryFilterActivated,
          onTapFunction: () {
            return CategoryFilterDialog(context: context);
          }),
    );
    filter.add(
      getFilter(
          context: context,
          index: 1,
          caption: getSortCaption(context: context),
          coloredBorder: Provider.of<SearchNotifier>(context, listen: false)
              .sortFilterActivated,
          onTapFunction: () => sortFilterDialog(context: context)),
    );
  } else {
    filter.insert(
      0,
      getFilter(
          context: context,
          index: 1,
          caption: getTimeCaption(context: context),
          coloredBorder: Provider.of<SearchNotifier>(context, listen: false)
              .timeFilterActivated,
          onTapFunction: () {
            return TimeFilterDialog(context: context);
          }),
    );
  }
  if (Provider.of<SearchNotifier>(context, listen: false)
      .anyFilterActivated()) {
    filter.insert(
      0,
      getFilter(
          caption: AppLocalizations.of(context)!.clearFilters,
          context: context,
          index: 0,
          coloredBorder: true,
          // TODO check if best approach
          onTapFunction: () {
            Get.offAll(
              SearchPage(),
            );
          }),
    );
  }
  return filter;
}
