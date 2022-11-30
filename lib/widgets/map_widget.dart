import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
// import 'package:maps_launcher/maps_launcher.dart';

class SimpleMap extends StatefulWidget {
  final latLng.LatLng latlong;

  SimpleMap(latLng.LatLng this.latlong) {}

  @override
  State<SimpleMap> createState() => _SimpleMapState(latlong);
}

class _SimpleMapState extends State<SimpleMap> {
  final latLng.LatLng latlong;

  _SimpleMapState(latLng.LatLng this.latlong) {}

  @override
  Widget build(BuildContext context) {
    // TODO only show in case no online event/ activity
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
            height: 210,
            width: 250,
            decoration: BoxDecoration(
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
                    padding: EdgeInsetsDirectional.only(end: 8, bottom: 2),
                    child: Text('© OpenStreetMap'),
                  )

                  // source: '© OpenStreetMap contributors',
                  // onSourceTapped: () {},
                  // sourceTextStyle: TextStyle(fontSize: 5),
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
                              onTap: () =>
                                  print("df"),
                                  // MapsLauncher.launchCoordinates(
                                  // latlong.latitude, latlong.longitude),
                              child: Container(
                                child: Icon(
                                  Icons.location_on,
                                  size: 50,
                                  color: Colors.red,
                                ),
                              ),
                            ))
                  ])
                ])));

    // layers: [
    //
    //   TileLayerOptions(
    //     urlTemplate:
    //         "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
    //     subdomains: ['a', 'b', 'c'],
    //   ),
    //   MarkerLayerOptions(markers: [
    //     Marker(
    //         width: 50.0,
    //         height: 500.0,
    //         rotate: true,
    //         point: latlong,
    //         builder: (ctx) => GestureDetector(
    //               onTap: () => MapsLauncher.launchCoordinates(
    //                   latlong.latitude, latlong.longitude),
    //               child: Container(
    //                 child: Icon(
    //                   Icons.location_on,
    //                   size: 50,
    //                   color: Colors.red,
    //                 ),
    //               ),
    //             ))
    //   ])
    // ])));
  }
}
