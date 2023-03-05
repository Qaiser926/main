import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:maps_launcher/maps_launcher.dart';
import 'package:othia/core/main_page.dart';
import 'package:othia/core/map/exclusive_widgets/app_bar_creator.dart';
import 'package:othia/core/map/exclusive_widgets/current_position.dart';

import 'package:othia/widgets/filter_related/category_filter/category_filter.dart';
import 'package:othia/widgets/filter_related/notifiers/map_notifier.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class MapInit extends StatelessWidget {
  const MapInit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildMapAppBar(context: context, body: MapInitialization());
  }
}

class MapInitialization extends StatefulWidget {
  const MapInitialization({Key? key}) : super(key: key);

  @override
  State<MapInitialization> createState() => _MapInitializationState();
}

class _MapInitializationState extends State<MapInitialization> {
  @override
  void initState() {
    super.initState();
    // mapLocation();
  }
  
    Completer<GoogleMapController> _controller=Completer();
 
  @override
  Widget build(BuildContext context) {
    return Consumer<UserPositionNotifier>(builder: (context, model, child) {
      latLng.LatLng? userPosition = model.getUserPosition;
      if (userPosition != null) {
        return Stack(
          children: [
            // markers: Set.of(_marker),
               FlutterMap(
                options: MapOptions(
                  center: userPosition,
                  zoom: 15.0,
                  maxZoom: 17,
                  minZoom: 3,
                ),
                nonRotatedChildren: [
                  Container(
                    alignment: Alignment.bottomRight,
                    padding:
                        const EdgeInsetsDirectional.only(end: 8, bottom: 2),
                    child: Text('© OpenStreetMap'),
                  )
                ],
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'ohtia.de',
                  ),
                  MarkerLayer(markers: [
                  //   Marker(
                  //       width: 50.0,
                  //       height: 500.0,
                  //       rotate: true,
                  //       point: userPosition,
                  //       builder: (ctx) => GestureDetector(
                  //             onTap: () => MapsLauncher.launchCoordinates(
                  //                 userPosition.latitude,
                  //                 userPosition.longitude),
                  //             // child: Icon(
                  //             //   // Icons.location_on,
                  //             //   Icons.my_location,
                  //             //   size: 22,
                  //             //   color: Colors.blue,
                  //             // ),
                  //           ))
                  ])
                ]),
          
            GestureDetector(

              onTap: () => {
                getCategoryFilterDialog(
                    context: context,
                    dynamicProvider:
                        Provider.of<MapNotifier>(context, listen: false))
              },
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.4,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      // TODO clear (extern) align color and overall experience
                      decoration:
                          BoxDecoration(color: Theme.of(context).primaryColorDark),
                    ),
                  ),
                  Positioned.fill(
                      child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Align(
                      alignment: Alignment.center,
                      // TODO claer (extern) align text size or find other solution to make optic more appealing. If you have a better idea on how to show the map, please let us know
                      child: Text(
                        AppLocalizations.of(context)!.mapCategoryInfo,
                        textAlign: TextAlign.center,style: TextStyle(
                          fontSize: 15.sp,fontFamily: 'Poppins'
                        ),
                      ),
                    ),
                  ))
                ],
              ),
            ),
         
          ],
        );
      } else {
        // TODO clear (extern) align style
        // TODO clear (extern) introduce loading screen or message if declined
        return Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/lottiesfile/Location Service off.json",width: 250.w,height: 250.h),
                Padding(
                padding:  EdgeInsets.symmetric(horizontal: 25.w),
                child: Text(
                  AppLocalizations.of(context)!.waitingLocationPermission,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.sp,fontFamily: "Poppins"),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              ElevatedButton(
                onPressed: () async {
                
                  
                _handleLocationPermission(context);
                 Get.to(MainPage(),transition: Transition.fadeIn);
                },
                child: Text("get locatinon"),
              ),
            ],
          ),
        );
      }
    });
  }
    Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
              openAppSettings();
      return false;
    }
    return true;
  }
}

