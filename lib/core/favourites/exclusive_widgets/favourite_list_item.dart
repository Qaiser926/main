import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/core/favourites/exclusive_widgets/list_change_notifier.dart';
import 'package:provider/provider.dart';

import '../../../config/themes/theme_config.dart';
import '../../../constants/colors.dart';
import '../../../modules/models/favourite_event_and_activity/favourite_single_event_or_activity/favourite_event_or_activity.dart';
import '../../../utils/services/data_handling/data_handling.dart';
import '../../../utils/services/rest-api/rest_api_service.dart';
import '../../../utils/ui/app_dialogs.dart';
import '../../../utils/ui/ui_utils.dart';

Widget getFavouriteListItem(
    BuildContext context, FavouriteEventOrActivity favouriteEventOrActivity) {
  return Container(
    margin: EdgeInsets.only(bottom: 12.h, left: 12.h, right: 12.h),
    decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        // boxShadow: [
        //   BoxShadow(
        //       color: Colors.white, blurRadius: 27, offset: const Offset(0, 8))
        // ],
        borderRadius: BorderRadius.circular(22.h)),
    padding: EdgeInsets.only(top: 7.h, left: 7.h, bottom: 6.h, right: 10.h),
    child: Row(
      children: [
        Flexible(
          child: Row(
            children: [
              getRoundImage(getPhotoNullSave(
                  categoryId: favouriteEventOrActivity.categoryId,
                  photo: favouriteEventOrActivity.photo,
                  width: 100.h,
                  height: 82.h)),
              getHorSpace(10.h),
              Flexible(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getCustomFont(
                      text: favouriteEventOrActivity.title,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      txtHeight: 1.5.h),
                  getVerSpace(4.h),
                  getCustomFont(
                      text: getTimeInformation(
                          context: context,
                          openingTimeCode:
                              favouriteEventOrActivity.openingTimeCode,
                          startTimeUtc: favouriteEventOrActivity.startTimeUtc),
                      fontSize: 15.sp,
                      color: greyColor,
                      fontWeight: FontWeight.w500,
                      txtHeight: 1.46.h)
                ],
              ))
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
                icon: const Icon(
                  Icons.favorite,
                ),
                onPressed: () {
                  showDialog<bool>(
                          context: context,
                          builder: (context) => getDialog(
                              objectTitle: favouriteEventOrActivity.title))
                      .then((value) {
                    if (value!) {
                      try {
                        RestService()
                            .removeFavouriteEventOrActivity(
                                id: favouriteEventOrActivity.id)
                            .then((value) {
                          print(value);
                          Provider.of<FavouriteNotifier>(context, listen: false)
                              .removeKey(key: favouriteEventOrActivity.id);
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
          ],
        ),
      ],
    ),
  );
}
