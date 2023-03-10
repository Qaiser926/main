import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart' as latLng;

import '../../../utils/services/events/example_event.dart';

class UserPositionNotifier extends ChangeNotifier {
  UserPositionNotifier(BuildContext context) {
    this._getCurrentPosition(context);
  }

  latLng.LatLng? userPosition;

  Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
   
      Get.snackbar("", "",titleText: Center(
        child: Center(
          child: Text(
                  'Location services are disabled. Please enable the services'),
        ),
      ),snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar("title", "",titleText: Center(child: Text('Location permissions are denied')),snackPosition: SnackPosition.BOTTOM);
     
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
       Get.snackbar("", "",titleText: Center(child: Text("Location permissions are permanently denied, we cannot request permissions.")),snackPosition: SnackPosition.BOTTOM);
      
    
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition(BuildContext context) async {
    final hasPermission = await _handleLocationPermission(context);
    if (!hasPermission) return;
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      userPosition = latLng.LatLng(position.latitude, position.longitude);
      recordCustomEvent(eventName: "userLocation", eventParams: {
        "userLatitude": position.latitude,
        'userLongitude': position.longitude
      });
      notifyListeners();
    }).catchError((e) {
      debugPrint(e);
    });
  }

  latLng.LatLng? get getUserPosition => userPosition;
}
