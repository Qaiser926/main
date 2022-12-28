import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:othia/config/routes/routes.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/core/map/exclusive_widgets/app_bar_creator.dart';
import 'package:othia/core/map/exclusive_widgets/current_position.dart';
import 'package:othia/modules/models/get_map_result_ids/get_map_result_ids.dart';
import 'package:othia/utils/services/rest-api/rest_api_service.dart';
import 'package:othia/utils/ui/future_service.dart';
import 'package:othia/utils/ui/ui_utils.dart';
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
        // TODO implement exception handling and messages for user permission, e.g. implement loading when map is not shown
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
        maxZoom: 18.49,
        minZoom: 3,
      ),
      nonRotatedChildren: [
        Container(
          alignment: Alignment.bottomRight,
          padding: const EdgeInsetsDirectional.only(end: 8, bottom: 2),
          child: Text('© OpenStreetMap'),
        ),
        // TODO align colors of Event and Activity colored box & introduce background color for the legend or change
        // font color such that it is readible
        Container(
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsetsDirectional.only(start: 8, bottom: 2),
          child: Row(
            children: [
              SizedBox(
                width: 10,
                height: 8,
                child: DecoratedBox(
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                ),
              ),
              getHorSpace(5.h),
              Text(AppLocalizations.of(context)!.event),
              getHorSpace(10.h),
              SizedBox(
                width: 10,
                height: 8,
                child: DecoratedBox(
                  decoration:
                      BoxDecoration(color: Theme.of(context).bottomAppBarColor),
                ),
              ),
              getHorSpace(5.h),
              Text(AppLocalizations.of(context)!.activity),
            ],
          ),
        )
      ],
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'ohtia.de',
        ),
        MarkerClusterLayerWidget(
          options: MarkerClusterLayerOptions(
            maxClusterRadius: 120,
            size: Size(40, 40),
            fitBoundsOptions: FitBoundsOptions(
              padding: EdgeInsets.all(50),
            ),
            markers: getResultMarkers(),
            polygonOptions:
                PolygonOptions(color: Colors.black12, borderStrokeWidth: 3),
            builder: (context, markers) {
              return FloatingActionButton(
                foregroundColor: Colors.white,
                child: Text(markers.length.toString()),
                onPressed: null,
              );
            },
          ),
        ),
        // MarkerLayer(markers: getResultMarkers()),
      ],
    );
  }

  Marker getMarker(
      {required Map<String, dynamic> locationData,
      required Color markerColor}) {
    return Marker(
        width: 50.0,
        height: 50.0,
        rotate: true,
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
      markerList.add(getMarker(
          locationData: element!, markerColor: Theme.of(context).primaryColor));
    });
    mapResultIds.eventResults.forEach((element) {
      markerList.add(getMarker(
          locationData: element!,
          markerColor: Theme.of(context).bottomAppBarColor));
    });
    return markerList;
  }
}
