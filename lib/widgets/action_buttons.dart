import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/core/add/add.dart';
import 'package:othia/core/favourites/exclusive_widgets/list_change_notifier.dart';
import 'package:othia/modules/models/eA_summary/eA_summary.dart';
import 'package:othia/utils/ui/future_service.dart';
import 'package:othia/widgets/nav_bar/nav_bar_notifier.dart';
import 'package:provider/provider.dart';

import '../../utils/services/rest-api/rest_api_service.dart';
import '../../utils/ui/app_dialogs.dart';
import '../modules/models/is_liked_ea/is_liked_ea.dart';
import '../utils/services/data_handling/keep_alive_future_builder.dart';

enum ActionButtonType {
  favouriteLikeButton,
  addLikeButton,
  settingsButton,
  settingsButtonDisabled
}

Widget getActionButton(
    {required ActionButtonType actionButtonType,
    required SummaryEventOrActivity eASummary,
    required BuildContext context}) {
  Map<ActionButtonType, Function> actionButtonMap = {
    ActionButtonType.favouriteLikeButton: getFavouriteLikeButton,
    ActionButtonType.settingsButton: getSettingsButton,
    ActionButtonType.settingsButtonDisabled: getSettingsButtonDisabled,
    ActionButtonType.addLikeButton: addLikeButton
  };
  Function getActionButtonFunction = actionButtonMap[actionButtonType]!;

  return Function.apply(
      getActionButtonFunction, [], {#context: context, #eASummary: eASummary});
}

Widget getFavouriteLikeButton({
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
          Provider.of<NavigationBarNotifier>(context, listen: false)
              .isDialogOpen = true;
          showDialog<bool>(
              context: context,
              builder: (context) => getDialog(
                      dialogText: AppLocalizations.of(context)!
                          .removeFavoriteDialog(eASummary.title),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(false),
                              child: Text(AppLocalizations.of(context)!.cancel),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(true),
                              child:
                                  Text(AppLocalizations.of(context)!.confirm),
                            ),
                          ],
                        ),
                      ])).then((value) {
            Provider.of<NavigationBarNotifier>(context, listen: false)
                .isDialogOpen = false;
            if (value!) {
              try {
                RestService()
                    .removeFavouriteEventOrActivity(eAId: eASummary.id)
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

Widget getSettingsButtonFrame(
    {required BuildContext context,
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
      iconColor: Theme.of(context).colorScheme.primary,
      onPressedFunction: () => {
            Get.to(Add(),
                arguments: {NavigatorConstants.EventActivityId: eASummary.id})
          });
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
      iconColor: Theme.of(context).colorScheme.secondary,
      onPressedFunction: () => {});
}

Widget addLikeButton({
  required BuildContext context,
  required SummaryEventOrActivity eASummary,
}) {
  return AddLikeButton(
    context: context,
    eAId: eASummary.id,
  );
}

// TODO align starting color to our action color
class AddLikeButton extends StatefulWidget {
  final String eAId;

  AddLikeButton({
    required BuildContext context,
    required this.eAId,
  });

  @override
  State<AddLikeButton> createState() => _AddLikeButtonState(eAId);
}

class _AddLikeButtonState extends State<AddLikeButton> {
  final String eAId;
  late Future<Object> isLiked;

  // TODO change structure
  bool userLoggedIn = false;

  _AddLikeButtonState(this.eAId);

  @override
  void initState() {
    // TODO get userId somehow
    String userId = "testUserId";
    if (userId != null) {
      isLiked = RestService().isEALikedByUser(eAId: eAId);
    } else {
      userLoggedIn = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (userLoggedIn) {
      return KeepAliveFutureBuilder(
          future: isLiked,
          builder: (context, snapshot) {
            return snapshotHandler(snapshot, getLikeButton, []);
          });
    } else {
      return buildNotLoggedInLikeButton();
    }
  }

  Widget getLikeButton(Map<String, dynamic> decodedJson) {
    LikedEA isLiked = LikedEA.fromJson(decodedJson);
    return LikeButton(
      isLiked: isLiked.isLikedByUser,
      onTap: onLikeButtonTapped,
      circleColor: CircleColor(
          // TODO here the activated color of the heart should be set, but it does not work like we tried
          end: Theme.of(context).colorScheme.primary,
          start: Theme.of(context).colorScheme.tertiary),
    );
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    if (isLiked) {
      try {
        RestService().removeFavouriteEventOrActivity(eAId: eAId);
      } on Exception catch (e) {
        //TODO
        throw e;
      }
    } else {
      try {
        RestService().addFavouriteEventOrActivity(eAId: eAId);
      } on Exception catch (e) {
        //TODO
        throw e;
      }
    }
    return !isLiked;
  }

  Widget buildNotLoggedInLikeButton() {
    List<Widget> actions = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
// FlatButton widget is used to make a text to work like a button
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
// function used to perform after pressing the button
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            // TODO forward to login page
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            child: Text("Login"),
          ),
        ],
      )
    ];
    return Row(children: [
      IconButton(
          constraints: BoxConstraints(maxWidth: 50.h),
          icon: Icon(
            Icons.favorite,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            Provider.of<NavigationBarNotifier>(context, listen: false)
                .isDialogOpen = true;
            showDialog<bool>(
                context: context,
                builder: (context) => getDialog(
                      dialogText:
                          AppLocalizations.of(context)!.notLoggedInMessageLike,
                      actions: actions,
                    )).then((_) {
              Provider.of<NavigationBarNotifier>(context, listen: false)
                  .isDialogOpen = false;
            });
          }),
    ]);
  }
}
