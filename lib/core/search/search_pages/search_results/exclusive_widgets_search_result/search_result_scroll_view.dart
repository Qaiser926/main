import 'package:flutter/material.dart';
import 'package:othia/constants/categories.dart';
import 'package:othia/modules/models/get_search_results_ids/get_search_result_ids.dart';
import 'package:othia/widgets/horizontal_discovery/discover_horizontally.dart';
import 'package:othia/widgets/vertical_discovery/vertical_discovery_framework.dart';

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
            caption:
                CategoryIdToI18nMapper.getCategorySubcategoryName(context, key),
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
          Ids: item.value));
    }

    return CustomScrollView(slivers: slivers);
  }
}


