
// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';


// class GoogleMap extends StatefulWidget {
//   const GoogleMap({super.key});

//   @override
//   State<GoogleMap> createState() => _GoogleMapState();
// }

// class _GoogleMapState extends State<GoogleMap> {
//     List<Marker> _markerList=[];

//  final List<Marker> _list=[
//     Marker(markerId:MarkerId('1'), position: LatLng(31.5194, 74.3228),infoWindow: InfoWindow(title: 'My Current Location')),
//     Marker(markerId: MarkerId('2'),position: LatLng(24.8607, 67.0011),infoWindow: InfoWindow(title: 'target marker')),
//   ];

//   @override
//   iniState(){
//     super.initState();
//     _markerList.addAll(_list);
//   }

//   Completer<GoogleMapController> _controller=Completer();

//   @override
//   Widget build(BuildContext context) {
//     return GoogleMap(
      
//     );
//   }
// }
   import 'package:google_maps_flutter/google_maps_flutter.dart';

List<Marker> _markerList=[];

 final List<Marker> _list=[
    Marker(markerId:MarkerId('1'), position: LatLng(31.5194, 74.3228),infoWindow: InfoWindow(title: 'My Current Location')),
    Marker(markerId: MarkerId('2'),position: LatLng(24.8607, 67.0011),infoWindow: InfoWindow(title: 'target marker')),
  ];
