import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/core/home/exclusive_widgets/map_picture.dart';
import 'package:othia/modules/models/get_home_page_ids/get_home_page_ids.dart';
import 'package:othia/utils/services/rest-api/rest_api_service.dart';
import 'package:othia/utils/ui/future_service.dart';
import 'package:othia/widgets/horizontal_discovery/discover_horizontally.dart';
import 'package:othia/widgets/keep_alive_future_builder.dart';

import '../../utils/get_user_time.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Object> futureHomePageIds;

  @override
  void initState() {
    futureHomePageIds = RestService().getHomePageIds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                toolbarHeight: 53.h,
                elevation: 0,
                title: Text(
                  AppLocalizations.of(context)!.home,
                ),
                centerTitle: true,
                automaticallyImplyLeading: false),
            body: HomePageFutureBuilder()));
  }

  Widget HomePageFutureBuilder() {
    return KeepAliveFutureBuilder(
        future: futureHomePageIds,
        builder: (context, snapshot) {
          return snapshotHandler(context, snapshot, getHomePage, []);
        });
  }

  Widget getHomePage(Map<String, dynamic> jsonData) {
    HomePageIds homePageIds = HomePageIds.fromJson(jsonData);
    findFreeTimes().then((freeTimes) {
      // Do something with the free times
    }).catchError((error) {
      // Handle any errors that occurred while finding free times
    });
    return SingleChildScrollView(
        child: Column(
      children: [
        MapPicture(),
        Container(
          child: BaseDiscoveryClass(
            caption: AppLocalizations.of(context)!.compingUpEvents,
            Ids: homePageIds.compingUpEvents,
            showMore: false,
            isInfoButtonActivated: true,
          ),
        ),
        BaseDiscoveryClass(
            caption: AppLocalizations.of(context)!.openActivities,
            Ids: homePageIds.openActivities,
            showMore: false,
            isInfoButtonActivated: true),
        BaseDiscoveryClass(
          caption: AppLocalizations.of(context)!.popularEvents,
          Ids: homePageIds.popularEvents,
          showMore: false,
        ),
        BaseDiscoveryClass(
          caption: AppLocalizations.of(context)!.popularActivities,
          Ids: homePageIds.popularActivities,
          showMore: false,
        ),
        BaseDiscoveryClass(
          caption: AppLocalizations.of(context)!.universityEvents,
          Ids: homePageIds.universityEvents,
          showMore: false,
        ),
      ],
    ));
  }
}
