import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:othia/widgets/filter_related/notifiers/abstract_query_notifier.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

import '../../utils/services/data_handling/data_handling.dart';
import 'get_reset_apply_filter.dart';

// TODO clear (extern) solve that button are only selected after the second click, this issue was not there when we first implemented this feature. This also causes that time ranges can only be selected by holding, instead of clicking on a start date and then end date. Also make it possible to insert a date via the keyboard (make sure to enforce that the user input is transferable to datetime) and show the range highlighted in the calendar
// TODO clear (extern) when selecting "Next Week" and the next week begins in the next month, it is not highlighted as it should be when going to the next month view. Selecting fields directly in the calendar is also not possible as it is only updated in visual term but does not update the notifier
Future<dynamic> TimeFilterDialog(
    {required BuildContext context,
    required AbstractQueryNotifier dynamicProvider}) {
  return showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      isScrollControlled: true,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      context: context,
      builder: (_) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: dynamicProvider,
            )
          ],
          child: Wrap(children: [
            TimeFilter(
              dynamicProvider: dynamicProvider,
            )
          ]),
        );
      });
}

class TimeFilter extends StatefulWidget {
  AbstractQueryNotifier dynamicProvider;

  TimeFilter({super.key, required this.dynamicProvider});

  @override
  State<TimeFilter> createState() =>
      _TimeFilterState(dynamicProvider: this.dynamicProvider);
}

class _TimeFilterState extends State<TimeFilter> {
  AbstractQueryNotifier dynamicProvider;
  DateTime? startDate;
  DateTime? endDate;
  bool todayButtonEnabled = false;
  bool tomorrowButtonEnabled = false;
  bool thisWeekendButtonEnabled = false;
  bool thisWeekButtonEnabled = false;
  bool nextWeekButtonEnabled = false;
  bool nextWeekendButtonEnabled = false;
  DateRangePickerController _dateRangePickerController =
      DateRangePickerController();

  _TimeFilterState({required this.dynamicProvider});

  @override
  void initState() {
    startDate = dynamicProvider.startDate;
    endDate = dynamicProvider.endDate;
    super.initState();
  }

  // void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
  //  if (args.value is PickerDateRange) {
  //       startDate = args.value.startDateTime;
  //       endDate = args.value.endDateUtc ?? args.value.startDateTime;
  //       thisWeekendButtonEnabled = false;
  //       todayButtonEnabled = false;
  //       tomorrowButtonEnabled = false;
  //       thisWeekButtonEnabled = false;
  //       nextWeekButtonEnabled = false;
  //       nextWeekendButtonEnabled = false;
  //       dynamicProvider.setTimeCaption(caption: null);
  //     } else if (args.value is DateTime) {
  //       print("qaiser ");
  //     }
  // }

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

