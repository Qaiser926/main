import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/core/add/add.dart';
import 'package:provider/provider.dart';

import 'input_notifier.dart';

// TODO categorization, price, ticket link, description, optional: slider for activity lvl

class LocationTimePage extends StatefulWidget {
  AddEANotifier inputNotifier;

  LocationTimePage(this.inputNotifier);

  @override
  State<LocationTimePage> createState() => _LocationTimePageState();
}

class _LocationTimePageState extends State<LocationTimePage> {
  TextEditingController _textController = TextEditingController();

  String? locationTitle;
  String? street;
  String? streetNumber;
  String? city;
  String? postalCode;

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
                  getHeadline(context: context, caption: "Location"),
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
                  if (inputNotifierConsumer.locationType[0]) buildAddressForm(),
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

  Widget buildAddressForm() {
    // TODO build column as customaizable form field with own validation logic
    return Form(
        key: widget.inputNotifier.locationFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              hintText: "Titel / Name",
              optional: false,
              onChangedFunction: (text) {
                widget.inputNotifier.locationTitle = text;
                setState(() => {
                      this.locationTitle = text,
                    });
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.only(right: 5.h),
                      child: CustomTextFormField(
                        onChangedFunction: (text) {
                          widget.inputNotifier.street = text;
                          setState(() => {
                                this.street = text,
                              });
                        },
                        hintText: "Straße",
                        optional: false,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: CustomTextFormField(
                      onChangedFunction: (text) {
                        widget.inputNotifier.streetNumber = text;
                        setState(() => {
                              this.streetNumber = text,
                            });
                      },
                      hintText: "Nr",
                      optional: false,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.only(right: 5.h),
                    child: CustomTextFormField(
                      onChangedFunction: (text) {
                        widget.inputNotifier.city = text;
                        setState(() => {
                              this.city = text,
                            });
                      },
                      hintText: "Stadt",
                      optional: false,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: CustomTextFormField(
                    onChangedFunction: (text) {
                      widget.inputNotifier.postalCode = text;
                      setState(() => {
                            this.postalCode = text,
                          });
                    },
                    hintText: "Plz",
                    optional: false,
                  ),
                ),
              ],
            ),
          ],
        ));
  }

// Column buildTitleSection() {
//   return Column(children: <Widget>[
//     TextFormField(
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter some text';
//         }
//         return null;
//       },
//       initialValue: Provider.of<AddEANotifier>(context, listen: false).title,
//       controller:
//           Provider.of<AddEANotifier>(context, listen: false).title == null
//               ? _textController
//               : null,
//       onChanged: (title) {
//         setState(() => {this.title = title});
//
//         widget.inputNotifier.title = title;
//       },
//       maxLength: 100,
//       maxLines: null,
//       decoration: new InputDecoration(
//           contentPadding: EdgeInsets.all(5.h),
//           border: OutlineInputBorder(),
//           hintText: 'Enter the title '),
//     ),
//   ]);
// }
}

class CustomTextFormField extends TextFormField {
  CustomTextFormField(
      {super.key,
      String? hintText,
      required bool optional,
      required Function(dynamic val) onChangedFunction})
      : super(
          decoration: new InputDecoration(
              contentPadding: EdgeInsets.all(5.h),
              border: OutlineInputBorder(),
              hintText: hintText),
          // TODO write validator
          validator: optional
              ? null
              : (value) {
                  if (value == null || value.isEmpty) {
                    return 'Could not validate stated address';
                  }
                  return null;
                },
          onChanged: onChangedFunction,
        );
}
