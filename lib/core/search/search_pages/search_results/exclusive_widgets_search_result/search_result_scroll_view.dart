import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:othia/constants/categories.dart';
import 'package:othia/modules/models/get_search_results_ids/get_search_result_ids.dart';
import 'package:othia/widgets/action_buttons.dart';
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

  SearchResultIds orderEmptyIds(SearchResultIds searchResultIds) {
    Map<String, List<String?>> nonEmptyIds = {};
    Map<String, List<String?>> emptyIds = {};
    searchResultIds.searchResultIds.forEach((key, value) {
      if (value.isNotEmpty) {
        nonEmptyIds[key] = value;
      } else {
        emptyIds[key] = value;
      }
    });
    Map<String, List<String?>> orderedIds = {}
      ..addAll(nonEmptyIds)
      ..addAll(emptyIds);
    searchResultIds.searchResultIds = orderedIds;
    return searchResultIds;
  }

  Widget getHorizontalDiscovery(
      SearchResultIds unfilteredSearchResultIds, BuildContext context) {
    SearchResultIds searchResultIds = orderEmptyIds(unfilteredSearchResultIds);
    return 
    ListView.builder(
        itemCount: unfilteredSearchResultIds.searchResultIds.length,
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
    bool allResultsEmpty = true;
    for (MapEntry<String, List> item
        in searchResultIds.searchResultIds.entries) {
      if (item.value.isNotEmpty) {
        allResultsEmpty = false;
      }
      slivers.add(buildVerticalDiscovery(
          actionButtonType: ActionButtonType.addLikeButton, Ids: item.value));
    }

    return allResultsEmpty
        ? Container(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(AppLocalizations.of(context)!.noResultsFound),
            ),
          )
        : CustomScrollView(slivers: slivers);
  }
}
