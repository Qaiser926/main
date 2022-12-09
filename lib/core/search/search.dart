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

import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/categorization_filter.dart';
import '../../widgets/filter_related/search_notifier.dart';
import '../../widgets/filter_related/dropdown_appbar.dart';

class SearchPage extends StatelessWidget {
  late Future<Object> future;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiProvider(
          providers: [
            // TODO initialize price range with max price
            ChangeNotifierProvider.value(
              value: SearchNotifier(priceRange: RangeValues(0, 100)),
            )
          ],
          builder:(context,child){return  Scaffold(
            primary: true,
            appBar: DropDownAppBar(context: context, appBarTitle: "Search"),
            // here the category pictures
            body: CategoryFilter(),
          );}),
    );
  }

  // Widget getSearchScreen() {
  //   return Consumer<SearchNotifier>(builder: (context, model, child) {
  //     // if (model.isShowResults()) {
  //     //   // differentiate here between search results (show different screen if nothing was found)
  //     //   return Text("${model.getPriceRange.toString()}");
  //     // } else {
  //       // here the category screen in the beginning
  //       return ;
  //     // }
  //   });
  // }
}
