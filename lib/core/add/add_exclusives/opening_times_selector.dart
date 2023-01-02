import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/utils/services/data_handling/data_handling.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:othia/widgets/openingtimes.dart';
import 'package:provider/provider.dart';

import 'input_notifier.dart';

class OpeningTimesSelector extends StatelessWidget {
  AddEANotifier inputNotifier;
  BuildContext context;
  late Map openingTime;

  OpeningTimesSelector({required this.inputNotifier, required this.context});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddEANotifier>(builder: (context, model, child) {
      openingTime = model.openingTimes;
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
                              // TODO define each item individually and build logic
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
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        alignment: WrapAlignment.start,
                        children: [
                          getSpecialOpeningTimeButton(
                              context: context,
                              caption: "24h open",
                              coloredBorder: inputNotifier.isAlwaysOpen(),
                              onTapFunction: () =>
                                  {inputNotifier.alwaysOpenOnWeekDay()}),
                          getSpecialOpeningTimeButton(
                              context: context,
                              caption: "Closed",
                              coloredBorder: inputNotifier.isClosed(),
                              onTapFunction: () =>
                                  {inputNotifier.closedOnWeekDay()})
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
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
