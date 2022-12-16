import 'package:flutter/material.dart';
import 'package:othia/core/search/search_pages/search_results/search_results.dart';
import 'package:othia/widgets/filter_related/dropdown_appbar.dart';
import 'package:othia/widgets/filter_related/search_notifier.dart';
import 'package:provider/provider.dart';

class SearchResultsPage extends StatefulWidget {
  @override
  State<SearchResultsPage> createState() => _SearchResultsPage();
}

class _SearchResultsPage extends State<SearchResultsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      primary: true,
      body: Consumer<SearchNotifier>(builder: (context, model, child) {
        return Scaffold(
          primary: true,
          appBar: DropDownAppBar(context: context, appBarTitle: "Search"),
          body: SearchResults(
            searchQuery: Provider.of<SearchNotifier>(context, listen: false)
                .getSearchQuery(),
          ),
        );
      }),
    ));
  }
}
