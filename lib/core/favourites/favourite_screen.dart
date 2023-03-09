import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:othia/constants/no_internet_controller.dart';
import 'package:othia/utils/services/global_navigation_notifier.dart';
import 'package:othia/widgets/not_logged_in.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

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
  late Future<Object> favouriteEA;

  @override
  bool get wantKeepAlive => true;

  get favouriteEventAndActivity => favouriteEventAndActivity;


  @override
  void initState() {
    if (Provider.of<GlobalNavigationNotifier>(context, listen: false)
        .isUserLoggedIn) {
      favouriteEA = RestService().fetchFavouriteEventsAndActivities();
    } else {
      favouriteEA = getNotLoggedIn();
    }

    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    FirebaseAnalytics.instance.setCurrentScreen(
      screenName: 'favouriteScreen',
    );
  }

  Widget getLoggedInBody() {
    return FutureBuilder(
        future: favouriteEA,
        builder: (context, snapshot) {
           if(snapshot.connectionState==ConnectionState.waiting){
                      return Center(child: defaultStillLoadingWidget);
                    }
                    if(snapshot.hasData){
          return snapshotHandler(context, snapshot, futureFulfilledWidget, []);
                    }else{
                      return Center( child: Text("No Data Exit"),);
                    }
        });
  }
   final StudentLocationController studentFindTutorsController=Get.put(StudentLocationController());

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        primary: true,
        appBar: FavouriteAppBar(
          tabController: _tabController,
          context: context,
        ),
        body:Obx(()=>Container(
        child: studentFindTutorsController.connectionStatus.value==1?  getLoggedInSensitiveBody(
            loggedInWidget: getLoggedInBody(),
            context: context)
      :studentFindTutorsController.connectionStatus.value==2?  getLoggedInSensitiveBody(
            loggedInWidget: getLoggedInBody(),
            context: context):Container(
        width: Get.size.width,
        height: Get.size.height,
        child: Column(
          children: [
            Lottie.asset('assets/lottiesfile/no_internet.json',fit: BoxFit.cover),
         
          ],
        ),
      )))
        
       
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

  // find a better approach in the future than this
  Future<Object> getNotLoggedIn() {
    // SummaryEventOrActivity summary = SummaryEventOrActivity(time: Time(), location: Location(), title: "", id: "", categoryId: "", isOnline: false);
    return Future.value(FavouriteEventsAndActivities(
        futureEvents: {},
        pastEvents: {},
        openActivities: {},
        closedActivities: {}));
  }
}
