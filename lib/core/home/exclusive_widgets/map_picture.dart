import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/core/map/map.dart';
import 'package:othia/utils/ui/ui_utils.dart';

class MapPicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO clear (extern) align distances between caption and content
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.map,
                  style: Theme.of(context).textTheme.headlineLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )),
        getVerSpace(10.h),
        Padding(
          padding: EdgeInsets.fromLTRB(20.h, 2.h, 20.h, 0.h),
          child: GestureDetector(
            onTap: () => {Get.to(MapPage())},
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20.h),
                    child: getAssetImage(NavigatorConstants.MapImage)),
                Positioned.fill(
                  child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(6.h),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(3.h),
                          child: Text(AppLocalizations.of(context)!.exploreMap,
                              style: TextStyle(fontSize: 17.h)),
                        ),
                      )),
                ),
                Positioned(
                    left: 20.h,
                    top: 30.h,
                    child: Icon(
                      Icons.location_on,
                      size: 28.h,
                    )),
                Positioned(
                    left: 220.h,
                    top: 130.h,
                    child: Icon(
                      Icons.location_on,
                      size: 28.h,
                    )),
                Positioned(
                    left: 45.h,
                    top: 141.h,
                    child: Icon(
                      Icons.location_on,
                      size: 28.h,
                    )),
              ],
            ),
          ),
        ),
        getVerSpace(10.h),
      ],
    );
  
    // Container(
    //   color: Colors.red,
    // );
   
  }
}
