import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../modules/models/detailed_event/detailed_event.dart';
import '../../../utils/services/data_handling/data_handling.dart';
import 'event_summary.dart';
import 'get_image_carousel.dart';
import 'icon_row.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

Future<void> _launchUrl(_url) async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}

// Function() function = () => {};
// if (iCalElement != null) {
// function = () =>
// Add2Calendar.addEvent2Cal(iCalElement!);
// }
// return GestureDetector(
// onTap: () => function(),
// child: Row(

Widget? getMoreInformationButton(
    {String? websiteUrl, String? ticketUrl, required BuildContext context}) {
  if (ticketUrl != null) {
    return Expanded(child: Padding(padding: EdgeInsets.all(5), child: ElevatedButton(
        onPressed: () => _launchUrl(ticketUrl),
        child: Text(AppLocalizations.of(context)!.ticket))));
  }
  if (websiteUrl != null) {
    return Expanded(child: Padding(padding: EdgeInsets.all(5), child: ElevatedButton(
        onPressed: () => _launchUrl(websiteUrl),
        child: Text(AppLocalizations.of(context)!.website))));
  }
}

Widget? getCalendarButton({required BuildContext context, Event? iCalElement}) {
  if (iCalElement != null) {
    return Expanded(child: Padding(padding: EdgeInsets.all(5), child: ElevatedButton(
        onPressed: () => Add2Calendar.addEvent2Cal(iCalElement),
        child: Text(AppLocalizations.of(context)!.calendar))));
  }
}

Widget? getShareButton({required BuildContext context, String? shareUrl}) {
  if (shareUrl != null) {
    return Expanded(child: Padding(padding: EdgeInsets.all(5), child: ElevatedButton(
        onPressed: () => Share.share(
            '${AppLocalizations.of(context)!.shareMessage} $shareUrl'),
        child: Text(AppLocalizations.of(context)!.share))),);
  }
}

class ButtonWidget extends StatelessWidget {
  String? websiteUrl;
  String? ticketUrl;
  Event? iCalElement;
  String? shareUrl;

  ButtonWidget(
      {super.key,
      this.websiteUrl,
      this.ticketUrl,
      this.iCalElement,
      this.shareUrl});

  @override
  Widget build(BuildContext context) {
    Widget? moreInformationButton = getMoreInformationButton(
        context: context, ticketUrl: ticketUrl, websiteUrl: websiteUrl);
    Widget? calendarButton =
        getCalendarButton(context: context, iCalElement: iCalElement);
    Widget? shareButton = getShareButton(context: context, shareUrl: shareUrl);
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (moreInformationButton != null) moreInformationButton,
            if (calendarButton!= null) calendarButton,
          if (shareButton != null)  shareButton]
        ));
  }
}
