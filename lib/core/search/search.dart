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

import '../../modules/models/favourite_event_and_activity/favourite_events_and_activities.dart';

import '../../utils/services/rest-api/rest_api_service.dart';

import '../../widgets/dropdown_appbar.dart';
import '../../widgets/splash_screen.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    {

  late Future<Object> future;


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {


              return SafeArea(
                child: Scaffold(
                    primary: true,
                    appBar: DropDownAppBar(context: context, appBarTitle: "Search"),
                    // here the category pictures
                    body: SizedBox(height: 100,)),
              );

  }
}
