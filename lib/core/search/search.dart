import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:othia/constants/no_internet.dart';
import 'package:othia/core/search/search_pages/initial_search_page.dart';
import 'package:othia/widgets/nav_bar/nav_bar_notifier.dart';
import 'package:provider/provider.dart';

import '../../widgets/filter_related/notifiers/search_notifier.dart';
import 'search_pages/search_results/search_result_show_more.dart';
import 'search_pages/search_results/search_results_page.dart';

class SearchPage extends StatefulWidget {
  static final List<Widget> _pages = [
    InitialSearchPage(),
    SearchResultsPage(),
    SearchResultShowMore(),
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
  final connectivity=Connectivity();

  @override
  Widget build(BuildContext context) {
    return    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: notifier,
        )
      ],
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: SearchPage._pages,
      ),
      
      
      );
              
    
              
    
   
  }

  @override
  bool get wantKeepAlive => true;
}

