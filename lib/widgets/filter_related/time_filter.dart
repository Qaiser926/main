import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:othia/widgets/filter_related/search_notifier.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

import 'get_reset_apply_filter.dart';

class TimeFilter extends StatefulWidget {
  TimeFilter({super.key});

  @override
  State<TimeFilter> createState() => _TimeFilterState();
}

class _TimeFilterState extends State<TimeFilter> {
  String? _dateCount;
  String? _range;
  DateTime? startDate;
  DateTime? endDate;
  DateRangePickerController _dateRangePickerController =
      DateRangePickerController();

  @override
  void initState() {
    // Provider.of<SearchNotifier>(context, listen: false).getPriceRange
    _dateCount = '';
    _range = '';
    super.initState();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range =
            DateFormat('dd/MM/yyyy').format(args.value.startDate).toString() +
                ' - ' +
                DateFormat('dd/MM/yyyy')
                    .format(args.value.endDate ?? args.value.startDate)
                    .toString();
        startDate = args.value.startDate;
        endDate = args.value.endDate ?? args.value.startDate;
      } else if (args.value is DateTime) {
        print(1);
      } else if (args.value is List<DateTime>) {
        print(2);
        _dateCount = args.value.length.toString();
      }
    });
  }

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  bool predicateCallback(DateTime date) {
    if (calculateDifference(date) < 0) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: EdgeInsets.all(20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [CloseButton()])),
      Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
        child: SfDateRangePicker(
          monthViewSettings: DateRangePickerMonthViewSettings(
            firstDayOfWeek: 1,
          ),
          // marking weekend dates not enabled right now
          // monthCellStyle: DateRangePickerMonthCellStyle(weekendDatesDecoration: BoxDecoration(border: Border(bottom: BorderSide(color: Theme.of(context).highlightColor)) ),),
          onSelectionChanged: _onSelectionChanged,
          selectionMode: DateRangePickerSelectionMode.range,
          selectableDayPredicate: predicateCallback,
          controller: _dateRangePickerController,
          // TODO define differently
          initialSelectedRange: PickerDateRange(startDate ?? DateTime.now(),
              endDate ?? DateTime.now().add(const Duration(days: 1))),
        ),
      ),
      SizedBox(
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
      ),
      TextButton(
          onPressed: () => {
                setState(() {
                  startDate = DateTime.now().add(const Duration(days: 1));
                  endDate = DateTime.now().add(const Duration(days: 5));
                  _dateRangePickerController.selectedRange =
                      PickerDateRange(startDate, endDate);
                }),
                print("test button pressed")
              },
          child: Text("test")),
      Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getTimeBox(
                context: context,
                header: AppLocalizations.of(context)!.from,
                time: startDate ?? DateTime.now()),
            Icon(Typicons.minus, color: Theme.of(context).highlightColor),
            getTimeBox(
                context: context,
                header: AppLocalizations.of(context)!.to,
                time: endDate ??
                    Provider.of<SearchNotifier>(context, listen: false)
                        .endDate),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.all(20),
        child: getShowResultsButton(
            context: context,
            function: Provider.of<SearchNotifier>(context, listen: false)
                .changeStartEndDate,
            functionArguments: {#startDate: startDate, #endDate: endDate}),
      )
    ]);
  }
}

Widget getTimeBox(
    {required BuildContext context,
    required String header,
    required DateTime time}) {
  return Container(
    width: 110,
    decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).highlightColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(12))),
    padding: EdgeInsets.all(8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(header),
        getVerSpace(5),
        Text(DateFormat('dd.MM.yyyy').format(time).toString())
      ],
    ),
  );
}

// TODO
String getTimeCaption({required BuildContext context}) {
  if (Provider.of<SearchNotifier>(context, listen: false)
      .priceFilterActivated) {
    RangeValues range =
        Provider.of<SearchNotifier>(context, listen: false).getPriceRange;
    if (range.start == range.end) {
      if (range.start == 0) {
        return AppLocalizations.of(context)!.free;
      } else {
        return "€${range.start}";
      }
    }
    return "€${range.start.round()} - €${range.end.round()}";
  } else {
    return AppLocalizations.of(context)!.price;
  }
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

  return filter;
}