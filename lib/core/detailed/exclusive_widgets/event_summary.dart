import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/core/detailed/exclusive_widgets/price_widget.dart';
import 'package:othia/core/detailed/exclusive_widgets/time.dart';
import '../../../constants/colors.dart';
import '../../../utils/ui/ui_utils.dart';
import 'location_information_widget.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:add_2_calendar/add_2_calendar.dart';

class EventSummary extends StatelessWidget {
  final String title;
  final String locationText;
  final String time;
  latLng.LatLng? latLong;
  Event? iCalElement;


  EventSummary(
      {super.key,
      required this.title,
      required this.locationText,
      required this.time,
        double? latitude,
        double? longitude,
        this.iCalElement
      }){
    if ((latitude != null) & (longitude != null)) {
      latLong = latLng.LatLng(latitude!, longitude!);
  }}

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22.h),
          boxShadow: [
            BoxShadow(color: shadowColor, blurRadius: 27, offset: Offset(0, 8))
          ]),
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getVerSpace(10.h),
          getMultilineCustomFontRestricted(
              text: title, maxLines: 2, context: context),
          getVerSpace(10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                  // TODO: sove that title can flow into price information
                  children: [
                    LocationInformationWidget(
                        locationText: locationText, latLong: latLong),
                    getVerSpace(10.h),
                    // no logic implemented regarding times-> wait for actual data
                    TimeWidget(time: time, iCalElement: iCalElement),
                  ]),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [PriceWidget(type: 2, price: 12.12)],
              ),
            ],
          ),

          // Row(children: [ SizedBox(height: 50, width: 50)]),

          // GestureDetector(onTap: () => print("123"),child: SizedBox(height: 50, width: 50,
          //   child:alternativeGetButton(context, Colors.white, "", accentColor,  () => print("123"), 14.sp,
          //   weight: FontWeight.w700,
          //   buttonHeight: 50.h,
          //   buttonWidth: 50.h,
          //   isBorder: true,
          //   borderColor: accentColor,
          //   borderWidth: 1.h,
          //   borderRadius: BorderRadius.circular(14.h))))]),

          //fix issue that null and initialize dynamically

          // definiert den unteren Rand
          getVerSpace(13.h),
        ],
      ),
    );
  }

}


