import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:provider/provider.dart';

import 'input_notifier.dart';

class PricePicker extends StatelessWidget {
  AddEANotifier inputNotifier;

  PricePicker(this.inputNotifier);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddEANotifier>(
        builder: (context, inputNotifierConsumer, child) {
      return Column(
        // TODO make each price row containing of label, price and cross scrollable
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: inputNotifierConsumer.prices.length,
              itemBuilder: (context, index) {
                return buildPriceRow(
                    index: index,
                    inputPrice: inputNotifierConsumer.prices[index],
                    inputNotifierConsumer: inputNotifierConsumer);
              }),
          getVerSpace(5.h),
          GestureDetector(
            onTap: () {
              inputNotifierConsumer.prices.add(InputPrice());
              inputNotifier.notifyListeners();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 5.h),
                  child: Text(
                    "Add Price Group",
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

  Widget buildPriceRow(
      {required int index,
      required InputPrice inputPrice,
      required AddEANotifier inputNotifierConsumer}) {
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
                      // TODO, define variable globally on how many characters to include
                      inputNotifierConsumer.prices[index].label =
                          label.substring(0, 20);
                      inputNotifierConsumer.notifyListeners();
                    },
                    maxLines: 1,
                    decoration: new InputDecoration(
                        contentPadding: EdgeInsets.all(5.h),
                        border: OutlineInputBorder(),
                        hintText: 'Label, e.g. "Student", "Children"'),
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
                    inputNotifierConsumer.prices[index].price =
                        transformCurrencyString(price);
                  },
                  maxLines: 1,
                  decoration: new InputDecoration(
                      contentPadding: EdgeInsets.all(5.h),
                      border: OutlineInputBorder(),
                      hintText: 'Price'),
                )),
          ),
          GestureDetector(
            onTap: () {
              inputNotifierConsumer.prices.removeAt(index);
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

class InputPrice {
  String? label;
  double? price;

  InputPrice({this.price, this.label});
}
