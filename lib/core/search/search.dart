import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:othia/core/search/search_pages/initial_search_page.dart';
import 'package:othia/core/test.dart';
import 'package:othia/widgets/nav_bar/nav_bar_notifier.dart';
import 'package:provider/provider.dart';

import '../../widgets/filter_related/search_notifier.dart';

class SearchPage extends StatefulWidget {
  static final List<Widget> _pages = [
    // TODO insert HOME instead of EventDetail
    InitialSearchPage(),
    TestPage2()
  ];

  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin<SearchPage> {
  late SearchNotifier notifier;
  late PageController _pageController;

  @override
  void initState() {
    notifier = Provider.of<NavigationBarNotifier>(context, listen: false)
        .getSearchNotifier;
    _pageController = notifier.getPageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: notifier,
          )
        ],
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: SearchPage._pages,
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// // import 'dart:convert';
// // import 'package:amplify_api/amplify_api.dart';
// // import 'package:flutter/material.dart';
// //
// // import '../../modules/models/favourite_event_and_activity/favourite_events_and_activities.dart';
// //
// // import '../../utils/services/rest-api/rest_api_service.dart';
// //
// // import '../../widgets/splash_screen.dart';
// //
// //
// // class SearchPage extends StatefulWidget {
// //   const SearchPage({Key? key}) : super(key: key);
// //
// //   @override
// //   State<SearchPage> createState() => _SearchPageState();
// // }
// //
// // class _SearchPageState extends State<SearchPage>
// //     with SingleTickerProviderStateMixin {
// //   late final TabController _tabController;
// //   late final ScrollController _scrollController;
// //   late Future<Object> future;
// //   PageController pageController = PageController(
// //     initialPage: 0,
// //   );
// //
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return;
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:othia/widgets/filter_related/type_filter.dart';
// import 'package:provider/provider.dart';
//
// import '../../constants/categories.dart';
// import '../../widgets/category_filter/category_filter.dart';
// import '../../widgets/filter_related/dropdown_appbar.dart';
// import '../../widgets/filter_related/search_notifier.dart';
// import '../../widgets/nav_bar/nav_bar_notifier.dart';
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
