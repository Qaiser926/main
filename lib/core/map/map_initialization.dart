import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:maps_launcher/maps_launcher.dart';
import 'package:othia/core/map/exclusive_widgets/app_bar_creator.dart';
import 'package:othia/core/map/exclusive_widgets/current_position.dart';
import 'package:othia/widgets/filter_related/category_filter/category_filter.dart';
import 'package:othia/widgets/filter_related/notifiers/map_notifier.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserPositionNotifier>(builder: (context, model, child) {
      latLng.LatLng? userPosition = model.getUserPosition;
      if (userPosition != null) {
        return Stack(
          children: [
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
                    Marker(
                        width: 50.0,
                        height: 500.0,
                        rotate: true,
                        point: userPosition,
                        builder: (ctx) => GestureDetector(
                              onTap: () => MapsLauncher.launchCoordinates(
                                  userPosition.latitude,
                                  userPosition.longitude),
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
                getCategoryFilterDialog(
                    context: context,
                    dynamicProvider:
                        Provider.of<MapNotifier>(context, listen: false))
              },
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.5,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      // TODO (extern) align color and overall experience
                      decoration:
                          BoxDecoration(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Positioned.fill(
                      child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Align(
                      alignment: Alignment.center,
                      // TODO (extern) align text size or find other solution to make optic more appealing. If you have a better idea on how to show the map, please let us know
                      child: Text(
                        AppLocalizations.of(context)!.mapCategoryInfo,
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
        // TODO introduce loading screen or message if declined
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
}
