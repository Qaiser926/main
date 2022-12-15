import 'package:flutter/material.dart';
import 'package:othia/core/favourites/exclusive_widgets/pinned_header.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../constants/categories.dart';
import '../../../modules/models/eA_summary/eA_summary.dart';
import '../../../modules/models/get_search_results_ids/get_search_result_ids.dart';
import '../../../utils/services/data_handling/keep_alive_future_builder.dart';
import '../../../utils/services/exceptions.dart';
import '../../../utils/services/rest-api/rest_api_service.dart';
import '../../../utils/ui/future_service.dart';
import '../../favourites/exclusive_widgets/favourite_list_item.dart';

class SearchScrollView extends StatelessWidget {
  final SearchResultsIds searchResultIds;

  const SearchScrollView({super.key, required this.searchResultIds});

  //TODO implement logic what kind of screen is shown here

  @override
  Widget build(BuildContext context) {
    // criteria here, probably also empty sceen
    Widget child = getFavouriteEventPart(searchResultIds, context);
    return child;
  }

  // Widget getHorizontalDiscovery(){
  //
  // }

  Widget getFavouriteEventPart(
      SearchResultsIds searchResultIds, BuildContext context) {
    List<Widget> slivers = [];
    for (MapEntry<String, List> item
        in searchResultIds.searchResultIds.entries) {
      slivers.add(getSearchResultSliverSection(
          headerText: CategoryIdToI18nMapper.fckMethod(context, item.key),
          Ids: item.value));
    }

    return CustomScrollView(slivers: slivers);
  }

  Widget getSearchResultSliverSection(
      {required final String headerText, required List Ids}) {
    if (Ids.isEmpty) {
      return const SliverToBoxAdapter();
    } else {
      return MultiSliver(
        pushPinnedChildren: true,
        children: [
          SliverPinnedHeader(
            child: getHeader(text: headerText),
          ),
          SliverList(delegate: SliverChildBuilderDelegate((context, index) {
            if (index < Ids.length) {
              Future<Object> eASummary =
                  RestService().getEASummary(id: Ids[index]);
              return KeepAliveFutureBuilder(
                  future: eASummary,
                  builder: (context, snapshot) {
                    try {
                      Map<String, dynamic> decodedJson =
                          snapshotHandler(snapshot);
                      SummaryEventOrActivity eASummary =
                          SummaryEventOrActivity.fromJson(decodedJson);
                      return getFavouriteListItem(context, eASummary);
                    } on StillLoading {
                      //TODO better widget while future still loading
                      return CircularProgressIndicator();
                    }
                  });
            } else {
              return null;
            }
          }))
        ],
      );
    }
  }
}
