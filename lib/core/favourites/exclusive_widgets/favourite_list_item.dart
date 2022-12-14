import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/core/favourites/exclusive_widgets/list_change_notifier.dart';
import 'package:provider/provider.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

import '../../../modules/models/eA_summary/eA_summary.dart';
import '../../../utils/services/data_handling/data_handling.dart';
import '../../../utils/services/rest-api/rest_api_service.dart';
import '../../../utils/ui/app_dialogs.dart';
import '../../../utils/ui/ui_utils.dart';

Widget getFavouriteListItem(
    BuildContext context, SummaryEventOrActivity eASummary) {
  return Container(
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
              SizedBox(
                width: 85.h,
                height: 60.h,
                child: getImageWithBackground(
                    categoryId: eASummary.categoryId, photo: eASummary.photo),
              ),
              getHorSpace(10.h),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eASummary.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline4,
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
                          getLocationString(
                              location: eASummary.location, isShort: true),
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
                              context: context,
                              isShort: true,
                              prices: eASummary.prices),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Row(children: [
          IconButton(
              constraints: BoxConstraints(maxWidth: 50.h),
              icon: const Icon(
                Icons.favorite,
              ),
              onPressed: () {
                showDialog<bool>(
                    context: context,
                    builder: (context) =>
                        getDialog(objectTitle: eASummary.title)).then((value) {
                  if (value!) {
                    try {
                      RestService()
                          .removeFavouriteEventOrActivity(id: eASummary.id)
                          .then((value) {
                        print(value);
                        Provider.of<FavouriteNotifier>(context, listen: false)
                            .removeKey(key: eASummary.id);
                      });
                    } on Exception catch (e) {
                      //TODO
                      throw e;
                    } catch (e) {
                      //TODO
                      throw e;
                    }
                  }
                });
              }),
        ]),
      ],
    ),
  );
}

Widget getImageWithBackground(
    {required String categoryId, required String? photo}) {
  Image image = getPhotoNullSave(
      categoryId: categoryId, photo: photo, width: 110.h, height: 80.h);

  Image fittedImage = Image(
    image: image.image,
    fit: BoxFit.cover,
    width: 110.h,
    height: 80.h,
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
