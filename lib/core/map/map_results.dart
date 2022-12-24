import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:othia/config/routes/routes.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/core/map/current_position.dart';
import 'package:othia/core/map/exclusive_widgets/app_bar_creator.dart';
import 'package:othia/modules/models/get_map_result_ids/get_map_result_ids.dart';
import 'package:othia/utils/services/rest-api/rest_api_service.dart';
import 'package:othia/utils/ui/future_service.dart';
import 'package:othia/widgets/filter_related/notifiers/map_notifier.dart';
import 'package:provider/provider.dart';

class MapResultsInit extends StatelessWidget {
  const MapResultsInit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildMapAppBar(context: context, body: MapResults());
  }
}

class MapResults extends StatefulWidget {
  const MapResults({Key? key}) : super(key: key);

  @override
  State<MapResults> createState() => _MapResultsState();
}

class _MapResultsState extends State<MapResults> {
  late Future<Object> mapResults;
  late latLng.LatLng? userPosition;
  late MapResultIds mapResultIds;

  void backClick() {
    Get.back();
  }

  // @override
  // void didChangeDependencies() {
  //   mapResults = RestService().getMapResultIds(
  //       searchQuery: Provider.of<MapNotifier>(context).getSearchQuery());
  //   super.didChangeDependencies();
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserPositionNotifier>(builder: (context, model, child) {
      userPosition = model.getUserPosition;
      if (userPosition != null) {
        return Consumer<MapNotifier>(builder: (context, model, child) {
          mapResults = RestService()
              .getMapResultIds(searchQuery: model.getSearchQuery());
          return FutureBuilder(
              future: mapResults,
              builder: (context, snapshot) {
                return snapshotHandler(snapshot, futureMap, []);
              });
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
    });
  }

  Widget futureMap(Map<String, dynamic> json) {
    mapResultIds = MapResultIds.fromJson(json);
    return FlutterMap(
        options: MapOptions(
          center: userPosition,
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
          MarkerLayer(markers: getResultMarkers())
        ]);
  }

  Marker getMarker(
      {required Map<String, dynamic> locationData,
      required Color markerColor}) {
    return Marker(
        width: 50.0,
        height: 50.0,
        rotate: true,
        // TODO user navigator constants
        point: latLng.LatLng(locationData["coordinates"]["latitude"],
            locationData["coordinates"]["longitude"]),
        builder: (ctx) => GestureDetector(
              onTap: () => {
                NavigatorConstants.sendToNext(Routes.detailedEventRoute,
                    arguments: {
                      NavigatorConstants.EventActivityId: locationData["id"]
                    })
              },
              child: Icon(
                Icons.location_on,
                size: 44,
                color: markerColor,
              ),
            ));
  }

  List<Marker> getResultMarkers() {
    List<Marker> markerList = [];
    markerList.add(Marker(
        width: 50.0,
        height: 500.0,
        rotate: true,
        point: userPosition!,
        builder: (ctx) => Icon(
              Icons.my_location,
              size: 22,
              color: Colors.blue,
            )));
    // for activities
    //TODO align color scheme
    mapResultIds.activityResults.forEach((element) {
      markerList
          .add(getMarker(locationData: element!, markerColor: Colors.green));
    });
    mapResultIds.eventResults.forEach((element) {
      markerList
          .add(getMarker(locationData: element!, markerColor: Colors.red));
    });
    return markerList;
  }
}
