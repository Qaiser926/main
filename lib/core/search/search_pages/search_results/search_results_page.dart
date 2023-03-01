import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:othia/core/main_page.dart';
import 'package:othia/core/search/search_pages/search_results/exclusive_widgets_search_result/search_results.dart';
import 'package:othia/widgets/filter_related/filter_frameworks/dropdown_appbar.dart';
import 'package:othia/widgets/filter_related/filter_frameworks/search_filter.dart';
import 'package:othia/widgets/filter_related/notifiers/search_notifier.dart';
import 'package:othia/widgets/nav_bar/nav_bar_notifier.dart';
import 'package:provider/provider.dart';

class SearchResultsPage extends StatefulWidget {
  @override
  State<SearchResultsPage> createState() => _SearchResultsPage();
}

class _SearchResultsPage extends State<SearchResultsPage> {
  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.setCurrentScreen(
      screenName: 'searchResultScreen',
    );
    return SafeArea(
        child: Scaffold(
      primary: true,
      body: Consumer<SearchNotifier>(builder: (context, model, child) {
        return Scaffold(
          primary: true,
          appBar: DropDownAppBar(
            filter: Consumer<SearchNotifier>(builder: (context, model, child) {
              return SearchFilter(
                      context: context,
                      dynamicProvider:
                          Provider.of<SearchNotifier>(context, listen: false))
                          .buildDropdownBar();
                    }),
                context: context,
                appBarTitle: AppLocalizations.of(context)!.results,
                onBackPressed: getOnBackPressedFunction(context),
              ),
              body: SearchResults(),
            );
          }),
        ));
  }
}

Function getOnBackPressedFunction(BuildContext context) {
  return () {
    closeAppDialog(
        context, Provider.of<NavigationBarNotifier>(context, listen: false));
  };
}
