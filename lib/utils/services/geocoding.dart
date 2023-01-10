import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart' as latLng;

Future<latLng.LatLng?> getLatLongFromAddress(String addressQuery) async {
  latLng.LatLng? latLong;
  try {
    List<Location> locations = await locationFromAddress(addressQuery);
    // in validation check also that lat/ long are set
    latLong = latLng.LatLng(locations[0].latitude, locations[0].longitude);
  } on NoResultFoundException catch (e) {
    // TODO (extern) more precise error catch
  } catch (e) {
    print("catch errors more precisely");
  }
  return latLong;
}
