import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/widgets/filter_related/price_filter.dart';
import 'package:othia/widgets/filter_related/time_filter.dart';
import 'package:provider/provider.dart';

import '../../utils/ui/ui_utils.dart';
import 'search_notifier.dart';

SizedBox buildDropdownBar({required BuildContext context}) {
  // var test = Provider.of<SearchNotifier>(context, listen: false);
  // test.activateShowSearchResults();
  final List<Widget> filters = getFilters(context: context);
  return SizedBox(
    height: 35.h,
    // disable color scheme
    child: ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: filters.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return filters[index];
      },
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
      margin: EdgeInsets.only(right: 12.h, left: index == 0 ? 20.h : 0),
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
        caption: AppLocalizations.of(context)!.sort,
        coloredBorder: false,
        onTapFunction: () => print("sort")),
    getFilter(
        context: context,
        index: 1,
        caption: AppLocalizations.of(context)!.type,
        coloredBorder: false,
        onTapFunction: () => print("type")),
    getFilter(
        context: context,
        index: 1,
        caption: AppLocalizations.of(context)!.additionalFilters,
        coloredBorder: false,
        onTapFunction: () => print("addFilter")),
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
          index: 0,
          caption: AppLocalizations.of(context)!.category,
          coloredBorder: false,
          onTapFunction: () {
            return;
          }),
    );
  } else {
    filter.insert(
      0,
      getFilter(
          context: context,
          index: 0,
          caption: getTimeCaption(context: context),
          coloredBorder: Provider.of<SearchNotifier>(context, listen: false)
              .timeFilterActivated,
          onTapFunction: () {
            return TimeFilterDialog(context: context);
          }),
    );
  }
  return filter;
}

Future<dynamic> TimeFilterDialog({required BuildContext context}) {
  var test = Provider.of<SearchNotifier>(context, listen: false);
  return showModalBottomSheet(
      isScrollControlled: true,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      context: context,
      builder: (_) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: test,
            )
          ],
          child: Wrap(children: [TimeFilter()]),
        );
      });
}
