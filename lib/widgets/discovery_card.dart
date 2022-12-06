import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/constants/colors.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import '../modules/models/eA_summary/eA_summary.dart';
import '../utils/services/data_handling/data_handling.dart';
import '../utils/ui/ui_utils.dart';

class EASummaryCard extends StatelessWidget {
  final SummaryEventOrActivity eASummary;
  final int index;

  EASummaryCard({Key? key,
    required this.eASummary,
    required this.index})
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
                    getPhotoNullSave(categoryId: eASummary.categoryId,
                        photo: eASummary.photo).image,
                    fit: BoxFit.fill)),
            height: 170.h,
            width: 248.h,
            padding: EdgeInsets.only(left: 12.h, top: 12.h),
            child: getTimeWrapper(context: context, eASummary: eASummary),
          ),
          Positioned(
            width: 230.h,
            top: 112.h,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .tertiary,
                  borderRadius: BorderRadius.circular(22.h)),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child:getSummaryInformation(eASummary: eASummary, context: context),
              // height: 133.h,
            ),
          )
        ],
      ),
    );
  }
}

Widget getTimeWrapper(
    {required BuildContext context, required SummaryEventOrActivity eASummary}) {
  return Wrap(
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
                startTimeUtc: eASummary.time.startTimeUtc,
                openingTimeCode: eASummary.time.openingTimeCode),
            fontSize: 13.sp,
            maxLine: 1,
            fontWeight: FontWeight.w600,
            txtHeight: 1.69.h),
      ),
    ],
  );
}

Widget getSummaryInformation(
    {required BuildContext context, required SummaryEventOrActivity eASummary}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      getCustomFont(
          text: eASummary.title,
          fontSize: 18.sp,
          maxLine: 1,
          fontWeight: FontWeight.w600,
          txtHeight: 1.5.h),
      getVerSpace(5.h),
      Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 20.h,
          ),
          getHorSpace(5.h),
          getCustomFont(text: getLocationString(
              location: eASummary.location, isShort: true),
              fontSize: 15.sp,
              maxLine: 1,
              fontWeight: FontWeight.w500,
              txtHeight: 1.5.h)
// include here price information
        ],
      ),
      getVerSpace(5.h),
      Row(
        children: [
          Icon(Typicons.tag, size: 20.h,),
          getHorSpace(5.h),
// TODO change icon
          getCustomFont(text: getPriceText(
              context: context, isShort: true, prices: eASummary.prices),
              fontSize: 15.sp,
              maxLine: 1,
              fontWeight: FontWeight.w500,
              txtHeight: 1.5.h)
// include here price information
        ],
      ),

    ],
  );
}