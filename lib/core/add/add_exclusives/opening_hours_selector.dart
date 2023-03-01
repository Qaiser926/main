import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/core/add/add_exclusives/help_functions.dart';
import 'package:othia/utils/services/data_handling/data_handling.dart';
import 'package:othia/utils/services/global_navigation_notifier.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:othia/widgets/openingtimes.dart';
import 'package:provider/provider.dart';

import 'input_notifier.dart';

class OpeningHoursSelector extends StatelessWidget {
  AddEANotifier inputNotifier;
  BuildContext context;
  late Map openingTime;

  OpeningHoursSelector({required this.inputNotifier, required this.context});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddEANotifier>(builder: (context, inputConsumer, child) {
      openingTime = inputConsumer.detailedEA.time.openingTime!;
      return OpeningTimes(
        openingTime: openingTime,
        isChangeable: true,
      );
    });
  }
}

dynamic getEditOpeningTimeButton(
    {required int weekDay, required BuildContext context}) {
  return Row(
    children: [
      getHorSpace(8.h),
      GestureDetector(
        onTap: () =>
            {openingTimesDialog(context: context, activatedWeekday: weekDay)},
        child: Icon(Icons.edit_outlined),
      )
    ],
  );
}

Future<dynamic> openingTimesDialog(
    {required BuildContext context, required int activatedWeekday}) {
  Provider.of<AddEANotifier>(context, listen: false).activatedWeekDay =
      activatedWeekday;
  Provider.of<GlobalNavigationNotifier>(context, listen: false).isDialogOpen =
      true;
  return showDialog(
      context: context,
      builder: (_) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: Provider.of<AddEANotifier>(context, listen: false),
            )
          ],
          child:
              Consumer<AddEANotifier>(builder: (context, inputNotifier, child) {
            return Dialog(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8.h),
                  child: Column(
                    children: [
                      Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(7, (weekDayIndex) {
                                return Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 4.h, top: 0, right: 4.h, bottom: 0),
                                  child: GestureDetector(
                                    onTap: () => {
                                      inputNotifier
                                          .activeWeekday(weekDayIndex + 1)
                                    },
                                    child: Text(
                                      getWeekday(
                                          weekDayNumber: weekDayIndex + 1,
                                          context: context)[1],
                                      style: (weekDayIndex + 1) ==
                                              inputNotifier.activatedWeekDay
                                          ? TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary)
                                          : TextStyle(color: Colors.white),
                                      maxLines: 1,
                                    ),
                                  ),
                                ));
                              }))),
                      getVerSpace(10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.end,
                            // alignment: WrapAlignment.center,
                            children: [
                              getSpecialOpeningTimeButton(
                                  context: context,
                                  caption:
                                      AppLocalizations.of(context)!.alwaysOpen,
                                  coloredBorder: inputNotifier.isAlwaysOpen(),
                                  onTapFunction: () =>
                                      {inputNotifier.alwaysOpenOnWeekDay()}),
                              getSpecialOpeningTimeButton(
                                  context: context,
                                  caption: AppLocalizations.of(context)!.closed,
                                  coloredBorder: inputNotifier.isClosed(),
                                  onTapFunction: () =>
                                      {inputNotifier.closedOnWeekDay()})
                            ],
                          )
                        ],
                      ),
                      getVerSpace(5.h),
                      buildOpeningTimeBoxes(
                          context: context, inputNotifier: inputNotifier),
                      Padding(
                        padding: EdgeInsets.all(5.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () {
                                inputNotifier.addHours();
                              },
                              child:
                                  Text(AppLocalizations.of(context)!.addHours),
                            )
                          ],
                        ),
                      ),
                      getVerSpace(10.h),
                      Padding(
                        padding: EdgeInsets.all(5.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                inputNotifier.deleteNullOpeningTimes();
                                Navigator.pop(context);
                              },
                              child: Text(AppLocalizations.of(context)!.cancel),
                            ),
                            GestureDetector(
                              onTap: () {
                                inputNotifier.deleteNullOpeningTimes();
                                Navigator.pop(context);
                              },
                              child:
                                  Text(AppLocalizations.of(context)!.confirm),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      }).then((_) {
    Provider.of<AddEANotifier>(context, listen: false).deleteNullOpeningTimes();
    Provider.of<GlobalNavigationNotifier>(context, listen: false).isDialogOpen =
        false;
  });
}

