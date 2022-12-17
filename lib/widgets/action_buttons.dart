import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/core/favourites/exclusive_widgets/list_change_notifier.dart';
import 'package:othia/modules/models/eA_summary/eA_summary.dart';
import 'package:provider/provider.dart';

import '../../utils/services/rest-api/rest_api_service.dart';
import '../../utils/ui/app_dialogs.dart';

enum ActionButtonType { likeButton, settingsButton, settingsButtonDisabled }

Widget getActionButton(
    {required ActionButtonType actionButtonType,
    required SummaryEventOrActivity eASummary,
    required BuildContext context}) {
  Map<ActionButtonType, Function> actionButtonMap = {
    ActionButtonType.likeButton: getLikeButton,
    ActionButtonType.settingsButton: getSettingsButton,
    ActionButtonType.settingsButtonDisabled: getSettingsButtonDisabled
  };
  Function getActionButtonFunction = actionButtonMap[actionButtonType]!;

  return Function.apply(
      getActionButtonFunction, [], {#context: context, #eASummary: eASummary});
}

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

Widget getSettingsButtonFrame({required BuildContext context,
  required SummaryEventOrActivity eASummary,
  required Function onPressedFunction,
  required Map<Symbol, dynamic> functionArguments,
  required Color iconColor}) {
  return Row(children: [
    IconButton(
        constraints: BoxConstraints(maxWidth: 50.h),
        icon: Icon(
          Icons.edit,
          color: iconColor,
        ),
        onPressed: () {
          Function.apply(onPressedFunction, [], functionArguments);
        })
  ]);
}

Widget getSettingsButton({
  required BuildContext context,
  required SummaryEventOrActivity eASummary,
}) {
  return getSettingsButtonFrame(
      context: context,
      eASummary: eASummary,
      functionArguments: {},
      iconColor: Theme
          .of(context)
          .colorScheme
          .primary,
      // TODO forward with event id to add/ modify event
      onPressedFunction: () => {});
}

Widget getSettingsButtonDisabled({
  required BuildContext context,
  required SummaryEventOrActivity eASummary,
}) {
  return getSettingsButtonFrame(
      context: context,
      eASummary: eASummary,
      functionArguments: {},
      // TODO choose grey color for non-activated items or decide if nothing is shown
      iconColor: Theme
          .of(context)
          .colorScheme
          .secondary,
      onPressedFunction: () => {});
}
