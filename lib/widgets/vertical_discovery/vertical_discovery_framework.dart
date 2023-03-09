import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/modules/models/eA_summary/eA_summary.dart';
import 'package:othia/utils/services/rest-api/rest_api_service.dart';
import 'package:othia/utils/ui/future_service.dart';
import 'package:othia/widgets/action_buttons.dart';
import 'package:othia/widgets/keep_alive_future_builder.dart';
import 'package:othia/widgets/vertical_discovery/favourite_list_item.dart';
import 'package:othia/widgets/vertical_discovery/pinned_header.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../utils/services/events/example_event.dart';
import '../../utils/services/global_navigation_notifier.dart';

Widget buildVerticalDiscovery(
    {required List Ids,
    String? caption,
    required ActionButtonType actionButtonType}) {
  if (Ids.isEmpty) {
    return const SliverToBoxAdapter();
  } else {
    return MultiSliver(
      pushPinnedChildren: true,
      children: [
        if (caption != null)
          SliverPinnedHeader(
            child: getHeader(text: caption),
          ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            if (index < Ids.length) {
              Future<Object> eASummary =
                  RestService().getEASummary(id: Ids[index]);
              return KeepAliveFutureBuilder(
                  future: eASummary,
                  builder: (context, snapshot) {
                    
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return Center(child:defaultStillLoadingWidget);
                    }
                    if(snapshot.hasData){
                    return snapshotHandler(
                        context,
                        snapshot,
                        getFutureVerticalDiscovery,
                        [context, actionButtonType]);
                         }else{
                    return Center(child: Text("No Data Exit"),);
                  }
                  });
            } else {
              return null;
            }
          }),
        )
      ],
    );
  }
}

Widget getFutureVerticalDiscovery(
  BuildContext context,
  ActionButtonType actionButtonType,
  Map<String, dynamic> decodedJson,
) {
  SummaryEventOrActivity eASummary =
      SummaryEventOrActivity.fromJson(decodedJson);
  Widget actionButton = getActionButton(
      actionButtonType: actionButtonType,
      eASummary: eASummary,
      context: context);
  return VisibilityDetector(
      key: Key(eASummary.id),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction >= 0.85) {
          recordCustomEvent(
              eventName: "summaryShown",
              eventParams: {"eAId": eASummary.id},
              userId:
                  Provider.of<GlobalNavigationNotifier>(context, listen: false)
                      .userId);
        }
      },
      child: getVerticalSummary(
          context: context, eASummary: eASummary, actionButton: actionButton));
}
