import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/core/add/add_exclusives/help_functions.dart';
import 'package:othia/utils/helpers/diverse.dart';
import 'package:othia/utils/services/data_handling/data_handling.dart';
import 'package:othia/utils/services/global_navigation_notifier.dart';
import 'package:provider/provider.dart';

import 'input_notifier.dart';

enum DateType {
  StartDate,
  EndDate,
}

class TimeSelector extends StatelessWidget {
  AddEANotifier inputNotifier;
  BuildContext context;

  TimeSelector({required this.inputNotifier, required this.context});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddEANotifier>(
        builder: (context, inputNotifierConsumer, child) {
      String? _validateStartTime(String? text) {
        if (inputNotifierConsumer.detailedEA.time.startTimeUtc == null) {
          return AppLocalizations.of(context)!.startTimeErrorMessage;
        }
        return null;
      }

      bool showStartTime = false;
      if (inputNotifierConsumer.detailedEA.time.startTimeUtc != null) {
        showStartTime = true;
      }
      bool showEndTime = false;
      if (inputNotifier.detailedEA.time.endTimeUtc != null) showEndTime = true;
      bool endTimeSelectable =
          inputNotifier.detailedEA.time.startTimeUtc != null;

      return Column(
        children: [
          Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  dismissKeyboard();
                  inputNotifier.timeFormKey.currentState?.reset();
                  pickDateTime(DateType.StartDate);
                },
                child: IgnorePointer(
                  child: TextFormField(
                      // TODO clear (extern) align color such that it has the same color as the other TextFormFields. The reason for the color difference is that we use a TextController here, whereas we just use the text form field elsewhere.
                      style:
                          TextStyle(color: Theme.of(context).selectedRowColor),
                      controller: TextEditingController(
                        
                        text: showStartTime
                            ? "${AppLocalizations.of(context)!.startTime}: ${getLocalTimeString(context: context, dateTimeUtc: inputNotifierConsumer.detailedEA.time.startTimeUtc!)}"
                            : AppLocalizations.of(context)!.startTimeHint,
                      ),
                      
                      validator: _validateStartTime,
                      decoration: new InputDecoration(
                        hintStyle:
                            TextStyle(color: Theme.of(context).highlightColor),
                        contentPadding: EdgeInsets.all(5.h),
                        border: OutlineInputBorder(),
                      )),
                ),
              )),
         
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () async {
                dismissKeyboard();
                if (endTimeSelectable) {
                  pickDateTime(DateType.EndDate);
                } else {
                  getInfoDialog(
                      heading: Text(
                          "Please select a start time before selecting an end time"),
                      context: context);
                }
              },
              child: IgnorePointer(
                child: TextFormField(
                  // TODO clear (extern) align color such that it has the same color as the other TextFormFields
                    style:
                        TextStyle(color: Theme.of(context).selectedRowColor),
                    controller: TextEditingController(
                      text: showEndTime
                          ? "${AppLocalizations.of(context)!.endTime}: ${getLocalTimeString(context: context, dateTimeUtc: inputNotifierConsumer.detailedEA.time.endTimeUtc!)}"
                          : AppLocalizations.of(context)!.endTimeHint,
                    ),
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.all(5.h),
                      border: OutlineInputBorder(),
                    )),
              ),
            ),
          ),
        ],
      );
    });
  }

  Future pickDateTime(DateType dateType) async {
    DateTime? date = await displayDatePicker(dateType);
    if (date != null) {
      await displayTimePicker(dateType);
    }
  }

  TimeOfDay getInitialTimeOfDay(DateType dateType) {
    if (dateType == DateType.StartDate) {
      return TimeOfDay(
          hour: getLocalDateTime(
                      dateTimeUtc: inputNotifier.detailedEA.time.startTimeUtc)
                  ?.hour ??
              DateTime.now().hour,
          minute: getLocalDateTime(
                      dateTimeUtc: inputNotifier.detailedEA.time.startTimeUtc)
                  ?.minute ??
              DateTime.now().minute);
    } else {
      if (inputNotifier.detailedEA.time.endTimeUtc != null) {
        return TimeOfDay(
            hour: getLocalDateTime(
                        dateTimeUtc: inputNotifier.detailedEA.time.endTimeUtc)
                    ?.hour ??
                DateTime.now().hour,
            minute: getLocalDateTime(
                        dateTimeUtc: inputNotifier.detailedEA.time.endTimeUtc)
                    ?.minute ??
                DateTime.now().minute);
      } else {
        return TimeOfDay(
            hour: getLocalDateTime(
                        dateTimeUtc: inputNotifier.detailedEA.time.startTimeUtc)
                    ?.hour ??
                DateTime.now().hour,
            minute: getLocalDateTime(
                        dateTimeUtc: inputNotifier.detailedEA.time.startTimeUtc)
                    ?.minute ??
                DateTime.now().minute);
      }
    }
  }

  Future displayTimePicker(DateType dateType) async {
    TimeOfDay initialTime = getInitialTimeOfDay(dateType);
    Provider.of<GlobalNavigationNotifier>(context, listen: false).isDialogOpen =
        true;
    var time = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    Provider.of<GlobalNavigationNotifier>(context, listen: false).isDialogOpen =
        false;
    if (time != null) {
      DateTime completeDateTime;
      if (dateType == DateType.StartDate) {
        completeDateTime = getLocalDateTime(
            dateTimeUtc: inputNotifier.detailedEA.time.startTimeUtc)!;
      } else {
        completeDateTime = getLocalDateTime(
            dateTimeUtc: inputNotifier.detailedEA.time.endTimeUtc)!;
      }
      completeDateTime = completeDateTime
          .add(Duration(hours: time.hour, minutes: time.minute));
      if (dateType == DateType.StartDate) {
        // here the local set time is transformed to UTC and then toString via the getUTCTimeString function
        inputNotifier.detailedEA.time.startTimeUtc =
            getUTCTimeString(localDateTime: completeDateTime);
        inputNotifier.resetEndDateTime();
      } else {
        // case when end time is set, user always sets local time
        if (completeDateTime.isBefore(getLocalDateTime(
            dateTimeUtc: inputNotifier.detailedEA.time.startTimeUtc)!)) {
          inputNotifier.resetEndDateTime();
          getInfoDialog(
              heading: Text(
                  AppLocalizations.of(context)!.endTimeBeforeStartErrorMessage),
              context: context);
        } else {
          inputNotifier.detailedEA.time.endTimeUtc =
              getUTCTimeString(localDateTime: completeDateTime);
        }
      }
      inputNotifier.notifyListeners();
    }
  }

  Future<DateTime?> displayDatePicker(DateType dateType) async {
    DateTime firstDate = DateTime.now();
    // end date cannot be before start date, thus set end date accordingly
    if (dateType == DateType.EndDate) {
      firstDate = getLocalDateTime(
              dateTimeUtc: inputNotifier.detailedEA.time.startTimeUtc) ??
          DateTime.now();
    }
    // initialDate is the highlighted date in the picker. Per default it is set to the first possible date
    DateTime? initialDate = firstDate;
    if (dateType == DateType.StartDate) {
      initialDate = getLocalDateTime(
          dateTimeUtc: inputNotifier.detailedEA.time.startTimeUtc);
    } else {
      initialDate = getLocalDateTime(
              dateTimeUtc: inputNotifier.detailedEA.time.endTimeUtc) ??
          firstDate;
    }
    Provider.of<GlobalNavigationNotifier>(context, listen: false).isDialogOpen =
        true;
    var date = await showDatePicker(
      context: context,
      // TODO (extern) set locale user specific & align style
      // locale: const getCurrentLocale(),
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: DateTime(DateTime.now().year + 5),
      
    );

    Provider.of<GlobalNavigationNotifier>(context, listen: false).isDialogOpen =
        false;

    if (date != null) {
      if (dateType == DateType.StartDate) {
        inputNotifier.detailedEA.time.startTimeUtc =
            getUTCTimeString(localDateTime: date);
      } else {
        inputNotifier.detailedEA.time.endTimeUtc =
            getUTCTimeString(localDateTime: date);
      }
      return date;
    } else {
      return null;
    }
  }

}
