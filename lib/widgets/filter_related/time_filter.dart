import 'package:flutter/material.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TimeFilter extends StatefulWidget {


  TimeFilter({super.key});

  @override
  State<TimeFilter> createState() => _TimeFilterState();
}

class _TimeFilterState extends State<TimeFilter> {


  _TimeFilterState();

  Future dateTimeRangePicker() async {
    DateTimeRange? picked = await
    showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDateRange: DateTimeRange(
          end: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 13),
          start: DateTime.now(),
        ),
        // builder: (context, child) {
        //   return Column(
        //     children: [
        //       ConstrainedBox(
        //         constraints: BoxConstraints(
        //           maxWidth: 400.0,
        //         ),
        //         child: child,
        //       )
        //     ],
        //   );
        // }
        );
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
            child: FutureBuilder(future:dateTimeRangePicker() ,
    builder: (context, snapshot) { if (snapshot.hasError) {
    throw Exception(snapshot.error);
    } else {
    Widget data = snapshot.data as Widget;
    return data;}})
    ,),]);
}}

