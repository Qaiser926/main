import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/core/detailed/exclusive_widgets/price_widget.dart';
import 'package:othia/core/detailed/exclusive_widgets/time_widget.dart';
import '../../../constants/colors.dart';
import '../../../modules/models/shared_data_models.dart';
import '../../../utils/ui/ui_utils.dart';
import 'location_information_widget.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:add_2_calendar/add_2_calendar.dart';

class EventSummary extends StatelessWidget {
  final String title;
  final String timeText;
  final Location location;
  latLng.LatLng? latLong;
  Event? iCalElement;
  List<double>? prices;
  String? websiteUrl;
  String? ticketUrl;
  Status? status;

  EventSummary(
      {super.key,
        required this.location,
      required this.title,
      required this.timeText,
        this.iCalElement,
        this.prices,
        this.websiteUrl,
        this.ticketUrl,
        this.status
      }){
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22.h),
          boxShadow: [BoxShadow(blurRadius: 27, offset: Offset(0, 8))]
          ),
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getVerSpace(10.h),
          getMultilineCustomFontRestricted(
              text: title, maxLines: 2, textTheme: Theme.of(context).textTheme.headline2),
          getVerSpace(10.h),

              Column(crossAxisAlignment: CrossAxisAlignment.start,
                  // TODO: sove that title can flow into price information
                  children: [
                    LocationWidget(location: location),
                getVerSpace(10.h),
                // no logic implemented regarding times-> wait for actual data
                TimeWidget(time: timeText, iCalElement: iCalElement),
                getVerSpace(10.h),
                // no logic implemented regarding times-> wait for actual data
                PriceWidget(
                  prices: prices,
                  ticketUrl: ticketUrl,
                  websiteUrl: websiteUrl,
                  status: status,
                ),
              ]),

          // Row(children: [ SizedBox(height: 50, width: 50)]),

          // GestureDetector(onTap: () => print("123"),child: SizedBox(height: 50, width: 50,
          //   child:alternativeGetButton(context,  "",  () => print("123"), 14.sp,
          //   weight: FontWeight.w700,
          //   buttonHeight: 50.h,
          //   buttonWidth: 50.h,
          //   isBorder: true,
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
