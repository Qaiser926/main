import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:maps_launcher/maps_launcher.dart';
import 'package:othia/core/detailed/exclusive_widgets/diverse.dart';

import '../../../utils/services/events/example_event.dart';

class SimpleMap extends StatefulWidget {
  final latLng.LatLng latlong;
  final String eAId;

  SimpleMap(latLng.LatLng this.latlong, String this.eAId) {}

  @override
  State<SimpleMap> createState() => _SimpleMapState(latlong);
}

class _SimpleMapState extends State<SimpleMap> {
  final latLng.LatLng latlong;

  _SimpleMapState(latLng.LatLng this.latlong) {}

  @override
  Widget build(BuildContext context) {
    return getSection(
        context: context,
        caption: AppLocalizations.of(context)!.location,
        contentWidget: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
                height: 210,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: FlutterMap(
                    options: MapOptions(
                      center: latlong,
                      zoom: 15.0,
                      maxZoom: 17,
                      minZoom: 3,
                    ),
                    nonRotatedChildren: [
                      Container(
                        alignment: Alignment.bottomRight,
                        padding:
                            const EdgeInsetsDirectional.only(end: 8, bottom: 2),
                        child: const Text('© OpenStreetMap'),
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
                            point: latlong,
                            builder: (ctx) => GestureDetector(
                                  onTap: () {
                                    recordCustomEvent(
                                        eventName: "launchMap",
                                        eventParams: {"eAId": widget.eAId});
                                    MapsLauncher.launchCoordinates(
                                        latlong.latitude, latlong.longitude);
                                  },
                                  child: const Icon(
                                    Icons.location_on,
                                    size: 50,
                                  ),
                                ))
                      ])
                    ]))));
  }
}
