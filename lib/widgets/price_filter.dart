import 'package:flutter/material.dart';

class PriceFilter extends StatefulWidget {
  final double startValue;
  final double endValue;

  PriceFilter({super.key, required this.startValue, required this.endValue});

  @override
  State<PriceFilter> createState() => _PriceFilterState();
}

class _PriceFilterState extends State<PriceFilter> {
  late RangeValues _values;

  _PriceFilterState() {
    _values = RangeValues(0, 100)
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.all(20),
            child: RangeSlider(
                values: _values,
                min: widget.startValue,
                max: widget.endValue,
                onChanged: (RangeValues values) {
                  setState(() {
                    if (values.end - values.start <= 3) {
                      if (widget.endValue - values.end <= 3){
                        _values = RangeValues(widget.endValue, widget.endValue);
                      }if (values.end - widget.startValue <= 3){
                        _values = RangeValues(widget.startValue, widget.startValue);
                      } else {
                        _values = values;
                      }
                    } else {
                      _values = values;
                    }
                  });
                }
            )),
        Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              ClipRect(
                child: Container(
                  child: Column(
                    children: [
                      Text("Minimum"),
                      Text("${_values.start.round()}")
                    ],
                  ),
                ),
              ),
              ClipRect(
                child: Container(
                  child: Column(
                    children: [Text("Maximum"), Text("${_values.end.round()}")],
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              ClipRect(
                  child: Container(
                child:
                    ElevatedButton(child: Text("reset"), onPressed: () => {}),
              )),
              ClipRect(
                  child: Container(
                child:
                    ElevatedButton(child: Text("apply"), onPressed: () => {}),
              ))
            ],
          ),
        )
      ],
    );
  }
}
