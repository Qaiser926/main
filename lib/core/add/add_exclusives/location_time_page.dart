import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:othia/core/add/add.dart';
import 'package:othia/core/add/add_exclusives/address_form.dart';
import 'package:othia/core/add/add_exclusives/opening_times_selector.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:provider/provider.dart';

import 'input_notifier.dart';
import 'time_selector.dart';

// TODO categorization, price, ticket link, description, optional: slider for activity lvl

class LocationTimePage extends StatefulWidget {
  AddEANotifier inputNotifier;

  LocationTimePage(this.inputNotifier);

  @override
  State<LocationTimePage> createState() => _LocationTimePageState();
}

class _LocationTimePageState extends State<LocationTimePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Consumer<AddEANotifier>(
              builder: (context, inputNotifierConsumer, child) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getHeadline(
                      context: context,
                      caption: Text("Location",
                          style: Theme.of(context).textTheme.headline4)),
                  getSwitch(
                      onPressed: changeLocationType,
                      isSelected: inputNotifierConsumer.locationType,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5.h),
                          child: Text("Address"),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.h),
                          child: Text('Online'),
                        ),
                      ]),
                  if (inputNotifierConsumer.locationType[0])
                    AddressForm(
                        context: context, inputNotifier: inputNotifierConsumer),
                  getVerSpace(10.h),
                  getHeadline(
                    context: context,
                    caption: GestureDetector(
                      onTap: () => {
                        getInfoDialog(
                            info:
                                "According to whether you set a start/ end date or opening time, we consider your"
                                " post as event or activity respectively.",
                            context: context)
                      },
                      child: Row(children: [
                        Text("Time",
                            style: Theme.of(context).textTheme.headline4),
                        Padding(
                          padding: EdgeInsets.only(left: 5.h),
                          child: Icon(Icons.info_outline, size: 14),
                        )
                      ]),
                    ),
                  ),
                  getSwitch(
                      onPressed: changeTimeType,
                      isSelected: inputNotifierConsumer.times,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5.h),
                          child: Text("Start time & End time"),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.h),
                          child: Text('Opening hours'),
                        ),
                      ]),
                  if (Provider.of<AddEANotifier>(context, listen: true)
                      .times[0])
                  // in order for the the global key to have a state, it is necessary to define it here (also for the opening times selector)
                    Form(
                        key: widget.inputNotifier.timeFormKey,
                        child: TimeSelector(
                            context: context,
                            inputNotifier: widget.inputNotifier)),
                  if (Provider.of<AddEANotifier>(context, listen: true)
                      .times[1])
                    Form(
                        key: widget.inputNotifier.timeFormKey,
                        child: OpeningTimesSelector(
                            context: context,
                            inputNotifier: widget.inputNotifier)),
                ]);
          })),
    );
    // });
  }

  void changeLocationType(int index, BuildContext context) {
    widget.inputNotifier.changeLocationType(index, context);
  }

  void changeTimeType(int index, BuildContext context) {
    widget.inputNotifier.changeTimeType(index, context);
  }

  Widget getSwitch({
    required Function onPressed,
    required isSelected,
    required children,
  }) {
    return ToggleButtons(
        direction: Axis.horizontal,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        constraints: const BoxConstraints(
          minHeight: 40.0,
          minWidth: 80.0,
        ),
        isSelected: isSelected,
        renderBorder: true,
        onPressed: (index) => onPressed(index, context),
        children: children);
  }
}

Future getInfoDialog({required String info, required BuildContext context}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(info),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Close"),
            ),
          ],
        );
      });
}
