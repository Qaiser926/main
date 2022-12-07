import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';

import '../../modules/models/favourite_event_and_activity/favourite_events_and_activities.dart';

import '../../utils/services/rest-api/rest_api_service.dart';

import '../../widgets/splash_screen.dart';

import 'exclusive_widgets/app_bar.dart';
import 'exclusive_widgets/favourite_scroll_view.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final ScrollController _scrollController;
  late Future<Object> future;

  get favouriteEventAndActivity => favouriteEventAndActivity;

  @override
  void initState() {
    future = RestService().fetchFavouriteEventsAndActivities();
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const SplashScreen();
          } else {
            if (snapshot.hasError) {
              throw Exception(snapshot.error);
            } else {
              RestResponse data = snapshot.data as RestResponse;

              String body = """{
              "futureEvents": {},
              "pastEvents":{},
              "openActivities":{},
              "closedActivities":{}
              }""";
              Map<String, dynamic> json = jsonDecode(data.body);
              FavouriteEventsAndActivities favouriteEventAndActivity =
                  FavouriteEventsAndActivities.fromJson(json);

              return SafeArea(
                child: Scaffold(
                  primary: true,
                  appBar: FavouriteAppBar(
                    tabController: _tabController,
                    context: context,
                  ),
                  body: FavouriteScrollView(
                    scrollController: _scrollController,
                    tabController: _tabController,
                    favouriteEventAndActivity: favouriteEventAndActivity,
                  ),
                ),
              );
            }
          }
        });
  }
}
