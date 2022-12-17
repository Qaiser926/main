import 'package:flutter/material.dart';
import 'package:othia/widgets/not_logged_in.dart';

import '../../modules/models/favourite_event_and_activity/favourite_events_and_activities.dart';
import '../../utils/services/rest-api/rest_api_service.dart';
import '../../utils/ui/future_service.dart';
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

  //TODO once we can get account from amazon
  bool isLoggedIn = true;

  @override
  bool get wantKeepAlive => true;

  get favouriteEventAndActivity => favouriteEventAndActivity;

  @override
  void initState() {
    // TODO decide if logged in or not
    future = RestService().fetchFavouriteEventsAndActivities();
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  Widget getLoggedInBody() {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          return snapshotHandler(snapshot, futureFulfilledWidget, []);
        });
  }

  @override
  Widget build(BuildContext context) {
    Widget body = getLoggedInSensitiveBody(
        isLoggedIn: isLoggedIn,
        loggedInWidget: getLoggedInBody(),
        context: context);
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
        body: body,
      ),
        // ),
      );
  }

  Widget futureFulfilledWidget(Map<String, dynamic> json) {
    String body = """{
              "futureEvents": {},
              "pastEvents":{},
              "openActivities":{},
              "closedActivities":{}
              }""";
    FavouriteEventsAndActivities favouriteEventAndActivity =
        FavouriteEventsAndActivities.fromJson(json);
    return FavouriteScrollView(
      tabController: _tabController,
      favouriteEventAndActivity: favouriteEventAndActivity,
    );
  }
}
