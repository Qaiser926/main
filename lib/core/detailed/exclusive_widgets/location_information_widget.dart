import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:maps_launcher/maps_launcher.dart';
import 'package:othia/modules/models/shared_data_models.dart';

import '../../../utils/services/data_handling/data_handling.dart';
import '../../../utils/ui/ui_utils.dart';

class FunctionWrapper {
  Function()? function;
}

class LocationWidget extends StatelessWidget {
  final Location location;
  var latLong;

  LocationWidget({
    super.key,
    required this.location,
  }) {
    if ((location.latitude != null) & (location.longitude != null)) {
      this.latLong = latLng.LatLng(location.latitude!, location.longitude!);
    }
  }

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
            size: 18.h,
          ),
          getHorSpace(5.h),
          Text(
            getLocationString(location: location),
            style: Theme.of(context).textTheme.bodyText2,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
