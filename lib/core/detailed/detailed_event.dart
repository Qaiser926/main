import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:othia/utils/services/exceptions.dart';

import '../../constants/app_constants.dart';
import '../../modules/models/detailed_event/detailed_event.dart';
import '../../utils/services/data_handling/data_handling.dart';
import '../../utils/services/data_handling/get_ical_element.dart';
import '../../utils/services/data_handling/keep_alive_future_builder.dart';
import '../../utils/services/rest-api/rest_api_service.dart';
import '../../utils/ui/future_service.dart';
import '../../utils/ui/ui_utils.dart';
import '../../widgets/splash_screen.dart';
import 'exclusive_widgets/button_widget.dart';
import 'exclusive_widgets/description_widget.dart';
import 'exclusive_widgets/horizontal_exploration_detail.dart';
import 'exclusive_widgets/image_widgets.dart';
import 'exclusive_widgets/map_widget.dart';
import 'exclusive_widgets/opening_times.dart';
import 'exclusive_widgets/other.dart';

class EventDetail extends StatefulWidget {
  const EventDetail({Key? key}) : super(key: key);

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  late Future<Object> detailedEventOrActivity;

  void backClick() {
    NavigatorConstants.backToPrev();
  }

  // TODO: link to organizer id

  @override
  void initState() {
    // TODO change to only arguments
    String eventId = Get.arguments[NavigatorConstants.EventActivityId] ?? "1";
    detailedEventOrActivity =
        RestService().fetchEventOrActivityDetails(eventOrActivityId: eventId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeepAliveFutureBuilder(
        future: detailedEventOrActivity,
        builder: (context, snapshot) {
          try {
            Map<String, dynamic> decodedJson = snapshotHandler(snapshot);
            DetailedEventOrActivity detailedEventOrActivity =
                DetailedEventOrActivity.fromJson(decodedJson);
            var iCalElement = null;
            if (detailedEventOrActivity.time.startTimeUtc != null) {
              iCalElement = getIcalElement(
                startTimeUtc: detailedEventOrActivity.time.startTimeUtc!,
                title: detailedEventOrActivity.title,
                locationText: getLocationString(
                    location: detailedEventOrActivity.location),
                description: detailedEventOrActivity.description,
                endTimeUtc: detailedEventOrActivity.time.endTimeUtc,
              );
            }

            return SafeArea(
              child: WillPopScope(
                onWillPop: () async {
                  backClick();
                  return false;
                },
                child: Scaffold(
                  body: Container(
                    //in diesem container sind sind alle attribute nacheinander enthalten, beim hinzufügen
                    // wird durch die infinity characteristik der container erweitert (scrollbar)
                    height: double.infinity,
                    width: double.infinity,
                    // Hintergrundfarbe des Containers

                    child: Column(
                      // alle elemente sind in der column angeordnet
                      children: [
                        Expanded(
                          // the first item has the expanded characteristic, meaning that it fills the available space
                          flex: 1,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                // in the image widget, the event details (name, place, time are contained)
                                ImageWidget(
                                  detailedEventOrActivity:
                                      detailedEventOrActivity,
                                  iCalElement: iCalElement,
                                ),
                                // space between ImageWidget and ticket price
                                getVerSpace(10.h),
                                // TODO follower only if not Othia scraped
                                getFollowWidget(context),
                                getVerSpace(25.h),
                                if (detailedEventOrActivity.description != null)
                                  DescriptionWidget(
                                      description:
                                          detailedEventOrActivity.description!),
                                if (!detailedEventOrActivity.isOnline)
                                  SimpleMap(latLng.LatLng(
                                      detailedEventOrActivity
                                          .location.latitude!,
                                      detailedEventOrActivity
                                          .location.longitude!)),
                                if (detailedEventOrActivity.time.openingTime !=
                                    null)
                                  OpeningTimesSection(
                                      openingTime: detailedEventOrActivity
                                          .time.openingTime!),

                                // TODO include share url + decide where to integrate
                                ButtonWidget(
                                    iCalElement: iCalElement,
                                    shareUrl: "temp",
                                    websiteUrl:
                                    detailedEventOrActivity.websiteUrl,
                                    ticketUrl:
                                    detailedEventOrActivity.ticketUrl),
                                getVerSpace(25.h),
                                if (detailedEventOrActivity.eventSeriesId !=
                                    null)
                                  ExploreEventSeries(
                                      eventSeriesId: detailedEventOrActivity
                                          .eventSeriesId!),
                                ExploreCategory(
                                    categoryId:
                                    detailedEventOrActivity.categoryId),
                                if (detailedEventOrActivity
                                    .location.locationId !=
                                    null)
                                  ExploreLocation(
                                      locationId: detailedEventOrActivity
                                          .location.locationId!),
                              ],
                            ),

                            // make it all scrollable
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          } on StillLoading {
            return SplashScreen();
          }
        });
  }
}
