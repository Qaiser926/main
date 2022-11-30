import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/widgets/price_widget.dart';
import 'package:othia/widgets/time.dart';
import '../utils/ui/ui_utils.dart';
import 'LocationInformationWidget.dart';

class EventSummary extends StatelessWidget {
  final String title;
  final String locationName;
  final String city;
  final String time;

  const EventSummary(
      {super.key,
      required this.title,
      required this.locationName,
      required this.city,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22.h),
          boxShadow: const [BoxShadow(blurRadius: 27, offset: Offset(0, 8))]),
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getVerSpace(13.h),
          getMultilineCustomFontRestricted(title, 19.sp, Colors.black, 2,
              fontWeight: FontWeight.w700, txtHeight: 1.5.h),
          getVerSpace(10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                  // TODO: sove that title can flow into price information
                  children: [
                    LocationInformationWidget(city,street: 'olaf',streetNumber: 12,
                        locationTitle: locationName),
                    getVerSpace(10.h),
                    // no logic implemented regarding times-> wait for actual data
                    TimeWidget(time: time),
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
