import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

import '../../config/routes/routes.dart';
import '../../constants/app_constants.dart';
import '../../modules/models/eA_summary/eA_summary.dart';
import '../../utils/services/data_handling/data_handling.dart';
import '../../utils/ui/ui_utils.dart';

Widget getVerticalSummary(
    {required BuildContext context,
    required SummaryEventOrActivity eASummary,
    required Widget actionButton}) {
  return GestureDetector(
    onTap: () {
      NavigatorConstants.sendToNext(Routes.detailedEventRoute,
          arguments: {DataConstants.EventActivityId: eASummary.id});
    },
    child: Container(
      margin: EdgeInsets.only(bottom: 12.h, left: 10.h, right: 10.h),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(22.h)),
      padding: EdgeInsets.only(top: 6.h, bottom: 6.h, left: 6.h, right: 0.h),
      child: Row(
        children: [
          Flexible(
            child: Row(
              children: [
                getImage(eASummary),
                getHorSpace(10.h),
                getMainPart(context, eASummary),
                actionButton,
                getHorSpace(5.h)
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget getMainPart(BuildContext context, SummaryEventOrActivity eASummary) {
  return Flexible(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eASummary.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Row(children: [
          Icon(
            Icons.access_time_outlined,
            size: 12.h,
          ),
          getHorSpace(5.h),
          Text(
            getTimeInformation(
                context: context,
                openingTimeCode: eASummary.time.openingTimeCode,
                startTimeUtc: eASummary.time.startTimeUtc),
            style: Theme.of(context).textTheme.bodyText2,
            maxLines: 1,
          ),
        ]),
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 12.h,
            ),
            getHorSpace(5.h),
            Expanded(
                child: Text(
              getLocationString(location: eASummary.location, isShort: true),
              style: Theme.of(context).textTheme.bodyText2,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ))
// include here price information
          ],
        ),
        Row(
          children: [
            Icon(
              Typicons.tag,
              size: 12.h,
            ),
            getHorSpace(5.h),
            Text(
              getPriceText(
                  context: context, isShort: true, prices: eASummary.prices),
            )
          ],
        ),
      ],
    ),
  );
}

Widget getImage(SummaryEventOrActivity eASummary) {
  return SizedBox(
    width: 80.h,
    height: 60.h,
    child: getImageWithBackground(
        categoryId: eASummary.categoryId,
        photo: eASummary.photo,
        width: 110,
        height: 80),
  );
}

Widget getImageWithBackground(
    {required String categoryId,
    required String? photo,
    required int width,
    required int height}) {
  Image image = getPhotoNullSave(
      categoryId: categoryId, photo: photo, width: width.h, height: height.h);

  Image fittedImage = Image(
    image: image.image,
    fit: BoxFit.cover,
    width: width.h,
    height: height.h,
  );

  return Stack(children: [
    ClipRRect(
      borderRadius: BorderRadius.circular(22.h),
      clipBehavior: Clip.antiAlias,
      child: ImageFiltered(
          imageFilter: ImageFilter.blur(
              sigmaX: 4.0, sigmaY: 4.0, tileMode: TileMode.mirror),
          child: fittedImage),
    ),
    Container(
      padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 0.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22.h),
        clipBehavior: Clip.antiAlias,
        child: image,
      ),
    )
  ]);
}
