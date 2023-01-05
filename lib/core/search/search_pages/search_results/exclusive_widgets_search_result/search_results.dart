import 'package:flutter/material.dart';
import 'package:othia/widgets/filter_related/notifiers/search_notifier.dart';
import 'package:provider/provider.dart';

import '../../../../../modules/models/get_search_results_ids/get_search_result_ids.dart';
import '../../../../../utils/ui/future_service.dart';
import 'search_result_scroll_view.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({Key? key}) : super(key: key);

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<SearchResults> {
  late Future<Object> searchResults;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    searchResults = Provider.of<SearchNotifier>(context, listen: false)
        .getSearchQueryResult();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: searchResults,
        builder: (context, snapshot) {
          return snapshotHandler(snapshot, getFutureFulfilledContent, []);
        });
  }

  Widget getFutureFulfilledContent(Map<String, dynamic> json) {
    SearchResultIds searchResultIds = SearchResultIds.fromJson(json);
    return SearchScrollView(
      searchResultIds: searchResultIds,
    );
  }
}
