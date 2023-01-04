import 'package:flutter/material.dart';
import 'package:othia/modules/models/eA_summary/eA_summary.dart';
import 'package:othia/utils/services/data_handling/keep_alive_future_builder.dart';
import 'package:othia/utils/services/rest-api/rest_api_service.dart';
import 'package:othia/utils/ui/future_service.dart';
import 'package:othia/widgets/action_buttons.dart';
import 'package:othia/widgets/vertical_discovery/favourite_list_item.dart';
import 'package:othia/widgets/vertical_discovery/pinned_header.dart';
import 'package:sliver_tools/sliver_tools.dart';

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
                    return snapshotHandler(snapshot, getFutureVerticalDiscovery,
                        [context, actionButtonType]);
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
  return getFavouriteListItem(
      context: context, eASummary: eASummary, actionButton: actionButton);
}
