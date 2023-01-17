import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../widgets/form_fields.dart';
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
          return AppLocalizations.of(context)!.addressErrorMessage;
        }
        return null;
      }

      return Column(
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
                      initialValue:
                          widget.inputNotifier.detailedEA.location.street,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp('[0-9]'))
                      ],
                      validator: _validateAddress,
                      onChanged: (text) {
                        widget.inputNotifier.detailedEA.location.street = text;
                        setState(() => {
                              this.street = text,
                            });
                      },
                      hintText: AppLocalizations.of(context)!.street,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: CustomTextFormField(
                    initialValue:
                        widget.inputNotifier.detailedEA.location.streetNumber,
                    validator: _validateAddress,
                    onChanged: (text) {
                      widget.inputNotifier.detailedEA.location.streetNumber =
                          text;
                      setState(() => {
                            this.streetNumber = text,
                          });
                    },
                    hintText: AppLocalizations.of(context)!.streetNumberShort,
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
                    initialValue: widget.inputNotifier.detailedEA.location.city,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp('[0-9]'))
                    ],
                    validator: _validateAddress,
                    onChanged: (text) {
                      widget.inputNotifier.detailedEA.location.city = text;
                      setState(() => {
                            this.city = text,
                          });
                    },
                    hintText: AppLocalizations.of(context)!.city,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: CustomTextFormField(
                  numberInput: true,
                  initialValue:
                      widget.inputNotifier.detailedEA.location.postalCode,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  ],
                  validator: _validateAddress,
                  onChanged: (text) {
                    widget.inputNotifier.detailedEA.location.postalCode = text;
                    setState(() => {
                          this.postalCode = text,
                        });
                  },
                  hintText: AppLocalizations.of(context)!.postalCodeShort,
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
