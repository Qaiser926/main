// import 'dart:convert';
// import 'package:amplify_api/amplify_api.dart';
// import 'package:flutter/material.dart';
//
// import '../../modules/models/favourite_event_and_activity/favourite_events_and_activities.dart';
//
// import '../../utils/services/rest-api/rest_api_service.dart';
//
// import '../../widgets/splash_screen.dart';
//
//
// class SearchPage extends StatefulWidget {
//   const SearchPage({Key? key}) : super(key: key);
//
//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }
//
// class _SearchPageState extends State<SearchPage>
//     with SingleTickerProviderStateMixin {
//   late final TabController _tabController;
//   late final ScrollController _scrollController;
//   late Future<Object> future;
//   PageController pageController = PageController(
//     initialPage: 0,
//   );
//
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return;
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:othia/core/search_results/search_results.dart';
import 'package:provider/provider.dart';

import '../../constants/app_constants.dart';
import '../../widgets/filter_related/dropdown_appbar.dart';
import '../../widgets/filter_related/search_notifier.dart';

class SearchResultsPage extends StatefulWidget {
  @override
  State<SearchResultsPage> createState() => _HorizontalResultPage();
}

class _HorizontalResultPage extends State<SearchResultsPage> {
  late SearchQuery searchQuery;
  late FilterState filterState;

  void backClick() {
    NavigatorConstants.backToPrev();
  }

  @override
  void initState() {
    searchQuery = Get.arguments[0];
    filterState = Get.arguments[1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: SearchNotifier(
                  priceRange:
                      RangeValues(searchQuery.minPrice, searchQuery.maxPrice),
                  endDate: searchQuery.endDate,
                  startDate: searchQuery.startDate,
                  sortCriteria: searchQuery.sortCriteria,
                  eAType: searchQuery.eAType,
                  selectedCategoryIds: searchQuery.selectedCategoryIds,
                  pageState: PageState.resultScreen),
            ),
          ],
          builder: (context, child) {
            Provider.of<SearchNotifier>(context, listen: false)
                .setFilterState(filterState);
            return Scaffold(
              primary: true,
              body: Consumer<SearchNotifier>(builder: (context, model, child) {
                // if (model.isShowResults()) {
                //   Navigator.pushNamed(context, Routes.detailedEventRoute);
                // }
                return Scaffold(
                  primary: true,
                  appBar:
                      DropDownAppBar(context: context, appBarTitle: "Search"),
                  body: SearchResults(
                    searchQuery: searchQuery,
                  ),
                );
              }),
            );
          }),
    );
  }
}
