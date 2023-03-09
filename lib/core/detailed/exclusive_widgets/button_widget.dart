import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/utils/helpers/diverse.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/services/events/example_event.dart';

Future<void> _launchUrl(_url) async {
  recordCustomEvent(eventName: "userOpensUrl", eventParams: {"url": _url});
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}

String removeHttp(String url) {
  RegExp regExp = new RegExp(
    r"^https?://",
    caseSensitive: false,
    multiLine: false,
  );
  RegExpMatch? match = regExp.firstMatch(url);
  return url.substring(match?.end ?? 0);
}

Widget? getMoreInformationButton(
    {String? websiteUrl, String? ticketUrl, required BuildContext context}) {
  if (ticketUrl != null) {
    return Expanded(
        child: Padding(
            padding: EdgeInsets.all(5),
            child: ElevatedButton(
                onPressed: () {
                  String websiteWithoutHttp = removeHttp(ticketUrl);
                  launchUrl(Uri.parse("https://" + websiteWithoutHttp));
                },
                child: Text(
                  AppLocalizations.of(context)!.ticket,
                  textAlign: TextAlign.center,
                ))));
  }
  if (websiteUrl != null) {
    return Expanded(
        child: Padding(
            padding: EdgeInsets.all(5),
            child: ElevatedButton(
                onPressed: () {
                  String websiteWithoutHttp = removeHttp(websiteUrl);
                  launchUrl(Uri.parse("https://" + websiteWithoutHttp));
                },
                child: Text(
                  AppLocalizations.of(context)!.website,
                  textAlign: TextAlign.center,
                ))));
  }
}

Widget? getCalendarButton(
    {required BuildContext context, Event? iCalElement, required String eAId}) {
  if (iCalElement != null) {
    return Expanded(
        child: Padding(
            padding: EdgeInsets.all(5),
            child: ElevatedButton(
                onPressed: () {
                  recordCustomEvent(
                      eventName: "addToCalendar", eventParams: {"eAId": eAId});
                  Add2Calendar.addEvent2Cal(iCalElement);
                },
                child: Text(AppLocalizations.of(context)!.calendar))));
  }
}

Widget? getShareButton(
    {required BuildContext context, String? shareUrl, required String eAId}) {
  if (shareUrl != null) {
    return Expanded(
      child: Padding(
          padding: EdgeInsets.all(5),
          child: ElevatedButton(
              onPressed: () {
                openShare(
                    '${AppLocalizations.of(context)!.shareMessage} $shareUrl',
                    context);
                   recordCustomEvent(
                    eventName: "userShares", eventParams: {"eAId": eAId});
              },
              child: Text(AppLocalizations.of(context)!.share))),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  String? websiteUrl;
  String? ticketUrl;
  Event? iCalElement;
  String? shareUrl;
  String eAId;

  ButtonWidget(
      {super.key,
      required this.eAId,
      this.websiteUrl,
      this.ticketUrl,
      this.iCalElement,
      this.shareUrl});

  @override
  Widget build(BuildContext context) {
    Widget? moreInformationButton = getMoreInformationButton(
        context: context, ticketUrl: ticketUrl, websiteUrl: websiteUrl);
    Widget? calendarButton = getCalendarButton(
        context: context, iCalElement: iCalElement, eAId: eAId);
    Widget? shareButton =
        getShareButton(context: context, shareUrl: shareUrl, eAId: eAId);
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          if (moreInformationButton != null) moreInformationButton,
          if (calendarButton != null) calendarButton,
          if ((shareButton != null) &
              ((moreInformationButton == null) | (calendarButton == null)))
            shareButton!
        ]));
  }
}
