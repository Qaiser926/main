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
import 'package:othia/core/search/search_results.dart';
import 'package:othia/widgets/filter_related/type_filter.dart';
import 'package:provider/provider.dart';

import '../../widgets/category_filter/category_filter.dart';
import '../../widgets/filter_related/dropdown_appbar.dart';
import '../../widgets/filter_related/search_notifier.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiProvider(
          providers: [
            // TODO initialize price range with max price & write function that returns category ids
            ChangeNotifierProvider.value(
              value: SearchNotifier(
                  priceRange: const RangeValues(0, 100),
                  endDate: DateTime(DateTime.now().year + 2),
                  sortCriteria: null,
                  eAType: EAType.eventsActivites,
                  selectedCategoryIds: ["sf"]),
            )
          ],
          builder: (context, child) {
            return Consumer<SearchNotifier>(builder: (context, model, child) {
              // if (model.isShowResults()) {
              //   Navigator.pushNamed(context, Routes.detailedEventRoute);
              // }
              return Scaffold(
                  primary: true,
                  appBar:
                      DropDownAppBar(context: context, appBarTitle: "Search"),
                  // here the category pictures
                  body: getSearchScreen()

                  // CategoryFilter(
                  //   context: context,
                  //   isModalBottomSheetMode: false,
                  // ),
                  );
            });
          }),
    );
  }

  Widget getSearchScreen() {
    return Consumer<SearchNotifier>(builder: (context, model, child) {
      if (model.isShowResults()) {
        // differentiate here between search results (show different screen if nothing was found)
        return SearchResults(
          searchQuery: model.getSearchQuery(),
        );
      } else {
        return CategoryFilter(
          context: context,
          isModalBottomSheetMode: false,
        );
        // }
      }
    });
  }
}
