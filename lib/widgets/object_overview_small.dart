import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/config/themes/color_data.dart';
import '../modules/models/shared_data_models.dart';
import '../utils/services/data_handling/data_handling.dart';
import '../utils/ui/ui_utils.dart';

class FilteredImageStack extends StatelessWidget {
  final Image image;
  final int index;
  final String categoryId;
  final Location location;
  String? photo;
  String? startTimeUtc;
  OpeningTimeCode? openingTimeCode;
  String title;
  List<double>? prices;

  FilteredImageStack(
      {Key? key,
        required this.location,
      required this.image,
      required this.index,
      required this.categoryId,
      this.photo,
      this.startTimeUtc,
      this.openingTimeCode,
      required this.title,
      this.prices})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20.h, left: index == 0 ? 20.h : 0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22.h),
                image: DecorationImage(
                    image:
                        getPhotoNullSave(categoryId: categoryId, photo: photo)
                            as ImageProvider,
                    fit: BoxFit.fill)),
            height: 170.h,
            width: 248.h,
            padding: EdgeInsets.only(left: 12.h, top: 12.h),
            child: Wrap(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: "#B2000000".toColor(),
                      borderRadius: BorderRadius.circular(12.h)),
                  padding:
                      EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.h),
                  child: getCustomFont(
                      text: getTimeInformation(
                          context: context,
                          startTimeUtc: startTimeUtc,
                          openingTimeCode: openingTimeCode),
                      fontSize: 13.sp,
                      color: Colors.white,
                      maxLine: 1,
                      fontWeight: FontWeight.w600,
                      txtHeight: 1.69.h),
                ),
              ],
            ),
          ),
          Positioned(
            width: 230.h,
            top: 132.h,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: shadowColor,
                        blurRadius: 27,
                        offset: const Offset(0, 8))
                  ],
                  borderRadius: BorderRadius.circular(22.h)),
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getVerSpace(16.h),
                  getCustomFont(
                      text: title, fontSize: 18.sp, color: Colors.black, maxLine: 1,
                      fontWeight: FontWeight.w600,
                      txtHeight: 1.5.h),
                  getVerSpace(3.h),
                  Row(
                    children: [
                      getSvgImage("location.svg",
                          width: 20.h, height: 20.h, color: greyColor),
                      getHorSpace(5.h),
                      // TODO decide if location class + make sure ...
                      getCustomFont(text: getLocationString(location: location, isShort: true),fontSize:  15.sp,color: greyColor, maxLine: 1,
                          fontWeight: FontWeight.w500, txtHeight: 1.5.h)
                      // include here price information
                    ],
                  ),
                  getVerSpace(10.h),
                  Row(
                    children: [
                      getSvgImage("location.svg",
                          width: 20.h, height: 20.h, color: greyColor),
                      getHorSpace(5.h),
                      // TODO change icon
                      getCustomFont(text: getPriceText(context: context, isShort: true, prices: prices),fontSize:  15.sp,color: greyColor, maxLine: 1,
                          fontWeight: FontWeight.w500, txtHeight: 1.5.h)
                      // include here price information
                    ],
                  ),
                  getVerSpace(10.h),

                ],
              ),
              // height: 133.h,
            ),
          )
        ],
      ),
    );
  }
}
