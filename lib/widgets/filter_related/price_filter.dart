import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:othia/widgets/filter_related/notifiers/abstract_query_notifier.dart';
import 'package:provider/provider.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

import 'get_reset_apply_filter.dart';

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
      });
}

class PriceFilter extends StatefulWidget {
  final double startValue = NavigatorConstants.PriceRangeStart;
  final double endValue = NavigatorConstants.PriceRangeEnd;
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

  _PriceFilterState(
      {required BuildContext context, required this.dynamicProvider}) {
    _values = dynamicProvider.getPriceRange;
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
      if (_values.end.round() == NavigatorConstants.PriceRangeEnd) {
        endValue = AppLocalizations.of(context)!.unlimited;
      }
      return Column(
        children: [
          Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [CloseButton()])),
          // Padding(
          //     padding: EdgeInsets.fromLTRB(10, 0, 20, 20),
          //     child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          //       Text(
          //         AppLocalizations.of(context)!.priceRangeDescription,
          //         style: Theme.of(context).textTheme.headline2,
          //       )
          //     ])),
          RangeSlider(
              values: _values,
              min: 0,
              max: widget.endValue,
              onChanged: (RangeValues values) {
                setState(() {
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
                });
              }),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getPriceBox(
                    context: context,
                    header: AppLocalizations.of(context)!.minimum,
                    price: _values.start.round().toString()),
                Icon(Typicons.minus, color: Theme.of(context).highlightColor),
                getPriceBox(
                    context: context,
                    header: AppLocalizations.of(context)!.maximum,
                    price: endValue),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: getShowResultsButton(
                context: context,
                functionAccept:
                dynamicProvider.changePriceRange,
                functionArgumentsAccept: {
                  #priceRange: RangeValues(_values.start.roundToDouble(),
                      _values.end.roundToDouble())
                },
                functionArgumentsReset: {},
                functionReset:
                dynamicProvider.resetPriceRange,
                closeDialog: true),
          )
        ],
      );
    });
  }
}

Widget getPriceBox(
    {required BuildContext context,
    required String header,
    required String price}) {
  String priceText = "€${price}";
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
      children: [Text(header), getVerSpace(5), Text(priceText)],
    ),
  );
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
        return "€${range.start}";
      }
    }
    if (range.end.round() == NavigatorConstants.PriceRangeEnd) {
      return "€${range.start.round()} - Max.";
    }
    return "€${range.start.round()} - €${range.end.round()}";
  } else {
    return AppLocalizations.of(context)!.price;
  }
}