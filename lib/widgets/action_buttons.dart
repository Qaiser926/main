import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/core/favourites/exclusive_widgets/list_change_notifier.dart';
import 'package:othia/modules/models/eA_summary/eA_summary.dart';
import 'package:provider/provider.dart';

import '../../utils/services/rest-api/rest_api_service.dart';
import '../../utils/ui/app_dialogs.dart';

Widget getLikeButton({
  required BuildContext context,
  required SummaryEventOrActivity eASummary,
}) {
  return Row(children: [
    IconButton(
        constraints: BoxConstraints(maxWidth: 50.h),
        icon: const Icon(
          Icons.favorite,
        ),
        onPressed: () {
          showDialog<bool>(
                  context: context,
                  builder: (context) => getDialog(objectTitle: eASummary.title))
              .then((value) {
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
  ]);
}
