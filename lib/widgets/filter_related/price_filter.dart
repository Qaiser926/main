import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:provider/provider.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

import 'get_reset_apply_filter.dart';
import 'search_notifier.dart';

Future<dynamic> priceFilterDialog({required BuildContext context}) {
  var test = Provider.of<SearchNotifier>(context, listen: false);
  return showModalBottomSheet(
      isScrollControlled: true,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      context: context,
      builder: (_) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: test,
            )
          ],
          child: Wrap(
            children: [PriceFilter(context: context)],
          ),
        );
      });
}

class PriceFilter extends StatefulWidget {
  final double startValue = NavigatorConstants.PriceRangeStart;
  final double endValue = NavigatorConstants.PriceRangeEnd;
  BuildContext context;

  PriceFilter({super.key, required BuildContext this.context});

  @override
  State<PriceFilter> createState() => _PriceFilterState(context: this.context);
}

class _PriceFilterState extends State<PriceFilter> {
  late RangeValues _values;

  _PriceFilterState({required BuildContext context}) {
    _values = Provider.of<SearchNotifier>(context, listen: false).getPriceRange;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchNotifier>(builder: (context, model, child) {
      if (model.priceReset) {
        _values = model.getPriceRange;
        Provider.of<SearchNotifier>(context, listen: false)
            .setPriceResetFalse();
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
                Provider.of<SearchNotifier>(context, listen: false)
                    .changePriceRange,
                functionArgumentsAccept: {
                  #priceRange: RangeValues(_values.start.roundToDouble(),
                      _values.end.roundToDouble())
                },
                functionArgumentsReset: {},
                functionReset:
                    Provider.of<SearchNotifier>(context, listen: false)
                        .resetPriceRange,
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
    {required BuildContext context, required SearchNotifier searchNotifier}) {
  if (searchNotifier.priceFilterActivated) {
    RangeValues range = searchNotifier.getPriceRange;
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