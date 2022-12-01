import 'dart:convert';
import 'dart:ui';
import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/constants/asset_constants.dart';
import 'package:othia/core/favourites/page_view/page_view.dart';
import '../../config/themes/color_data.dart';
import '../../modules/models/favourite_event_and_activity/favourite_events_and_activities.dart';
import '../../utils/services/rest-api/rest_api_service.dart';
import '../../utils/ui/ui_utils.dart';
import '../../widgets/splash_screen.dart';


class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var _scrollController;

  // TODO align for different languages
  final String activityDescription = "Aktivität";
  final String eventDescription = "Event";
  final String appBarName = "Favoriten";
  final String futureEvents = "Zukünftige Events";
  final String pastEvents = "Vergangene Events";
  final String openActivities = "Derzeit geöffnete Akitivitäten";
  final String closedActivities = "Derzeit geschlossene Aktivitäten";
  late Future<Object> future;
  PageController pageController = PageController(
    initialPage: 0,
  );

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
              Map<String, dynamic> json = jsonDecode(data.body);
              FavouriteEventsAndActivities favouriteEventAndActivity = FavouriteEventsAndActivities
                  .fromJson(json);
              TabView tabViewFutureEvents = TabView(tabName:futureEvents, informationList: favouriteEventAndActivity.futureEvents);
              TabView tabViewPastEvents = TabView(tabName:pastEvents, informationList: favouriteEventAndActivity.pastEvents);
              TabView tabViewOpenActivities = TabView(tabName:openActivities, informationList: favouriteEventAndActivity.openActivities);
              TabView tabViewClosedActivities = TabView(tabName:closedActivities, informationList: favouriteEventAndActivity.closedActivities);
              return SafeArea(
                  child: Scaffold(
                    primary: true,
                    appBar: AppBar(
                      flexibleSpace: Container(
                        height: 50,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            getCustomFont(appBarName, 24.sp, Colors.black, 1,
                                fontWeight: FontWeight.w700,
                                textAlign: TextAlign.center)
                          ],
                        ),
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      centerTitle: true,
                      bottom: PreferredSize(
                          preferredSize: Size(double.infinity, 70),
                          child: Container(
                            // space between blue and and white
                            height: 50,
                            padding: EdgeInsets.all(5.h),
                            margin: EdgeInsets.symmetric(
                                horizontal: 12.h, vertical: 15.h),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(41.h),
                                boxShadow: [
                                  BoxShadow(
                                      color: shadowColor,
                                      offset: const Offset(0, 8),
                                      blurRadius: 27)
                                ]),
                            child: TabBar(
                                controller: _tabController,
                                unselectedLabelColor: greyColor,
                                labelColor: Colors.white,
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(44.h),
                                    color: accentColor),
                                onTap: (index) {
                                  pageController.animateToPage(
                                    index,
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                tabs: [
                                  Tab(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(eventDescription,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontFamily:
                                              AssetConstants.fontsFamily,
                                              fontSize: 18.sp)),
                                    ),
                                  ),
                                  Tab(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(activityDescription,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontFamily:
                                              AssetConstants.fontsFamily,
                                              fontSize: 18.sp)),
                                    ),
                                  ),
                                ]),
                          )),
                    ),
                    body: NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                        ];
                      },
                      body: TabBarView(
                        controller: _tabController,
                        children: <Widget>[
                          PageViewBuilder(tabViewList: [tabViewFutureEvents, tabViewPastEvents]),
                          PageViewBuilder(tabViewList: [tabViewOpenActivities, tabViewClosedActivities]),
                        ],
                      ),
                    ),
                  ));
            }
          }
        });
  }

}