//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../../utils/ui/ui_utils.dart';
//
//
// class TabProfile extends StatefulWidget {
//   const TabProfile({Key? key}) : super(key: key);
//
//   @override
//   void initState() {
//     // TODO how to receive the user id?
//     String eventId = Get.arguments[NavigatorConstants.EventActivityId] ?? "1";
//     if (eventId != null)
//     detailedEventOrActivity =
//         RestService().fetchEventOrActivityDetails(eventOrActivityId: eventId);
//
//     super.initState();
//   }
//
//   @override
//   State<TabProfile> createState() => _TabProfileState();
// }
//
// class _TabProfileState extends State<TabProfile> {
//   var interestList = {"Art", "Music", "Food", "Technology", "Party"};
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 73.h,
//         elevation: 0,
//         title: Text("Profile",),
//         centerTitle: true,
//         actions: [
//           GestureDetector(
//               onTap: () {
//                 // TODO implement when routing decision made
//                 // Constant.sendToNext(context, Routes.settingRoute);
//               },
//               child: Icon(Icons.settings, size: 24.h,)),
//           getHorSpace(20.h)
//         ],
//       ),
//       body: Expanded(
//           flex: 1,
//           child: ListView(
//             primary: true,
//             shrinkWrap: true,
//             children: [
//               buildProfileSection(),
//               getVerSpace(20.h),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20.h),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     buildAboutWidget(),
//                     getVerSpace(30.h),
//                     buildInterestWidget()
//                   ],
//                 ),)
//
//             ],
//           )))}
//
//   }
//
//   Column buildInterestWidget() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             getCustomFont("Interests", 18.sp, Colors.black, 1,
//                 fontWeight: FontWeight.w600),
//             getHorSpace(3.h),
//             getSvgImage('edit.svg',
//                 color: Colors.black,
//                 height: 24.h,
//                 width: 24.h)
//           ],
//         ),
//         getVerSpace(10.h),
//         Wrap(
//             alignment: WrapAlignment.start,
//             spacing: 10.h,
//             runSpacing: 10.h,
//             children: interestList
//                 .map((e) => Container(
//               padding: EdgeInsets.symmetric(
//                   horizontal: 20.h, vertical: 6.h),
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius:
//                   BorderRadius.circular(27.h),
//                   border: Border.all(
//                       color: accentColor,
//                       width: 1.h)),
//               child: getCustomFont(
//                   e, 15.sp, accentColor, 1,
//                   fontWeight: FontWeight.w600),
//             ))
//                 .toList())
//       ],
//     );
//   }
//
//
//
//   Container buildProfileSection() {
//     return Container(
//       color: accentColor.withOpacity(0.05),
//       width: double.infinity,
//       child: Column(
//         children: [
//           getVerSpace(31.h),
//           Stack(
//             alignment: Alignment.bottomRight,
//             children: [
//               getAssetImage("profile_image.png", width: 110.h, height: 110.h),
//               Positioned(
//                   child: Container(
//                     height: 30.h,
//                     width: 30.h,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20.h),
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                               color: shadowColor,
//                               offset: const Offset(0, 8),
//                               blurRadius: 27)
//                         ]),
//                     padding: EdgeInsets.all(5.h),
//                     child: getSvgImage("edit.svg", width: 20.h, height: 20.h),
//                   ))
//             ],
//           ),
//           getVerSpace(15.h),
//           getCustomFont("Jenny Wilson", 18.sp, Colors.black, 1,
//               fontWeight: FontWeight.w600, txtHeight: 1.5.h),
//           getVerSpace(20.h),
//
//         ],
//       ),
//     );
//   }
// }
