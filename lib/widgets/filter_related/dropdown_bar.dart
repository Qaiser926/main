import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:othia/widgets/filter_related/price_filter.dart';
import 'package:othia/widgets/filter_related/time_filter.dart';
import 'package:provider/provider.dart';
import '../../utils/services/search_notifier.dart';
import '../../utils/ui/ui_utils.dart';

// TODO on selected items include counter and give Box colored border, make a class
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
    required String heading,
    required Function onTapFunction}) {
  return GestureDetector(
    onTap: () => onTapFunction(),
    child: Container(
      margin: EdgeInsets.only(right: 12.h, left: index == 0 ? 20.h : 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.h),
        color: Theme.of(context).colorScheme.tertiary,
      ),
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.all(7.h),
        child: Row(
          children: [
            getCustomFont(
              text: heading,
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
        heading: AppLocalizations.of(context)!.price,
        onTapFunction: () {
          return priceFilterDialog(context: context);

        }),
    getFilter(
        context: context,
        index: 1,
        heading: AppLocalizations.of(context)!.sort,
        onTapFunction: () => print("sort")),
    getFilter(
        context: context,
        index: 1,
        heading: AppLocalizations.of(context)!.type,
        onTapFunction: () => print("type")),
    getFilter(
        context: context,
        index: 1,
        heading: AppLocalizations.of(context)!.additionalFilters,
        onTapFunction: () => print("addFilter")),
  ];
  // only add category if not in start screen
  if (Provider.of<SearchNotifier>(context, listen: false).showCategoryFilter) {
    filter.insert(0, getFilter(
        context: context,
        index: 1,
        heading: AppLocalizations.of(context)!.time,
        onTapFunction: () {
          return TimeFilterDialog(context: context);
        }),);
    filter.insert(0, getFilter(
        context: context,
        index: 0,
        heading: AppLocalizations.of(context)!.category,
        onTapFunction: () {
          return;
        }),);
  } else {
    filter.insert(0,getFilter(
        context: context,
        index: 0,
        heading: AppLocalizations.of(context)!.time,
        onTapFunction: () {
          return TimeFilterDialog(context: context);
        }),);
  }
  return filter;
}



Future<dynamic> TimeFilterDialog({required BuildContext context}) {
  return showModalBottomSheet(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      context: context,
      builder: (context) {
        return Container(
          height: 380,
          child: TimeFilter(),
        );
      });
}
