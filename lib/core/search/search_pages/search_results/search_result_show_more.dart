import 'package:flutter/material.dart';
import 'package:othia/core/search/search_pages/search_results/exclusive_widgets_search_result/search_result_scroll_view.dart';
import 'package:othia/widgets/filter_related/dropdown_appbar.dart';
import 'package:othia/widgets/filter_related/search_notifier.dart';
import 'package:provider/provider.dart';

class SearchResultShowMore extends StatefulWidget {
  @override
  State<SearchResultShowMore> createState() => _SearchResultShowMore();
}

class _SearchResultShowMore extends State<SearchResultShowMore> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            primary: true,
            body: Consumer<SearchNotifier>(builder: (context, model, child) {
              return Scaffold(
                  primary: true,
                  appBar:
                      DropDownAppBar(context: context, appBarTitle: "Search"),
                  body: CustomScrollView(slivers: [
                    getSearchResultSliverSection(
                      headerText: model.showMoreCaption,
                      Ids: model.showMoreIds,
                    )
                  ]));
            })));
  }
}
