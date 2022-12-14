import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:othia/core/detailed/exclusive_widgets/price_widget.dart';
import 'package:othia/core/detailed/exclusive_widgets/time_widget.dart';

import '../../../modules/models/shared_data_models.dart';
import '../../../utils/ui/ui_utils.dart';
import 'location_information_widget.dart';

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

  EventSummary({super.key,
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
        borderRadius: BorderRadius.circular(22.h),
        color: Theme.of(context).colorScheme.tertiary,

        // boxShadow: [BoxShadow(blurRadius: 27, offset: Offset(0, 8))]
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
              // TODO: solve that title can flow into price information
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
          getVerSpace(13.h),
        ],
      ),
    );
  }
}
