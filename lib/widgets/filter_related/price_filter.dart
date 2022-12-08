import 'package:flutter/material.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:provider/provider.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../utils/services/search_notifier.dart';
import 'get_reset_apply_filter.dart';

Future<dynamic> priceFilterDialog({required BuildContext context}) {
  var test = Provider.of<SearchNotifier>(context, listen: false);
  return showModalBottomSheet(
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
          child: Container(
            height: 380,
            child: PriceFilter(context: context,endValue: 100),
          ),
        );
      });
}

class PriceFilter extends StatefulWidget {
  final double startValue = 0;
  final double endValue;
  BuildContext context;

  PriceFilter(
      {super.key, required this.endValue, required BuildContext this.context});

  @override
  State<PriceFilter> createState() =>
      _PriceFilterState(endValue: endValue, context: this.context);
}

class _PriceFilterState extends State<PriceFilter> {
  late RangeValues _values;

  _PriceFilterState({required endValue, required BuildContext context}) {
    _values = Provider.of<SearchNotifier>(context, listen: false).getPriceRange;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.all(20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [CloseButton()])),
        Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 20, 20),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                AppLocalizations.of(context)!.priceRangeDescription,
                style: Theme.of(context).textTheme.headline2,
              )
            ])),
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
                    _values = RangeValues(widget.startValue, widget.startValue);
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
                  price: _values.start.round()),
              Icon(Typicons.minus, color: Theme.of(context).highlightColor),
              getPriceBox(
                  context: context,
                  header: AppLocalizations.of(context)!.maximum,
                  price: _values.end.round()),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: getShowResultsButton(context: context, values: _values, function: Provider.of<SearchNotifier>(context, listen: false)
              .changePriceRange, functionArguments: {
          #priceRange: RangeValues(_values.start.roundToDouble(),
          _values.end.roundToDouble())}),
        )
      ],
    );
  }
}

Widget getPriceBox(
    {required BuildContext context,
    required String header,
    required int price}) {
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
      children: [Text(header), getVerSpace(5), Text("€${price}")],
    ),
  );
}


