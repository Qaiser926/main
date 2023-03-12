import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:othia/widgets/filter_related/notifiers/abstract_query_notifier.dart';
import 'package:provider/provider.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

import 'get_reset_apply_filter.dart';

// TODO clear (extern) it should be not possible to type in ranges via the keyboard when clicking on the boxes

Future<dynamic> priceFilterDialog(
    {required BuildContext context,
    required AbstractQueryNotifier dynamicProvider}) {
  return showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      isScrollControlled: true,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      context: context,
      builder: (_) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: dynamicProvider,
            )
          ],
          child: Wrap(
            children: [
              PriceFilter(
                context: context,
                dynamicProvider: dynamicProvider,
              )
            ],
          ),
        );
        // return Container();
      });
}

class PriceFilter extends StatefulWidget {
  final double startValue = DataConstants.PriceRangeStart;
  final double endValue = DataConstants.PriceRangeEnd;
  AbstractQueryNotifier dynamicProvider;
  BuildContext context;

  PriceFilter(
      {super.key,
      required BuildContext this.context,
      required this.dynamicProvider});

  @override
  State<PriceFilter> createState() => _PriceFilterState(
      context: this.context, dynamicProvider: dynamicProvider);
}

class _PriceFilterState extends State<PriceFilter> {
  AbstractQueryNotifier dynamicProvider;
  late RangeValues _values;
  late TextEditingController minimum;
  late TextEditingController maximum;

  _PriceFilterState(
      {required BuildContext context, required this.dynamicProvider}) {
    _values = dynamicProvider.getPriceRange;
    _UpdateTextEditior();
  }
//UPdate the inital value of controllers
  _UpdateTextEditior(){
    minimum = new TextEditingController(text: _values.start.round().toString());
    maximum = new TextEditingController(text: _values.end.round().toString());
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AbstractQueryNotifier>(builder: (context, model, child) {
      if (model.priceReset) {
        _values = model.getPriceRange;
        dynamicProvider.setPriceResetFalse();
      }
      ;

      String endValue = _values.end.round().toString();
      if (_values.end.round() == DataConstants.PriceRangeEnd) {
        endValue = AppLocalizations.of(context)!.unlimited;
      }
      return Column(
        children: [
          Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [CloseButton()])),
          // Padding(
          //     padding: EdgeInsets.fromLTRB(10, 0, 20, 20),
          //     child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          //       Text(
          //         AppLocalizations.of(context)!.priceRangeDescription,
          //         style: Theme.of(context).textTheme.headlineLarge,
          //       )
          //     ])),
          RangeSlider(
              values: _values,
              min: 0,
              max: widget.endValue,
              onChanged: (RangeValues values) {
                print(widget.startValue);
                print(_values);

                setState(() {
                  // RangeValues j=new RangeValues(23, 44);
                  // _values=j;
                  if (values.end - values.start <= 3) {
                    if (widget.endValue - values.end <= 3) {
                      _values = RangeValues(widget.endValue, widget.endValue);
                    }
                    if (values.end - widget.startValue <= 3) {
                      _values =
                          RangeValues(widget.startValue, widget.startValue);
                    } else {
                      _values = values;
                    }
                  } else {
                    _values = values;
                  }
                  _UpdateTextEditior();
                });
              }),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Adding some funcitonallyi like callback fucntions and other wiht widget
                getPriceBox(
                    onTextChanged: (val) {
                      print("value is: " + val);
                      if (val == "") {
                        // controller.text=priceText;
                      } else {
                        if(int.parse(val)<_values.end){
                          minimum.text = val;
                          minimum.selection = TextSelection.fromPosition(
                              TextPosition(offset: minimum.text.length));
                          RangeValues j =
                          new RangeValues(double.parse(val), _values.end);
                          _values = j;
                        }
                        else{
                          minimum.text = "0";
                          minimum.selection = TextSelection.fromPosition(
                              TextPosition(offset: minimum.text.length));
                          RangeValues j =
                          new RangeValues(double.parse("0"), _values.end);
                          _values = j;
                        }

                        //print(range);

                        //print(controller.text);
                      }
                    },
                    range: _values.start,
                    type: "minimum",
                    controller: minimum,
                    context: context,
                    header: AppLocalizations.of(context)!.minimum,
                    price: _values.start.round().toString()),
                GestureDetector(
                    onTap: () {
                      print(_values);
                    },
                    child: Icon(Typicons.minus,
                        color: Theme.of(context).highlightColor)),
                getPriceBox(
                    onTextChanged: (val) {
                      print("value is: " + val);
                      if (val == "") {
                        // controller.text=priceText;
                      } else {

                        if(int.parse(val)>_values.start){
                          maximum.text = val;
                          maximum.selection = TextSelection.fromPosition(
                              TextPosition(offset: maximum.text.length));
                          RangeValues j =
                          new RangeValues(_values.start, double.parse(val));
                          _values = j;
                        }
                        else{
                          print("asdfdsf");
                          // maximum.text = "100";
                          // maximum.selection = TextSelection.fromPosition(
                          //     TextPosition(offset: maximum.text.length));
                          // RangeValues j =
                          // new RangeValues(_values.start, double.parse("100"));
                          // _values = j;
                        }

                        //print(range);

                        //print(controller.text);
                      }
                    },
                    range: _values.end,
                    type: "maximum",
                    controller: maximum,
                    context: context,
                    header: AppLocalizations.of(context)!.maximum,
                    price: endValue),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            // Adding some funcitonallyi like callback fucntions and other wiht widget
            child: getShowResultsButton(
                context: context,
                functionAccept: dynamicProvider.changePriceRange,
                functionArgumentsAccept: {
                  #priceRange: RangeValues(_values.start.roundToDouble(),
                      _values.end.roundToDouble())
                },
                functionArgumentsReset: {},
                functionReset: dynamicProvider.resetPriceRange,
                closeDialog: true),
          )
        ],
      );
    });
  }
}

