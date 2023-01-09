import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'input_notifier.dart';

class AddressForm extends StatefulWidget {
  AddEANotifier inputNotifier;
  BuildContext context;

  AddressForm({required this.inputNotifier, required this.context});

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
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
    return Consumer<AddEANotifier>(
        builder: (context, inputNotifierConsumer, child) {
      String? _validateAddress(String? text) {
        if (inputNotifierConsumer.isAddressInvalid) {
          return 'Could not validate address';
        }
        return null;
      }

      return Form(
          key: widget.inputNotifier.addressFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.only(right: 5.h),
                        child: CustomTextFormField(
                          initialValue: widget.inputNotifier.street,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp('[0-9]'))
                          ],
                          validationFunction: _validateAddress,
                          onChangedFunction: (text) {
                            widget.inputNotifier.street = text;
                            setState(() => {
                                  this.street = text,
                                });
                          },
                          hintText: "Straße",
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: CustomTextFormField(
                        initialValue: widget.inputNotifier.streetNumber,
                        validationFunction: _validateAddress,
                        onChangedFunction: (text) {
                          widget.inputNotifier.streetNumber = text;
                          setState(() => {
                                this.streetNumber = text,
                              });
                        },
                        hintText: "Nr",
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
                        initialValue: widget.inputNotifier.city,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp('[0-9]'))
                        ],
                        validationFunction: _validateAddress,
                        onChangedFunction: (text) {
                          widget.inputNotifier.city = text;
                          setState(() => {
                                this.city = text,
                              });
                        },
                        hintText: "Stadt",
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: CustomTextFormField(
                      numberInput: true,
                      initialValue: widget.inputNotifier.postalCode,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                      validationFunction: _validateAddress,
                      onChangedFunction: (text) {
                        widget.inputNotifier.postalCode = text;
                        setState(() => {
                              this.postalCode = text,
                            });
                      },
                      hintText: "Plz",
                    ),
                  ),
                ],
              ),
            ],
          ));
    });
  }
}

class CustomTextFormField extends TextFormField {
  CustomTextFormField(
      {super.key,
      String? hintText,
      required Function(dynamic val) onChangedFunction,
      required String? Function(String?) validationFunction,
      List<FilteringTextInputFormatter>? inputFormatters,
      required dynamic initialValue,
      bool numberInput = false})
      : super(
      keyboardType: numberInput ? TextInputType.number : null,
            decoration: new InputDecoration(
                contentPadding: EdgeInsets.all(5.h),
                border: OutlineInputBorder(),
                hintText: hintText),
            validator: validationFunction,
            onChanged: onChangedFunction,
            inputFormatters: inputFormatters,
            initialValue: initialValue);
}