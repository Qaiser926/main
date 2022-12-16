import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:othia/utils/services/rest-api/rest_api_service.dart';
import 'package:othia/widgets/filter_related/search_notifier.dart';

import '../../../../modules/models/get_search_results_ids/get_search_result_ids.dart';
import '../../../../widgets/splash_screen.dart';
import 'exclusive_widgets_search_result/search_result_scroll_view.dart';

class SearchResults extends StatefulWidget {
  final SearchQuery searchQuery;

  const SearchResults({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<SearchResults> {
  late Future<Object> future;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    future = RestService().getSearchResultIds(searchQuery: widget.searchQuery);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // here maybe not future builder if forwareded via showMore
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const SplashScreen();
          } else {
            if (snapshot.hasError) {
              throw Exception(snapshot.error);
            } else {
              RestResponse data = snapshot.data as RestResponse;

              Map<String, dynamic> json = jsonDecode(data.body);
              SearchResultIds searchResultIds = SearchResultIds.fromJson(json);
              return SearchScrollView(
                searchResultIds: searchResultIds,
              );
            }
          }
        });
  }
}
