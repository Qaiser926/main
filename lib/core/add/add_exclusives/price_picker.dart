import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/modules/models/shared_data_models.dart';
import 'package:othia/utils/helpers/diverse.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:provider/provider.dart';

import 'input_notifier.dart';

class PricePicker extends StatelessWidget {
  AddEANotifier inputNotifier;

  PricePicker(this.inputNotifier);

  @override
  Widget build(BuildContext context) {
    return 
    Consumer<AddEANotifier>(
        builder: (context, inputNotifierConsumer, child) {
          return Column(
            // TODO clear (extern) make each price row (containing of label, price and cross) scrollable
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: inputNotifierConsumer.detailedEA.prices!.length,
                  itemBuilder: (context, index) {
                    return 
                    buildPriceRow(
                        index: index,
                        context: context,
                        inputPrice: inputNotifierConsumer.detailedEA.prices![index],
                        inputNotifierConsumer: inputNotifierConsumer);
                  }),
              getVerSpace(5.h),
              GestureDetector(
                onTap: () {
                  dismissKeyboard();
                  inputNotifierConsumer.detailedEA.prices!.add(Price());
                  inputNotifier.notifyListeners();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 5.h),
                      child: Text(
                        AppLocalizations.of(context)!.addPriceGroup,
                        style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    Icon(Icons.add)
                  ],
                ),
              )
            ],
          );
        });
  
  }

  Widget buildPriceRow({required int index,
    required Price inputPrice,
    required AddEANotifier inputNotifierConsumer,
    required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                  padding: EdgeInsets.only(right: 5.h, bottom: 5.h),
                  child: TextFormField(
                    controller: inputPrice.label == null
                        ? null
                        : TextEditingController(
                      text: inputPrice.label,
                    ),
                    onChanged: (label) {
                      inputNotifierConsumer.detailedEA.prices![index].label =
                          label.substring(0,
                              min(label.length, DataConstants.MaxPriceLength));
                    },
                    maxLines: 1,
                    decoration: new InputDecoration(
                        contentPadding: EdgeInsets.all(5.h),
                        border: OutlineInputBorder(),
                        hintText:
                        AppLocalizations.of(context)!.priceLabelHintText),
                  ))),
          Expanded(
            flex: 1,
            child: Padding(
                padding: EdgeInsets.only(right: 8.h, bottom: 5.h),
                child: TextFormField(
                  controller: inputPrice.price == null
                      ? null
                      : TextEditingController(
                          text: inputPrice.price.toString(),
                  ),
                  inputFormatters: <TextInputFormatter>[
                    CurrencyTextInputFormatter(
                      locale: 'de',
                      decimalDigits: 2,
                      symbol: '€ ',
                    ),
                  ],
                  keyboardType: TextInputType.number,
                  onChanged: (price) {
                    inputNotifierConsumer.detailedEA.prices![index].price =
                        transformCurrencyString(price);
                  },
                  maxLines: 1,
                  decoration: new InputDecoration(
                      contentPadding: EdgeInsets.all(5.h),
                      border: OutlineInputBorder(),
                      hintText: AppLocalizations.of(context)!.price),
                )),
          ),
          GestureDetector(
            onTap: () {
              inputNotifierConsumer.detailedEA.prices!.removeAt(index);
              inputNotifierConsumer.notifyListeners();
            },
            child: Icon(Icons.close),
          )
        ],
      ),
    );
  }

  double transformCurrencyString(String currencyText) {
    RegExp exp = RegExp(r'([0-9]*)[\,\.]([0-9])*');
    RegExpMatch? match = exp.firstMatch(currencyText);
    String? result = match![0]?.replaceAll(",", ".");
    return double.parse(result!);
  }
}


