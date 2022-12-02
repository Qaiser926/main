import 'dart:convert';
import 'dart:ui';
import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/constants/asset_constants.dart';
import 'package:provider/provider.dart';
import '../../config/themes/color_data.dart';
import '../../modules/models/favourite_event_and_activity/favourite_events_and_activities.dart';
import '../../utils/services/rest-api/rest_api_service.dart';
import '../../utils/ui/ui_utils.dart';
import '../../widgets/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'exclusive_widgets/list_change_notifier.dart';
import 'exclusive_widgets/page_view.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var _scrollController;
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
              FavouriteEventsAndActivities favouriteEventAndActivity =
                  FavouriteEventsAndActivities.fromJson(json);
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
                        getCustomFont(
                            text: AppLocalizations.of(context)!.favourites,
                            fontSize: 24.sp,
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
                                  child: Text(
                                      AppLocalizations.of(context)!.events,
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
                                  child: Text(
                                      AppLocalizations.of(context)!.activities,
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
                      return <Widget>[];
                    },
                    body: ChangeNotifierProvider<ListNotifier>(
                        create: (_) => ListNotifier(
                            listenedList: favouriteEventAndActivity.futureEvents),
                        child: Consumer<ListNotifier>(
                          builder: (context, model, child) => TabBarView(
                            controller: _tabController,
                            // TODO define multiprovider here
                            children: <Widget>[
                              PageViewBuilder(tabViewList: [
                                TabView(
                                    tabName: AppLocalizations.of(context)!
                                        .futureEvents,
                                    informationList:
                                        model.updatedList),
                                TabView(
                                    tabName: AppLocalizations.of(context)!
                                        .pastEvents,
                                    informationList:
                                        favouriteEventAndActivity.pastEvents)
                              ], nothingToShowMessage: "nicht Event"),
                              PageViewBuilder(tabViewList: [
                                TabView(
                                    tabName: AppLocalizations.of(context)!
                                        .openActivities,
                                    informationList: favouriteEventAndActivity
                                        .openActivities),
                                TabView(
                                    tabName: AppLocalizations.of(context)!
                                        .closedActivities,
                                    informationList: favouriteEventAndActivity
                                        .closedActivities)
                              ], nothingToShowMessage: "Nichts Aktivitäten"),
                            ],
                          ),
                        ))),
              ));
            }
          }
        });
  }
}
