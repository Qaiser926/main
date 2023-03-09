import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:othia/config/routes/routes.dart';
import 'package:othia/constants/no_internet.dart';
import 'package:othia/constants/no_internet_controller.dart';
import 'package:othia/core/home/exclusive_widgets/map_picture.dart';
import 'package:othia/modules/models/get_home_page_ids/get_home_page_ids.dart';
import 'package:othia/utils/services/rest-api/amplify/amp.dart';
import 'package:othia/utils/services/rest-api/rest_api_service.dart';
import 'package:othia/utils/ui/future_service.dart';
import 'package:othia/widgets/horizontal_discovery/discover_horizontally.dart';
import 'package:othia/widgets/keep_alive_future_builder.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../../utils/services/events/get_user_time.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Object> futureHomePageIds;

   final connectivity=Connectivity();
  
     final StudentLocationController studentFindTutorsController=Get.put(StudentLocationController());
  @override

  @override
  void initState() {
    futureHomePageIds = RestService().getHomePageIds();
    FirebaseAnalytics.instance.setCurrentScreen(
      screenName: 'homeScreen',
    );
    // the code snippet will call the extraction of user times
    amplifyIsUserSignedIn().then((isSignedIn) {
      // only save calendar times for signed in users
      if (isSignedIn) {
        requestCalendarPermissions().then((bool isGranted) {
          if (isGranted) {
            findFreeTimes();
          }
        });
      }
    });

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
            body:Obx(()=>Container(
        child: studentFindTutorsController.connectionStatus.value==1?mainBody()
      :studentFindTutorsController.connectionStatus.value==2?mainBody():Container(
        width: Get.size.width,
        height: Get.size.height,
        child: Column(
          children: [
            Lottie.asset('assets/lottiesfile/no_internet.json',fit: BoxFit.cover),
         
          ],
        ),
      )))
            
         
            
           ));
  }
  mainBody(){
    return HomePageFutureBuilder();
  }

  Widget HomePageFutureBuilder() {
    return KeepAliveFutureBuilder(
        future: futureHomePageIds,
        builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
                      return Center(child: defaultStillLoadingWidget);
                    }
          if(snapshot.hasData){
          return snapshotHandler(context, snapshot, getHomePage, []);
           }else{
                    return Center(child: Text("No Data Exit"),);
                  }
      
        });
  }

  Widget getHomePage(Map<String, dynamic> jsonData) {
    HomePageIds homePageIds = HomePageIds.fromJson(jsonData);

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
