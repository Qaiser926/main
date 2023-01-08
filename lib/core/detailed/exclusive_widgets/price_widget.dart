import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../modules/models/shared_data_models.dart';
import '../../../utils/services/data_handling/data_handling.dart';
import '../../../utils/ui/ui_utils.dart';

Future<void> _launchUrl(_url) async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}

class PriceWidget extends StatelessWidget {
  String? websiteUrl;
  String? ticketUrl;
  List<Price>? prices;
  Status? status;

  PriceWidget(
      {super.key, this.prices, this.websiteUrl, this.ticketUrl, this.status});

  @override
  Widget build(BuildContext context) {
    Function() function = () => {};
    if (ticketUrl != null) {
      function = () => _launchUrl(ticketUrl);
    } else if (websiteUrl != null) {
      function = () => _launchUrl(websiteUrl);
    }
    String priceText = getPriceText(context: context, prices: prices);
    if ((status != null) & (prices != null)) {
      priceText = priceText + getTicketStatus(context: context, status: status);
    }
    return GestureDetector(
      onTap: () => function(),
      child: Row(
        children: [
          Icon(
            Typicons.tag,
            size: 17.h,
          ),
          getHorSpace(5.h),
          Text(
            priceText,
            style: Theme.of(context).textTheme.bodyText2,
            maxLines: 1,
          )
        ],
      ),
    );
  }
}
