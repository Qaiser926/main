// import 'package:flutter/cupertino.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'dart:convert';
// import 'package:amplify_api/amplify_api.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../../modules/models/detailed_event/detailed_event.dart';
// import '../../utils/services/data_handling/data_handling.dart';
// import '../../utils/services/data_handling/get_ical_element.dart';
// import '../../utils/services/rest-api/rest_api_service.dart';
// import '../../utils/ui/ui_utils.dart';
//
// import '../../widgets/splash_screen.dart';
// import 'package:get/get.dart';
// import 'package:latlong2/latlong.dart' as latLng;
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'dart:convert';
// import 'package:amplify_api/amplify_api.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../../modules/models/detailed_event/detailed_event.dart';
// import '../../utils/services/data_handling/data_handling.dart';
// import '../../utils/services/data_handling/get_ical_element.dart';
// import '../../utils/services/rest-api/rest_api_service.dart';
// import '../../utils/ui/ui_utils.dart';
//
// import '../../widgets/splash_screen.dart';
// import 'package:get/get.dart';
// import 'package:latlong2/latlong.dart' as latLng;
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../modules/models/eA_summary/eA_summary.dart';
//
//
// class HorizontalEADiscovery extends StatelessWidget {
//     final List<String> eAIds;
//
//   const HorizontalEADiscovery({super.key, required this.eAIds});
//
//   @override
//   Widget build(BuildContext context) {
//
//     return  SizedBox(
//     height: 289.h,
//     child: ListView.builder(
//       primary: false,
//       shrinkWrap: true,
//       itemCount: eAIds.length,
//       scrollDirection: Axis.horizontal,
//       itemBuilder: (context, index) {
//         // TODO preload also future data that is not yet visible for the user
//         late Future<Object> response = RestService().fetchEventOrActivityDetails(eventOrActivityId: eAIds[index]);
//
//         return FutureBuilder(
//             future: response,
//             builder: (context, snapshot) {
//           RestResponse data = snapshot.data as RestResponse;
//           Map<String, dynamic> json = jsonDecode(data.body);
//           SummaryEventorActivity eASummary = SummaryEventorActivity.fromJson(json);
//           return SelfBuildWidget(
//           )
//
//           }
//
//           }
//
//       },
//     ),
//   );
// }