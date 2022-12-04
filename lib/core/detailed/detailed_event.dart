import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../modules/models/detailed_event/detailed_event.dart';
import '../../utils/services/data_handling/data_handling.dart';
import '../../utils/services/data_handling/get_ical_element.dart';
import '../../utils/services/rest-api/rest_api_service.dart';
import '../../utils/ui/ui_utils.dart';
import '../../widgets/description_widget.dart';
import '../../widgets/map_widget.dart';
import '../../widgets/splash_screen.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'exclusive_widgets/image_widgets.dart';
import 'exclusive_widgets/opening_times.dart';
import 'exclusive_widgets/other.dart';
import 'package:add_2_calendar/add_2_calendar.dart';


class EventDetail extends StatefulWidget {
  const EventDetail({Key? key}) : super(key: key);

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  late Future<Object> detailedEventOrActivity;


  void backClick() {
    print('backclick');
    // Constant.backToPrev(context);
  }

  // TODO: link to organizer id

  @override
  void initState() {
    String eventId = Get.arguments;
    detailedEventOrActivity =
        RestService().fetchEventOrActivityDetails(eventOrActivityId: eventId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: detailedEventOrActivity,
        builder: (context, snapshot) {
          print('builder called');
          if (snapshot.connectionState != ConnectionState.done) {
            return const SplashScreen();
          } else {
            if (snapshot.hasError) {
              throw Exception(snapshot.error);
            } else {
              RestResponse data = snapshot.data as RestResponse;
              Map<String, dynamic> json = jsonDecode(data.body);
              DetailedEventOrActivity detailedEventOrActivity = DetailedEventOrActivity
                  .fromJson(json);
              var iCalElement = null;
              if (detailedEventOrActivity.startTimeUtc != null) {
                iCalElement = getIcalElement(
                    startTimeUtc: detailedEventOrActivity.startTimeUtc!,
                    title: detailedEventOrActivity.title,
                    locationText: getLocationString(
                        isOnline: detailedEventOrActivity.isOnline,
                        locationTitle: detailedEventOrActivity.locationTitle,
                        city: detailedEventOrActivity.city,
                        street: detailedEventOrActivity.street,
                        streetNumber: detailedEventOrActivity.streetNumber),
                    description: detailedEventOrActivity.description,
                    endTimeUtc: detailedEventOrActivity.endTimeUtc,
                    );
              }

              return WillPopScope(
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
                    color: Colors.white,
                    child: Column(
                      // alle elemente sind in der column angeordnet
                      children: [
                        Expanded(
                          // the first item has the expanded characteristic, meaning that it fills the available space
                          flex: 1,
                          child: ListView(
                            // make it all scrollable
                            children: [
                              // in the image widget, the event details (name, place, time are contained)
                              ImageWidget(
                                detailedEventOrActivity: detailedEventOrActivity, iCalElement: iCalElement,
                              ),
                              // space between ImageWidget and ticket price
                              getVerSpace(10.h),
                              // TODO follower only if not Othia scraped
                              getFollowWidget(context),
                              getVerSpace(20.h),
                              if(detailedEventOrActivity.description !=
                                  null) DescriptionWidget(
                                  description: detailedEventOrActivity
                                      .description!),
                              if(detailedEventOrActivity.description !=
                                  null) getVerSpace(30.h),
                              if(!detailedEventOrActivity.isOnline) SimpleMap(
                                  latLng.LatLng(
                                      detailedEventOrActivity.latitude!,
                                      detailedEventOrActivity.longitude!)),
                              getVerSpace(20.h),
                              if(detailedEventOrActivity.openingTime !=
                                  null) OpeningTimesSection(
                                  openingTime: detailedEventOrActivity
                                      .openingTime!),

                              // this is were later the map should be shown
                              getVerSpace(120.h),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          }
        });
  }
}
