import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:maps_launcher/maps_launcher.dart';
import 'package:othia/modules/models/get_map_result_ids/get_map_result_ids.dart';
import 'package:othia/utils/services/rest-api/rest_api_service.dart';
import 'package:othia/utils/ui/future_service.dart';
import 'package:othia/widgets/filter_related/dropdown_appbar.dart';
import 'package:othia/widgets/filter_related/map_filter.dart';
import 'package:othia/widgets/filter_related/map_notifier.dart';
import 'package:provider/provider.dart';

class MapResults extends StatelessWidget {
  const MapResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<MapNotifier>(builder: (context, model, child) {
        return Scaffold(
          primary: true,
          appBar: DropDownAppBar(
              filter: Consumer<MapNotifier>(builder: (context, model, child) {
                return MapFilter(
                        context: context,
                        dynamicProvider:
                            Provider.of<MapNotifier>(context, listen: false))
                    .buildDropdownBar();
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
  late Future<Object> mapResults;
  late latLng.LatLng latlong;

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

  Widget futureMap(Map<String, dynamic> json) {
    MapResultIds mapResultIds = MapResultIds.fromJson(json);
    return FlutterMap(
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
          MarkerLayer(markers: getMarkers())
        ]);
  }

  @override
  Widget build(BuildContext context) {
    // TODO cannot stay here
    mapResults = RestService().getMapResultIds(
        searchQuery: Provider.of<MapNotifier>(context).getSearchQuery());
    if (_currentPosition != null) {
      setState(() {
        latlong = latLng.LatLng(
            _currentPosition!.latitude, _currentPosition!.longitude);
      });
      return FutureBuilder(
          future: mapResults,
          builder: (context, snapshot) {
            return snapshotHandler(snapshot, futureMap, []);
          });
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

  List<Marker> getMarkers() {
    List<Marker?> markerList;
    return [
      Marker(
          width: 50.0,
          height: 500.0,
          rotate: true,
          point: latlong,
          builder: (ctx) => Icon(
                Icons.my_location,
                size: 22,
                color: Colors.blue,
              )),
      Marker(
          width: 50.0,
          height: 50.0,
          rotate: true,
          point: latlong,
          builder: (ctx) => GestureDetector(
                onTap: () => MapsLauncher.launchCoordinates(
                    latlong.latitude, latlong.longitude),
                child: Icon(
                  Icons.location_on,
                  size: 22,
                  color: Colors.blue,
                ),
              ))
    ];
  }
}