Widget getSpecialOpeningTimeButton(
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
          child: Text(caption),
        ),
      ),
    ),
  );
}

Widget buildOpeningTimeBoxes(
    {required BuildContext context, required AddEANotifier inputNotifier}) {
  return Container(
    width: double.maxFinite,
    child: ListView.builder(
        shrinkWrap: true,
        itemCount: inputNotifier
                .detailedEA
                .time
                .openingTime![inputNotifier.activatedWeekDay.toString()]
                ?.length ??
            0,
        itemBuilder: (BuildContext context, int index) {
          List openingTimes = inputNotifier.getOpeningTimesList()[index];
          if ((openingTimes[0] == 0) & (openingTimes[1] == 0)) {
            return SizedBox();
          } else {
            return Padding(
              padding: EdgeInsets.all(5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => {
                      displayTimePicker(
                          inputNotifier: inputNotifier,
                          context: context,
                          listIndex: index,
                          isStartingTime: true)
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.h),
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary)),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5.h),
                            child:
                                Text(AppLocalizations.of(context)!.openingTime),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5.h),
                            child: Text(formatTime(
                              unformattedTime: openingTimes[0],
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      displayTimePicker(
                          inputNotifier: inputNotifier,
                          context: context,
                          listIndex: index,
                          isStartingTime: false)
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.h),
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary)),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5.h),
                            child:
                                Text(AppLocalizations.of(context)!.closingTime),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5.h),
                            child: Text(formatTime(
                              unformattedTime: openingTimes[1],
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      inputNotifier
                          .detailedEA
                          .time
                          .openingTime![
                              inputNotifier.activatedWeekDay.toString()]!
                          .removeAt(index),
                      inputNotifier.notifyListeners(),
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10.h),
                      child: Icon(Icons.close),
                    ),
                  )
                ],
              ),
            );
          }
        }),
  );
}

Future displayTimePicker(
    {required bool isStartingTime,
    required BuildContext context,
    required AddEANotifier inputNotifier,
    required int listIndex}) async {
  // for closing time, start at start time, for start time just anything
  TimeOfDay initialTime = getInitialTimeOfDay(
      inputNotifier: inputNotifier,
      isStartingTime: isStartingTime,
      listIndex: listIndex);
  var time = await showTimePicker(
    context: context,
    initialTime: initialTime,
  );
  if (time != null) {
    double transformedTime = transformTimeOfDayToDouble(time);
    if (isStartingTime) {
      inputNotifier.getOpeningTimesList()[listIndex][0] = transformedTime;
    } else {
      if (inputNotifier.getOpeningTimesList()[listIndex][0] > transformedTime) {
        getInfoDialog(
            heading:
                Text(AppLocalizations.of(context)!.openingHoursErrorMessage),
            context: context);
      } else {
        // getOpeningTimesList() directly returns the list for the correct weekday
        List openingTimes = inputNotifier.getOpeningTimesList();
        openingTimes[listIndex][1] = transformedTime;
        // loop through list to remove 24h open hour case
        for (var i = 0; i < openingTimes.length; i++) {
          if ((openingTimes[i]![0] == 0) | (openingTimes[i]![1] == 0)) {
            openingTimes.removeAt(i);
          }
        }
      }
    }
    inputNotifier.notifyListeners();
  }
}

double transformTimeOfDayToDouble(TimeOfDay time) {
  return (time.hour * 100 + time.minute).toDouble();
}

TimeOfDay transformDoubleToTimeOfDay(double time) {
  String formattedTime = time.toInt().toString().padLeft(4, '0');
  return TimeOfDay(
      hour: int.parse(formattedTime.substring(0, 2)),
      minute: int.parse(formattedTime.substring(2, 4)));
}

TimeOfDay getInitialTimeOfDay(
    {required bool isStartingTime,
    required AddEANotifier inputNotifier,
    required int listIndex}) {
  if (isStartingTime) {
    return transformDoubleToTimeOfDay(
        inputNotifier.getOpeningTimesList()[listIndex]?[0] ?? 900);
  } else {
    if (inputNotifier.getOpeningTimesList()[listIndex]?[1] != null) {
      return transformDoubleToTimeOfDay(
          inputNotifier.getOpeningTimesList()[listIndex]?[1] ?? 1700);
    } else {
      return transformDoubleToTimeOfDay(
          inputNotifier.getOpeningTimesList()[listIndex]?[0] ?? 1700);
    }
  }
}