Widget getPriceBox({
  required BuildContext context,
  required String header,
  required double range,
  required String type,
//Add some paramteres for supporting funcionallity on textfield
  required TextEditingController controller,
  required String price,
  required ValueChanged<String>? onTextChanged,
}) {
  String priceText = "${price}€";
  print("checnge");
  if (price == AppLocalizations.of(context)!.unlimited) priceText = price;
  return Container(
    width: 110,
    decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).highlightColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(12))),
    padding: EdgeInsets.all(8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(header),
        getVerSpace(5),

        //change text to TextField for manual input
        TextFormField(

          onChanged: onTextChanged,
          controller: controller,
          style: TextStyle(fontSize: 22),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            _NumberTextInputFormatter()
          ],
          decoration: InputDecoration(
            //hintText: priceText,
            contentPadding: EdgeInsets.zero,
            prefix: Icon(Icons.currency_pound_rounded,color: Colors.white,size: 18,),

            filled: true,
            fillColor: Colors.transparent,
            border: InputBorder.none,
          ),
        )
      ],
    ),
  );
}

class _NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return TextEditingValue.empty;
    } else if (int.parse(newValue.text) > 100) {
      return TextEditingValue(text: '100');
    } else if (int.parse(newValue.text) < 0) {
      return TextEditingValue(text:  '0');
    }
    return newValue;
  }
}

String getPriceCaption(
    {required BuildContext context,
    required AbstractQueryNotifier dynamicNotifier}) {
  if (dynamicNotifier.priceFilterActivated) {
    RangeValues range = dynamicNotifier.getPriceRange;
    if (range.start == range.end) {
      if (range.start == 0) {
        return AppLocalizations.of(context)!.free;
      } else {
        return "${range.start}€";
      }
    }
    if (range.end.round() == DataConstants.PriceRangeEnd) {
      return "${range.start.round()}€ - Max.";
    }
    return "${range.start.round()}€ - ${range.end.round()}€";
  } else {
    return AppLocalizations.of(context)!.price;
  }
}
