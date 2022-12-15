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
import 'package:othia/widgets/filter_related/type_filter.dart';
import 'package:provider/provider.dart';

import '../../constants/categories.dart';
import '../../widgets/category_filter/category_filter.dart';
import '../../widgets/filter_related/dropdown_appbar.dart';
import '../../widgets/filter_related/search_notifier.dart';
import '../../widgets/nav_bar/nav_bar.dart';
import '../../widgets/nav_bar/nav_bar_notifier.dart';

class SearchPage extends StatelessWidget {
  late final bool showNavBar;

  SearchPage({Key? key})
      : showNavBar = Get.arguments ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> defaultSelectedCategoryIds =
        categoryIdToSubcategoryIds.keys.toList();
    return SafeArea(
      child: MultiProvider(
          providers: [
            // TODO initialize price range with max price
            ChangeNotifierProvider.value(
              value: SearchNotifier(
                  priceRange: const RangeValues(0, 100),
                  endDate: DateTime(DateTime.now().year + 2),
                  sortCriteria: null,
                  eAType: EAType.eventsActivites,
                  selectedCategoryIds: defaultSelectedCategoryIds),
            ),
            ChangeNotifierProvider.value(value: NavigationBarNotifier()),
          ],
          builder: (context, child) {
            return Consumer<SearchNotifier>(builder: (context, model, child) {
              return Scaffold(
                  primary: true,
                  bottomNavigationBar:
                      showNavBar ? const CustomNavigationBar() : null,
                  appBar:
                      DropDownAppBar(context: context, appBarTitle: "Search"),
                  // here the category pictures
                  body: CategoryFilter(
                    context: context,
                    isModalBottomSheetMode: false,
                  ));
            });
          }),
    );
  }
}
