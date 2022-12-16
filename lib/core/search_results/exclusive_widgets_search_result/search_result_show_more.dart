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
import 'package:othia/constants/app_constants.dart';
import 'package:othia/core/search_results/exclusive_widgets_search_result/search_result_scroll_view.dart';
import 'package:othia/widgets/filter_related/dropdown_appbar.dart';
import 'package:othia/widgets/filter_related/search_notifier.dart';
import 'package:provider/provider.dart';

import '../../../widgets/nav_bar/nav_bar.dart';

class SearchResultsAll extends StatefulWidget {
  @override
  State<SearchResultsAll> createState() => _HorizontalResultPage();
}

class _HorizontalResultPage extends State<SearchResultsAll> {
  late SearchQuery searchQuery;
  late FilterState filterState;
  late List<String> resultIds;
  late String caption;

  void backClick() {
    NavigatorConstants.backToPrev();
  }

  @override
  void initState() {
    searchQuery = Get.arguments[NavigatorConstants.SearchQueryIndex];
    filterState = Get.arguments[NavigatorConstants.FilterStateIndex];
    resultIds = Get.arguments[NavigatorConstants.ResultIdsIndex];
    caption = Get.arguments[NavigatorConstants.CaptionIndex];
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
          // ChangeNotifierProvider.value(
          //   value: NavigationBarNotifier(),
          // ),
        ],
            builder: (context, child) {
              Provider.of<SearchNotifier>(context, listen: false)
                  .setFilterState(filterState);
              return Scaffold(
                  primary: true,
                  bottomNavigationBar: const CustomNavigationBar(),
                  body: Consumer<SearchNotifier>(
                      builder: (context, model, child) {
                    return Scaffold(
                        primary: true,
                        appBar: DropDownAppBar(
                            context: context, appBarTitle: "Search"),
                        body: getSearchResultSliverSection(
                            headerText: caption, Ids: resultIds));
                  }));
            }));
  }
}
