import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:provider/provider.dart';

import 'get_reset_apply_filter.dart';
import 'search_notifier.dart';

enum SortCriteria { price, date, popularity }

Future<dynamic> sortFilterDialog({required BuildContext context}) {
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
          child: Wrap(
            children: [SortFilter(context: context)],
          ),
        );
      });
}

class SortFilter extends StatefulWidget {
  BuildContext context;

  SortFilter({super.key, required BuildContext this.context});

  @override
  State<SortFilter> createState() => _SortFilterState(context: this.context);
}

class _SortFilterState extends State<SortFilter> {
  late SortCriteria? sortCriteria;

  _SortFilterState({required BuildContext context}) {
    sortCriteria =
        Provider.of<SearchNotifier>(context, listen: false).getSortCriteria;
  }

  @override
  void initState() {
    super.initState();
  }

  Widget getSortButton(
      {required BuildContext context,
      required String caption,
      required Function onTapFunction,
      required bool coloredBorder}) {
    Color? borderColor = null;
    if (coloredBorder) {
      borderColor = Theme.of(context).colorScheme.primary;
    } else {
      borderColor = Theme.of(context).highlightColor;
    }
    return Padding(
      padding: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () => onTapFunction(),
        child: Container(
          // margin: EdgeInsets.only(right: 12.h, left: 20.h ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.h),
            border: Border.all(color: borderColor),
          ),

          child: Padding(
            padding: EdgeInsets.all(7.h),
            child: getCustomFont(
              text: caption,
              fontSize: 14.sp,
              maxLine: 1,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  bool determineEnabled({required SortCriteria sortCriteria}) {
    if (sortCriteria ==
        Provider.of<SearchNotifier>(context, listen: false).getSortCriteria) {
      return true;
    } else {
      return false;
    }
  }

  Function getSortFunction({required SortCriteria sortCriteria}) {
    if (sortCriteria ==
        Provider.of<SearchNotifier>(context, listen: false).getSortCriteria) {
      return () => {
            setState(() {
              this.sortCriteria = null;
              Provider.of<SearchNotifier>(context, listen: false)
                  .changeSortCriteria(sortCriteria: null);
            })
          };
    } else {
      return () => {
            setState(() {
              this.sortCriteria = sortCriteria;
              Provider.of<SearchNotifier>(context, listen: false)
                  .changeSortCriteria(sortCriteria: sortCriteria);
            })
          };
    }
  }

  List<Widget> getTimeButtons({required BuildContext context}) {
    List<Widget> sortButtons = [
      getSortButton(
          context: context,
          caption: AppLocalizations.of(context)!.priceRising,
          onTapFunction: getSortFunction(sortCriteria: SortCriteria.price),
          coloredBorder: determineEnabled(sortCriteria: SortCriteria.price)),
      getSortButton(
          context: context,
          caption: AppLocalizations.of(context)!.dateRising,
          onTapFunction: getSortFunction(sortCriteria: SortCriteria.date),
          coloredBorder: determineEnabled(sortCriteria: SortCriteria.date)),
      getSortButton(
          context: context,
          caption: AppLocalizations.of(context)!.popularity,
          onTapFunction: getSortFunction(sortCriteria: SortCriteria.popularity),
          coloredBorder:
              determineEnabled(sortCriteria: SortCriteria.popularity)),
    ];
    return sortButtons;
  }

  @override
  Widget build(BuildContext context) {
    bool closeDialog =
        Provider.of<SearchNotifier>(context, listen: false).getIsCloseDialog();
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [CloseButton()])),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: getTimeButtons(context: context),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: getShowResultsButton(
              context: context,
              functionAccept:
                  Provider.of<SearchNotifier>(context, listen: false)
                      .changeSortCriteria,
              functionArgumentsAccept: {#sortCriteria: sortCriteria},
              functionReset:
                  Provider.of<SearchNotifier>(context, listen: false).resetSort,
              functionArgumentsReset: {},
              closeDialog: closeDialog),
        )
      ],
    );
  }
}

String getSortCaption({required BuildContext context}) {
  SortCriteria? sortCriteria =
      Provider.of<SearchNotifier>(context, listen: false).getSortCriteria;
  if (sortCriteria != null) {
    return getCaptionForSortCriteria(
        sortCriteria: sortCriteria, context: context);
  } else {
    return AppLocalizations.of(context)!.sort;
  }
}

String getCaptionForSortCriteria(
    {required SortCriteria sortCriteria, required BuildContext context}) {
  Map sortCriteriaMap = {
    SortCriteria.popularity: AppLocalizations.of(context)!.popularity,
    SortCriteria.date: AppLocalizations.of(context)!.dateRising,
    SortCriteria.price: AppLocalizations.of(context)!.priceRising,
  };
  return sortCriteriaMap[sortCriteria];
}
