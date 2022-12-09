import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class TimeFilter extends StatefulWidget {
  TimeFilter({super.key});

  @override
  State<TimeFilter> createState() => _TimeFilterState();
}

class _TimeFilterState extends State<TimeFilter> {
  String? _dateCount;
  String? _range;

  @override
  void initState() {
    _dateCount = '';
    _range = '';
    super.initState();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range =
            DateFormat('dd/MM/yyyy').format(args.value.startDate).toString() +
                ' - ' +
                DateFormat('dd/MM/yyyy')
                    .format(args.value.endDate ?? args.value.startDate)
                    .toString();
      } else if (args.value is DateTime) {
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: EdgeInsets.all(20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [CloseButton()])),
      Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 20, 20),
        child: SfDateRangePicker(
          onSelectionChanged: _onSelectionChanged,
          selectionMode: DateRangePickerSelectionMode.range,
          initialSelectedRange: PickerDateRange(
              DateTime.now().subtract(const Duration(days: 4)),
              DateTime.now().add(const Duration(days: 3))),
        ),
      ),
        Text("${_range}"),
      getVerSpace(100)
    ]);
  }
}
