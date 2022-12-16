import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/services/rest-api/rest_api_service.dart';
import '../modules/models/eA_summary/eA_summary.dart';
import '../utils/services/data_handling/keep_alive_future_builder.dart';
import '../utils/ui/future_service.dart';
import '../utils/ui/ui_utils.dart';
import 'discovery_card.dart';

class BaseDiscoveryClass extends StatelessWidget {
  final List<String?> Ids;
  final String heading;
  bool showDivider;
  bool showMore;

  BaseDiscoveryClass(
      {super.key,
      required this.Ids,
      required this.heading,
      this.showDivider = true,
      this.showMore = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showDivider)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Column(
              children: [
                Divider(thickness: 3.h),
                getVerSpace(25),
              ],
            ),
          ),
        if (!showDivider) getVerSpace(10.h),
        Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 12, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  heading,
                  style: Theme.of(context).textTheme.headline2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (showMore)
                  TextButton(
                      onPressed: () => print(111111111112222222),
                      child: Text("show More"))
              ],
            )),
        getVerSpace(25),
        if (!Ids.isEmpty) HorizontalEADiscovery(Ids: Ids),
        if (Ids.isEmpty) getNoResultsMessage(context),
      ],
    );
  }
}

Widget getNoResultsMessage(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.noResultsFound,
              style: Theme.of(context).textTheme.headline4,
            ),
            getVerSpace(55),
          ],
        )
      ],
    ),
  );
}

class HorizontalEADiscovery extends StatelessWidget {
  final List<String?> Ids;

  const HorizontalEADiscovery({super.key, required this.Ids});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200.h,
        child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: Ids.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              late Future<Object> response =
                  RestService().getEASummary(id: Ids[index]);
              return KeepAliveFutureBuilder(
                  future: response,
                  builder: (context, snapshot) {
                    return snapshotHandler(
                        snapshot, getFutureFulfilledContent, [index]);
                  });
            }));
  }

  Widget getFutureFulfilledContent(
      int index, Map<String, dynamic> decodedJson) {
    SummaryEventOrActivity eASummary =
        SummaryEventOrActivity.fromJson(decodedJson);
    return EASummaryCard(
      eASummary: eASummary,
      index: index,
    );
  }
}
