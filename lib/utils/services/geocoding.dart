import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart' as latLng;

Future<latLng.LatLng?> getLatLongFromAddress(String addressQuery) async {
  latLng.LatLng? latLong;
  try {
    List<Location> locations = await locationFromAddress(addressQuery);
    // in validation check also that lat/ long are set
    latLong = latLng.LatLng(locations[0].latitude, locations[0].longitude);
  } on NoResultFoundException catch (e) {
    // TODO clear (extern) more precise error catch
    Get.snackbar("", "",
        titleText: Text("No Result Found" + e.toString()),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white);
  } catch (e) {
    print("catch errors more precisely");
    Get.snackbar("", "",
        titleText: Text(e.toString()),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white);
  }
  return latLong;
}
