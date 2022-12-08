// import 'package:flutter/material.dart';
// import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
//
//
// /// Page with [dp.DayPicker] where many single days can be selected.
// class DaysPickerPage extends StatefulWidget {
//   /// Custom events.
//   // final List<Event> events;
//
//   ///
//   const DaysPickerPage({Key? key, }) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _DaysPickerPageState();
// }
//
// class _DaysPickerPageState extends State<DaysPickerPage> {
//   List<DateTime> _selectedDates = [];
//   final DateTime _firstDate = DateTime.now().subtract(Duration(days: 45));
//   final DateTime _lastDate = DateTime.now().add(Duration(days: 45));
//
//   Color selectedDateStyleColor = Colors.blue;
//   Color selectedSingleDateDecorationColor = Colors.red;
//
//   @override
//   void initState() {
//     super.initState();
//
//     final now = DateTime.now();
//
//     _selectedDates = [
//       now,
//       now.subtract(Duration(days: 10)),
//       now.add(Duration(days: 7))
//     ];
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//
//     selectedDateStyleColor = Theme.of(context).colorScheme.onSecondary;
//     selectedSingleDateDecorationColor = Theme.of(context).colorScheme.secondary;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // add selected colors to default settings
//     dp.DatePickerRangeStyles styles = dp.DatePickerRangeStyles(
//         selectedDateStyle: Theme.of(context)
//             .textTheme
//             .bodyText1
//             ?.copyWith(color: selectedDateStyleColor),
//         selectedSingleDateDecoration: BoxDecoration(
//             color: selectedSingleDateDecorationColor, shape: BoxShape.circle));
//
//     return Flex(
//       direction: MediaQuery.of(context).orientation == Orientation.portrait
//           ? Axis.vertical
//           : Axis.horizontal,
//       children: <Widget>[
//         Expanded(
//           child: dp.DayPicker.multi(
//             selectedDates: _selectedDates,
//             onChanged: _onSelectedDateChanged,
//             firstDate: _firstDate,
//             lastDate: _lastDate,
//             datePickerStyles: styles,
//             datePickerLayoutSettings: dp.DatePickerLayoutSettings(
//                 maxDayPickerRowCount: 2,
//                 showPrevMonthEnd: true,
//                 showNextMonthStart: true),
//             selectableDayPredicate: _isSelectableCustom,
//
//           ),
//         ),
//         Container(
//           child: Padding(
//             padding:
//             const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   "Selected date styles",
//                   style: Theme.of(context).textTheme.subtitle1,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 12.0),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//
//                       SizedBox(
//                         width: 12.0,
//                       ),
//
//                     ],
//                   ),
//                 ),
//                 Text("Selected: $_selectedDates")
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//
//
//
//   void _onSelectedDateChanged(List<DateTime> newDates) {
//     setState(() {
//       _selectedDates = newDates;
//     });
//   }
//
//   // ignore: prefer_expression_function_bodies
//   bool _isSelectableCustom(DateTime day) {
//     return day.weekday < 6;
//   }
//
//
// }