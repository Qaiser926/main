import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/core/add/add_exclusives/add_first_page.dart';
import 'package:othia/utils/services/data_handling/data_handling.dart';
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
        if (inputNotifierConsumer.startDateTime == null) {
          return 'A Start Time is missing';
        }
        return null;
      }

      bool showStartTime = false;
      if (inputNotifierConsumer.startDateTime != null) {
        showStartTime = true;
      }
      bool showEndTime = false;
      if (inputNotifier.endDateTime != null) showEndTime = true;
      bool endTimeSelectable = inputNotifier.startDateTime != null;

      return Column(
        children: [
          Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  inputNotifier.timeFormKey.currentState?.reset();
                  pickDateTime(DateType.StartDate);
                },
                child: IgnorePointer(
                  child: TextFormField(
                      // TODO align color such that it has the same color as the other TextFormFields
                      style:
                          TextStyle(color: Theme.of(context).bottomAppBarColor),
                      controller: TextEditingController(
                        text: showStartTime
                            ? "Start: ${getTimeText(context: context, localDateTime: inputNotifierConsumer.startDateTime!)}"
                            : "Select Start Time",
                      ),
                      validator: _validateStartTime,
                      decoration: new InputDecoration(
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
                if (endTimeSelectable) {
                  pickDateTime(DateType.EndDate);
                } else {
                  getInfoDialog(
                      info: "Please select a start date before",
                      context: context);
                }
              },
              child: IgnorePointer(
                child: TextFormField(
                    // TODO align color such that it has the same color as the other TextFormFields
                    style:
                        TextStyle(color: Theme.of(context).bottomAppBarColor),
                    controller: TextEditingController(
                      text: showEndTime
                          ? "End: ${getTimeText(context: context, localDateTime: inputNotifierConsumer.endDateTime!)}"
                          : "Select End Time",
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
          hour: inputNotifier.startDateTime?.hour ?? DateTime.now().hour,
          minute: inputNotifier.startDateTime?.minute ?? DateTime.now().minute);
    } else {
      if (inputNotifier.endDateTime != null) {
        return TimeOfDay(
            hour: inputNotifier.endDateTime?.hour ?? DateTime.now().hour,
            minute: inputNotifier.endDateTime?.minute ?? DateTime.now().minute);
      } else {
        return TimeOfDay(
            hour: inputNotifier.startDateTime?.hour ?? DateTime.now().hour,
            minute:
                inputNotifier.startDateTime?.minute ?? DateTime.now().minute);
      }
    }
  }

  Future displayTimePicker(DateType dateType) async {
    TimeOfDay initialTime = getInitialTimeOfDay(dateType);
    var time = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (time != null) {
      DateTime completeDateTime;
      if (dateType == DateType.StartDate) {
        completeDateTime = inputNotifier.startDateTime!;
      } else {
        completeDateTime = inputNotifier.endDateTime!;
      }
      completeDateTime = completeDateTime
          .add(Duration(hours: time.hour, minutes: time.minute));
      if (dateType == DateType.StartDate) {
        inputNotifier.startDateTime = completeDateTime;
        inputNotifier.resetEndDateTime();
      } else {
        if (completeDateTime.isBefore(inputNotifier.startDateTime!)) {
          inputNotifier.resetEndDateTime();
          getInfoDialog(
              info: 'End time cannot be before starting time',
              context: context);
        } else {
          inputNotifier.endDateTime = completeDateTime;
        }
      }
      inputNotifier.notifyListeners();
    }
  }

  Future<DateTime?> displayDatePicker(DateType dateType) async {
    DateTime firstDate = DateTime.now();
    if (dateType == DateType.EndDate) {
      firstDate = inputNotifier.startDateTime ?? DateTime.now();
    }
    DateTime? initialDate = DateTime.now();
    if (dateType == DateType.StartDate) {
      initialDate = inputNotifier.startDateTime;
    } else {
      initialDate = inputNotifier.endDateTime ?? firstDate;
    }

    var date = await showDatePicker(
      context: context,
      // TODO set locale user specific & align style
      // locale: const getCurrentLocale(),
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: DateTime(DateTime.now().year + 2),
    );

    if (date != null) {
      if (dateType == DateType.StartDate) {
        inputNotifier.startDateTime = date;
      } else {
        inputNotifier.endDateTime = date;
      }
      return date;
    } else {
      return null;
    }
  }
}
