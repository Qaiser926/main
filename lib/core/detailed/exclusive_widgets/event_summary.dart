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
  List<Price>? prices;
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
      this.status}) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.h),
        color: Theme.of(context).colorScheme.tertiary,

        // boxShadow: [BoxShadow(blurRadius: 27, offset: Offset(0, 8))]
      ),
      // padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(12, 10, 10, 10),
            child: Text(
              title ,
               overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          // TODO: clear(extern) solve that title can flow into price information
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
            child: LocationWidget(location: location),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
            child: TimeWidget(time: timeText, iCalElement: iCalElement),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: PriceWidget(
              prices: prices,
              ticketUrl: ticketUrl,
              websiteUrl: websiteUrl,
              status: status,
            ),
          ),

          // no logic implemented regarding times-> wait for actual data

          getVerSpace(13.h),
        ],
      ),
    );
  }
}
