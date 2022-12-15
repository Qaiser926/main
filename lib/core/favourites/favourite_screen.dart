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
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<FavouritePage> {
  late final TabController _tabController;
  late Future<Object> future;

  @override
  bool get wantKeepAlive => true;

  get favouriteEventAndActivity => favouriteEventAndActivity;

  @override
  void initState() {
    future = RestService().fetchFavouriteEventsAndActivities();
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return
        // KeepAlive(
        //   keepAlive: true,
        //   child:
        SafeArea(
      child: Scaffold(
        primary: true,
        appBar: FavouriteAppBar(
          tabController: _tabController,
          context: context,
        ),
        body: FutureBuilder(
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
                  return FavouriteScrollView(
                    tabController: _tabController,
                    favouriteEventAndActivity: favouriteEventAndActivity,
                  );
                }
              }
            }),
      ),
      // ),
    );
  }
}