  Widget getTimeButton({required BuildContext context,
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
            child: Text(caption),
          ),
        ),
      ),
    );
  }

  List<Widget> getTimeButtons({required BuildContext context}) {
    List<Widget> timeButtons = [
      getTimeButton(
          context: context,
          caption: AppLocalizations.of(context)!.today,
          onTapFunction: getTodayFunction(),
          coloredBorder: todayButtonEnabled),
      getTimeButton(
          context: context,
          caption: AppLocalizations.of(context)!.tomorrow,
          onTapFunction: getTomorrowFunction(),
          coloredBorder: tomorrowButtonEnabled),
      getTimeButton(
          context: context,
          caption: AppLocalizations.of(context)!.thisWeek,
          onTapFunction: getThisWeekFunction(),
          coloredBorder: thisWeekButtonEnabled),
      getTimeButton(
          context: context,
          caption: AppLocalizations.of(context)!.thisWeekend,
          onTapFunction: getThisWeekendFunction(),
          coloredBorder: thisWeekendButtonEnabled),
      getTimeButton(
          context: context,
          caption: AppLocalizations.of(context)!.nextWeek,
          onTapFunction: getNextWeekFunction(),
          coloredBorder: nextWeekButtonEnabled),
      getTimeButton(
          context: context,
          caption: AppLocalizations.of(context)!.nextWeekend,
          onTapFunction: getNextWeekendFunction(),
          coloredBorder: nextWeekendButtonEnabled),
    ];
    return timeButtons;
  }

   getTodayFunction() {
    if (todayButtonEnabled) {
      return () => {
        setState(() {
          startDate = dynamicProvider.defaultStartDate;
          endDate = dynamicProvider.defaultEndDate;
          _dateRangePickerController.selectedRange =
              PickerDateRange(startDate, endDate);
          todayButtonEnabled = false;
          dynamicProvider.setTimeCaption(caption: null);
        })
      };
    } else {
      return () => {
        setState(() {
          startDate = DateTime.now();
          endDate = DateTime.now();
          _dateRangePickerController.selectedRange =
              PickerDateRange(startDate, endDate);
          todayButtonEnabled = true;
          tomorrowButtonEnabled = false;
          thisWeekendButtonEnabled = false;
          thisWeekButtonEnabled = false;
          nextWeekButtonEnabled = false;
          nextWeekendButtonEnabled = false;
          dynamicProvider.setTimeCaption(caption: AppLocalizations.of(context)!.today);
        }),
      };
    }
  }

 getTomorrowFunction() {
    if (tomorrowButtonEnabled) {
      return () => {
        setState(() {
          startDate = dynamicProvider.defaultStartDate;
          endDate = dynamicProvider.defaultEndDate;
          _dateRangePickerController.selectedRange =
              PickerDateRange(startDate, endDate);
          tomorrowButtonEnabled = false;
          dynamicProvider.setTimeCaption(caption: null);
        })
      };
    } 
    else {
      return () => {
        setState(() {
          startDate = DateTime.now().add(Duration(days: 1));
          endDate = DateTime.now().add(Duration(days: 1));
          _dateRangePickerController.selectedRange =
              PickerDateRange(startDate, endDate);
          tomorrowButtonEnabled = true;
          todayButtonEnabled = false;
          thisWeekendButtonEnabled = false;
          thisWeekButtonEnabled = false;
          nextWeekButtonEnabled = false;
          nextWeekendButtonEnabled = false;
          dynamicProvider.setTimeCaption(
              caption: AppLocalizations.of(context)!.tomorrow);
        }),
      };
    }
  }

  Function getThisWeekendFunction() {
    DateTime now = DateTime.now();
    int currentWeekday = now.weekday;
    if (currentWeekday == 7) {
      return () => {
        setState(() {
          startDate = now;
          endDate = now;
          _dateRangePickerController.selectedRange =
              PickerDateRange(startDate, endDate);
          thisWeekendButtonEnabled = true;
          todayButtonEnabled = false;
          tomorrowButtonEnabled = false;
          thisWeekButtonEnabled = false;
          nextWeekButtonEnabled = false;
          nextWeekendButtonEnabled = false;
          dynamicProvider.setTimeCaption(caption: AppLocalizations.of(context)!.today);
        })
      };
    }
    DateTime saturday =
    now.subtract(Duration(days: currentWeekday)).add(Duration(days: 6));
    if (thisWeekendButtonEnabled) {
      return () => {
        setState(() {
          startDate = dynamicProvider.defaultStartDate;
          endDate = dynamicProvider.defaultEndDate;
          _dateRangePickerController.selectedRange =
              PickerDateRange(startDate, endDate);
          thisWeekendButtonEnabled = false;
          dynamicProvider.setTimeCaption(caption: null);
        })
      };
    } else {
      return () => {
        setState(() {
          startDate = saturday;
          endDate = saturday.add(Duration(days: 1));
          _dateRangePickerController.selectedRange =
              PickerDateRange(startDate, endDate);
          thisWeekendButtonEnabled = true;
          todayButtonEnabled = false;
          tomorrowButtonEnabled = false;
          thisWeekButtonEnabled = false;
          nextWeekButtonEnabled = false;
          nextWeekendButtonEnabled = false;
          dynamicProvider.setTimeCaption(
              caption: AppLocalizations.of(context)!.thisWeekend);
        }),
      };
    }
  }

  Function getThisWeekFunction() {
    DateTime now = DateTime.now();
    int currentWeekday = now.weekday;
    DateTime sunday =
    now.subtract(Duration(days: currentWeekday)).add(Duration(days: 7));
    if (thisWeekButtonEnabled) {
      return () => {
        setState(() {
          startDate = dynamicProvider.defaultStartDate;
          endDate = dynamicProvider.defaultEndDate;
          _dateRangePickerController.selectedRange =
              PickerDateRange(startDate, endDate);
          thisWeekButtonEnabled = false;
          dynamicProvider.setTimeCaption(caption: null);
        })
      };
    } else {
      return () => {
        setState(() {
          startDate = now;
          endDate = sunday;
          _dateRangePickerController.selectedRange =
              PickerDateRange(startDate, endDate);
          thisWeekendButtonEnabled = false;
          todayButtonEnabled = false;
          tomorrowButtonEnabled = false;
          thisWeekButtonEnabled = true;
          nextWeekButtonEnabled = false;
          nextWeekendButtonEnabled = false;
          dynamicProvider.setTimeCaption(
              caption: AppLocalizations.of(context)!.thisWeek);
        }),
      };
    }
  }

  Function getNextWeekFunction() {
    DateTime now = DateTime.now();
    int currentWeekday = now.weekday;
    DateTime nextMonday =
    now.subtract(Duration(days: currentWeekday)).add(Duration(days: 8));
    if (nextWeekButtonEnabled) {
      return () => {
        setState(() {
          startDate = dynamicProvider.defaultStartDate;
          endDate = dynamicProvider.defaultEndDate;
          _dateRangePickerController.selectedRange =
              PickerDateRange(startDate, endDate);
          nextWeekButtonEnabled = false;
          dynamicProvider.setTimeCaption(caption: null);
        })
      };
    } else {
      return () => {
        setState(() {
          startDate = nextMonday;
          endDate = nextMonday.add(Duration(days: 6));
          _dateRangePickerController.selectedRange =
              PickerDateRange(startDate, endDate);
          thisWeekendButtonEnabled = false;
          todayButtonEnabled = false;
          tomorrowButtonEnabled = false;
          thisWeekButtonEnabled = false;
          nextWeekButtonEnabled = true;
          nextWeekendButtonEnabled = false;
          dynamicProvider.setTimeCaption(
              caption: AppLocalizations.of(context)!.nextWeek);
        }),
      };
    }
  }

  Function getNextWeekendFunction() {
    DateTime now = DateTime.now();
    int currentWeekday = now.weekday;
    DateTime nextSaturday =
    now.subtract(Duration(days: currentWeekday)).add(Duration(days: 13));
    if (nextWeekendButtonEnabled) {
      return () => {
        setState(() {
          startDate = dynamicProvider.defaultStartDate;
          endDate = dynamicProvider.defaultEndDate;
          _dateRangePickerController.selectedRange =
              PickerDateRange(startDate, endDate);
          nextWeekendButtonEnabled = false;
          dynamicProvider.setTimeCaption(caption: null);
        })
      };
    } else {
      return () => {
        setState(() {
          startDate = nextSaturday;
          endDate = nextSaturday.add(Duration(days: 1));
          _dateRangePickerController.selectedRange =
              PickerDateRange(startDate, endDate);
          thisWeekendButtonEnabled = false;
          todayButtonEnabled = false;
          tomorrowButtonEnabled = false;
          thisWeekButtonEnabled = false;
          nextWeekButtonEnabled = false;
          nextWeekendButtonEnabled = true;
          dynamicProvider.setTimeCaption(
              caption: AppLocalizations.of(context)!.nextWeekend);
        }),
      };
    }
  }

  void setToDefault() {
    setState(() {
      startDate = dynamicProvider.getStartDate;
      endDate = dynamicProvider.getEndDate;
      _dateRangePickerController.selectedRange =
          PickerDateRange(startDate, endDate);
      thisWeekendButtonEnabled = false;
      todayButtonEnabled = false;
      tomorrowButtonEnabled = false;
      thisWeekButtonEnabled = false;
      nextWeekButtonEnabled = false;
      nextWeekendButtonEnabled = false;
      dynamicProvider.setTimeCaption(caption: null);
    });
  }

  // callback fucniton for onselect on datepicker
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    // TODO: implement your code here
    print(args.value.startDate);
    DateTime d=args.value.startDate;
    print(d.toString());
    String _startDate =
        DateFormat('dd.MM.yyyy').format(args.value.startDate);
    String _endDate =
        DateFormat('dd.MM.yyyy').format(args.value.endDate ?? args.value.startDate).toString();
   // startDate=DateTime.parse(_startDate);

    setState(() {
      thisWeekendButtonEnabled = false;
      todayButtonEnabled = false;
      tomorrowButtonEnabled = false;
      thisWeekButtonEnabled = false;
      nextWeekButtonEnabled = false;
      nextWeekendButtonEnabled = false;
      startDate=args.value.startDate;
      endDate=args.value.endDate;
      _dateRangePickerController.selectedRange =
          PickerDateRange(args.value.startDate, args.value.endDate);
    });

    print("DAte: "+_startDate);
    print("End DAte: "+_endDate);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AbstractQueryNotifier>(builder: (context, model, child) {
      if (model.dateReset) {
        Future.delayed(Duration.zero, () async {
          setToDefault();
        });

        dynamicProvider.setDateResetFalse();
      }
      ;
      return Column(children: [
        Padding(
            padding: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [CloseButton()])),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: SfDateRangePicker(
            // on selectedcallbackfunction
            onSelectionChanged: _onSelectionChanged,
            monthViewSettings: DateRangePickerMonthViewSettings(
              firstDayOfWeek: 1,
            ),
            // marking weekend dates not enabled right now
            // monthCellStyle: DateRangePickerMonthCellStyle(weekendDatesDecoration: BoxDecoration(border: Border(bottom: BorderSide(color: Theme.of(context).highlightColor)) ),),
            // onSelectionChanged: _onSelectionChanged,
            selectionMode: DateRangePickerSelectionMode.range,
            selectableDayPredicate: predicateCallback,
            controller: _dateRangePickerController,
            initialSelectedRange: PickerDateRange(startDate, endDate),
          ),
        ),
        // TODO clear (extern)  fix that buttons are aligned on the left side like the rest
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            children: getTimeButtons(context: context),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Divider(thickness: 3),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                      dynamicProvider.endDate),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: getShowResultsButton(
              context: context,
              functionAccept:
              dynamicProvider.changeStartEndDate,
              functionArgumentsAccept: {
                #startDate: startDate,
                #endDate: endDate
              },
              functionReset: dynamicProvider.resetStartEndDate,
              functionArgumentsReset: {},
              closeDialog: true),
        )
      ]);
    });
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

String getTimeCaption(
    {required BuildContext context,
    required AbstractQueryNotifier dynamicProvider}) {
  if (dynamicProvider.timeFilterActivated) {
    DateTime startDate = dynamicProvider.getStartDate;
    DateTime endDate = dynamicProvider.getEndDate;
    String? caption = dynamicProvider.getTimeCaption;
    if (caption != null) {
      return caption;
    } else {
      if (endDate == startDate) {
        return startDate.day.toString() +
            ". " +
            getMonthName(context: context, month: startDate.month);
      } else {
        return startDate.day.toString() +
            ". " +
            getMonthName(context: context, month: startDate.month) +
            " - " +
            endDate.day.toString() +
            ". " +
            getMonthName(context: context, month: endDate.month);
      }
    }
  } else {
    return AppLocalizations.of(context)!.time;
  }
}
