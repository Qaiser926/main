import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:maps_launcher/maps_launcher.dart';
import 'package:othia/widgets/filter_related/dropdown_appbar.dart';
import 'package:othia/widgets/filter_related/search_filter.dart';
import 'package:othia/widgets/filter_related/search_notifier.dart';
import 'package:provider/provider.dart';

class MapBodyInit extends StatelessWidget {
  const MapBodyInit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<SearchNotifier>(builder: (context, model, child) {
        return Scaffold(
          primary: true,
          appBar: DropDownAppBar(
              // TODO
              filter:
                  Consumer<SearchNotifier>(builder: (context, model, child) {
                return SearchFilter(
                  context: context,
                ).buildDropdownBar();
              }),
              context: context,
              appBarTitle: AppLocalizations.of(context)!.discover,
              automaticallyImplyLeading: false),
          body: MapBody(),
        );
      }),
    );
  }
}

class MapBody extends StatefulWidget {
  const MapBody({Key? key}) : super(key: key);

  @override
  State<MapBody> createState() => _MapBodyState();
}

class _MapBodyState extends State<MapBody> {
  void backClick() {
    Get.back();
  }

  Position? _currentPosition;

  @override
  void initState() {
    _getCurrentPosition();
    super.initState();
  }

  Future<bool> _handleLocationPermission() async {
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
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => {
            _currentPosition = position,
          });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentPosition != null) {
      latLng.LatLng latlong = latLng.LatLng(
          _currentPosition!.latitude, _currentPosition!.longitude);
      return Stack(
        children: [
          FlutterMap(
              options: MapOptions(
                center: latlong,
                zoom: 15.0,
                maxZoom: 17,
                minZoom: 3,
              ),
              nonRotatedChildren: [
                Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsetsDirectional.only(end: 8, bottom: 2),
                  child: Text('© OpenStreetMap'),
                )
              ],
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'ohtia.de',
                ),
                MarkerLayer(markers: [
                  Marker(
                      width: 50.0,
                      height: 500.0,
                      rotate: true,
                      point: latlong,
                      builder: (ctx) => GestureDetector(
                            onTap: () => MapsLauncher.launchCoordinates(
                                latlong.latitude, latlong.longitude),
                            // child: Icon(
                            //   // Icons.location_on,
                            //   Icons.my_location,
                            //   size: 22,
                            //   color: Colors.blue,
                            // ),
                          ))
                ])
              ]),
          GestureDetector(
            onTap: () => {
              // TODO open category filter
              print("tapped")
            },
            child: Stack(
              children: [
                Opacity(
                  opacity: 0.5,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    // TODO align color
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor),
                  ),
                ),
                Positioned.fill(
                    child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.center,
                    // TODO align text size
                    child: Text(
                      "Please select a category to show results from the filters",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ))
              ],
            ),
          ),
        ],
      );
    } else {
      // TODO implement other text during waiting for user permission
      // TODO align style
      return Align(
        alignment: Alignment.center,
        child: Text(
          "Waiting for location permission",
          textAlign: TextAlign.center,
        ),
      );
    }
  }
}
