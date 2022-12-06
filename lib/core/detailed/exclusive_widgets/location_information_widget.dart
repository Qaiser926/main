import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maps_launcher/maps_launcher.dart';
import '../../../utils/ui/ui_utils.dart';
import 'package:latlong2/latlong.dart' as latLng;

class FunctionWrapper {
  Function()? function;
}

class LocationWidget extends StatelessWidget {
  final String locationText;
  latLng.LatLng? latLong;

  LocationWidget(
      {super.key, required this.locationText, this.latLong});

  @override
  Widget build(BuildContext context) {
    Function() function = () => {};
    if (latLong != null) {
      function = () =>
          MapsLauncher.launchCoordinates(latLong!.latitude, latLong!.longitude);
    }

    return GestureDetector(
      onTap: () => function(),
      child: Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 20.h,

          ),
          getHorSpace(5.h),
          Text(
            locationText,
            style: Theme.of(context).textTheme.headline4,
            maxLines: 1,
          )
        ],
      ),
    );
  }
}
