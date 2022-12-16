import 'package:flutter/material.dart';
import 'package:othia/constants/categories.dart';
import 'package:othia/core/favourites/exclusive_widgets/favourite_list_item.dart';
import 'package:othia/modules/models/eA_summary/eA_summary.dart';
import 'package:othia/modules/models/get_search_results_ids/get_search_result_ids.dart';
import 'package:othia/utils/services/data_handling/keep_alive_future_builder.dart';
import 'package:othia/utils/services/exceptions.dart';
import 'package:othia/utils/services/rest-api/rest_api_service.dart';
import 'package:othia/utils/ui/future_service.dart';
import 'package:othia/widgets/discover_horizontally.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SearchScrollView extends StatelessWidget {
  final SearchResultIds searchResultIds;
  late Widget child;

  SearchScrollView({super.key, required this.searchResultIds});

  @override
  Widget build(BuildContext context) {
    bool showHorizontal = getShowHorizontal(searchResultIds: searchResultIds);
    if (showHorizontal) {
      child = getHorizontalDiscovery(searchResultIds, context);
    } else {
      child = getVerticalDiscovery(searchResultIds, context);
    }
    return child;
  }

  bool getShowHorizontal({required SearchResultIds searchResultIds}) {
    if (searchResultIds.searchResultIds.length > 1) {
      return true;
    } else {
      return false;
    }
  }

  Widget getHorizontalDiscovery(
      SearchResultIds searchResultIds, BuildContext context) {
    return ListView.builder(
        itemCount: searchResultIds.searchResultIds.length,
        itemBuilder: (BuildContext context, int index) {
          String key = searchResultIds.searchResultIds.keys.elementAt(index);
          bool showDivider = true;
          if (index == 0) showDivider = false;
          return BaseDiscoveryClass(
            Ids: searchResultIds.searchResultIds[key]!,
            caption: CategoryIdToI18nMapper.getCategoryName(context, key),
            showDivider: showDivider,
          );
        });
  }

  Widget getVerticalDiscovery(
      SearchResultIds searchResultIds, BuildContext context) {
    List<Widget> slivers = [];
    for (MapEntry<String, List> item
        in searchResultIds.searchResultIds.entries) {
      slivers.add(getSearchResultSliverSection(
          headerText: CategoryIdToI18nMapper.getCategoryName(context, item.key),
          Ids: item.value));
    }

    return CustomScrollView(slivers: slivers);
  }
}

Widget getSearchResultSliverSection(
    {required final String headerText, required List Ids}) {
  if (Ids.isEmpty) {
    return const SliverToBoxAdapter();
  } else {
    return MultiSliver(
      pushPinnedChildren: true,
      children: [
        // SliverPinnedHeader(
        //   child: getHeader(text: headerText),
        // ),
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