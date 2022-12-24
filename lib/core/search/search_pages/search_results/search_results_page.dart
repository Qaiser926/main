import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:othia/core/search/search_pages/search_results/exclusive_widgets_search_result/search_results.dart';
import 'package:othia/widgets/filter_related/dropdown_appbar.dart';
import 'package:othia/widgets/filter_related/notifiers/search_notifier.dart';
import 'package:othia/widgets/filter_related/search_filter.dart';
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
          appBar: DropDownAppBar(
              filter:
                  Consumer<SearchNotifier>(builder: (context, model, child) {
                    return SearchFilter(
                  context: context,
                        dynamicProvider:
                            Provider.of<SearchNotifier>(context, listen: false)).buildDropdownBar();
              }),
              context: context,
              appBarTitle: AppLocalizations.of(context)!.results),
          body: SearchResults(
            searchQuery: Provider.of<SearchNotifier>(context, listen: false)
                .getSearchQuery(),
          ),
        );
      }),
    ));
  }
}
