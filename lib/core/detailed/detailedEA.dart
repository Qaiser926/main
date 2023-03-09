import 'package:add_2_calendar/src/model/event.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:othia/core/detailed/exclusive_widgets/diverse.dart';
import 'package:othia/core/main_page.dart';
import 'package:othia/utils/helpers/builders.dart';
import 'package:othia/utils/services/global_navigation_notifier.dart';
import 'package:othia/widgets/nav_bar/nav_bar_notifier.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

import '../../constants/app_constants.dart';
import '../../modules/models/detailed_event/detailed_event.dart';
import '../../utils/services/data_handling/data_handling.dart';
import '../../utils/services/data_handling/get_ical_element.dart';
import '../../utils/services/rest-api/rest_api_service.dart';
import '../../utils/ui/future_service.dart';
import '../../utils/ui/ui_utils.dart';
import '../../widgets/keep_alive_future_builder.dart';
import 'exclusive_widgets/button_widget.dart';
import 'exclusive_widgets/horizontal_exploration_detail.dart';
import 'exclusive_widgets/image_widgets.dart';
import 'exclusive_widgets/map_widget.dart';
import 'exclusive_widgets/organizer_section.dart';

class DetailedEAPage extends StatefulWidget {
  const DetailedEAPage({Key? key}) : super(key: key);

  @override
  State<DetailedEAPage> createState() => _DetailedEAPageState();
}

class _DetailedEAPageState extends State<DetailedEAPage> {
  late Future<Object> detailedEventOrActivity;
  late bool notGoBack;

  @override
  void initState() {
    // in case the detail page is shown as result of forwarding from adding
    notGoBack = Get.arguments[DataConstants.notGoBack] ?? false;
    String eventId = Get.arguments[DataConstants.EventActivityId];
    detailedEventOrActivity =
        RestService().fetchEventOrActivityDetails(eventOrActivityId: eventId);
    FirebaseAnalytics.instance.setCurrentScreen(
      screenName: 'detailScreen',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeepAliveFutureBuilder(
        future: detailedEventOrActivity,
        builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
                      return Center(child:defaultStillLoadingWidget);
                    }
          if(snapshot.hasData){
          return snapshotHandler(context, snapshot, getContent, []);
          }else{
                    return Center(child: Text("No Data Exit"),);
                  }
        });
  }

  Widget getContent(Map<String, dynamic> decodedJson) {
    DetailedEventOrActivity detailedEA =
        DetailedEventOrActivity.fromJson(decodedJson);

    Event? iCalElement;
    if (detailedEA.time.startTimeUtc != null) {
      iCalElement = getIcalElement(
        startTimeUtc: detailedEA.time.startTimeUtc!,
        title: detailedEA.title!,
        locationText: getLocationString(location: detailedEA.location),
        description: detailedEA.description,
        endTimeUtc: detailedEA.time.endTimeUtc,
      );
    }

    return SafeArea(
      child: WillPopScope(
        onWillPop: () => onWillPop(),
        child: Scaffold(
          bottomNavigationBar: ButtonWidget(
              eAId: detailedEA.id!,
              iCalElement: iCalElement,
              shareUrl: eAShareLinkBuilder(detailedEA.id!),
              websiteUrl: detailedEA.websiteUrl,
              ticketUrl: detailedEA.ticketUrl),
          body: Container(
            //in diesem container sind sind alle attribute nacheinander enthalten, beim hinzufügen
            // wird durch die infinity characteristik der container erweitert (scrollbar)
            height: double.infinity,
            width: double.infinity,
            // Hintergrundfarbe des Containers

            child: SingleChildScrollView(
              child: Column(
                // TODO clear (extern) align distances done
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // in the image widget, the event details (name, place, time are contained)
                  ImageWidget(
                    detailedEventOrActivity: detailedEA,
                    iCalElement: iCalElement,
                  ),
                  // space between ImageWidget and ticket price
                  getVerSpace(10.h),
                  detailedEA.ownerId == null
                      ? SizedBox()
                      : detailedEA.showOrganizer ?? false
                          ? OrganizerSection(detailedEA.ownerId!)
                          : SizedBox(),
                  detailedEA.ownerId == null ? SizedBox() : getVerSpace(15.h),
                  if (detailedEA.description != null)
                    DescriptionWidget(description: detailedEA.description!),
                  if (!detailedEA.isOnline!)
                    SimpleMap(
                        latLng.LatLng(detailedEA.location.latitude!,
                            detailedEA.location.longitude!),
                        detailedEA.id!),
                  if (detailedEA.time.openingTime != null)
                    OpeningTimesSection(
                        openingTime: detailedEA.time.openingTime!),
                  getVerSpace(15.h),
                  if (detailedEA.eventSeriesId != null)
                    ExploreEventSeries(
                        eventSeriesId: detailedEA.eventSeriesId!),
                  ExploreCategory(categoryId: detailedEA.categoryId!),
                  if (detailedEA.location.locationId != null)
                    ExploreLocation(
                        locationId: detailedEA.location.locationId!),
                  if (detailedEA.htmlAttributions != null)
                    HTMLAttributions(
                      htmlAttributions: detailedEA.htmlAttributions!,
                    ),
                ],
              ),

              // make it all scrollable
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    if (Provider.of<GlobalNavigationNotifier>(context, listen: false)
        .isDialogOpen) {
    } else {
      if (notGoBack) {
        Provider.of<GlobalNavigationNotifier>(context, listen: false)
            .navigationBarIndex = NavigatorConstants.HomePageIndex;
        NavigatorConstants.sendToScreen(MainPage());
      } else {
        NavigatorConstants.backToPrev();
      }
    }
    return Future.value(false);
  }
}
