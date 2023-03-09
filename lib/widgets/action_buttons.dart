import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/core/add/add.dart';
import 'package:othia/core/favourites/exclusive_widgets/list_change_notifier.dart';
import 'package:othia/core/login/login.dart';
import 'package:othia/modules/models/eA_summary/eA_summary.dart';
import 'package:othia/utils/services/global_navigation_notifier.dart';
import 'package:othia/utils/ui/future_service.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

import '../../utils/services/rest-api/rest_api_service.dart';
import '../../utils/ui/app_dialogs.dart';
import '../modules/models/is_liked_ea/is_liked_ea.dart';
import 'keep_alive_future_builder.dart';

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
          Provider.of<GlobalNavigationNotifier>(context, listen: false)
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
            Provider.of<GlobalNavigationNotifier>(context, listen: false)
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
                //TODO clear(extern) Error handling
                Get.snackbar("", "",
                    titleText: Text("Exception" + e.toString()),
                    snackPosition: SnackPosition.BOTTOM,
                    colorText: Colors.white);
                throw e;
              } catch (e) {
                Get.snackbar("", "",
                    titleText: Text(e.toString()),
                    snackPosition: SnackPosition.BOTTOM,
                    colorText: Colors.white);
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
                arguments: {DataConstants.EventActivityId: eASummary.id})
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

// TODO clear (extern) align starting color to our action color
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

  _AddLikeButtonState(this.eAId);

  @override
  void initState() {
    GlobalNavigationNotifier globalProv =
        Provider.of<GlobalNavigationNotifier>(context, listen: false);
    if (globalProv.isUserLoggedIn) {
      isLiked = RestService().isEALikedByUser(eAId: eAId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<GlobalNavigationNotifier>(context, listen: false)
        .isUserLoggedIn) {
      return KeepAliveFutureBuilder(
          future: isLiked,
          builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                      return Center(child: defaultStillLoadingWidget);
                    }
            if(snapshot.hasData){
            return snapshotHandler(context, snapshot, getLikeButton, []);
             }else{
                    return Center(child: Text("No Data Exit"),);
                  }
          });
    } else {
      return buildNotLoggedInLikeButton();
    }
  }

  Widget getLikeButton(Map<String, dynamic> decodedJson) {
    LikedEA isLiked = LikedEA.fromJson(decodedJson);
    return LikeButton(isLiked.isLikedByUser, widget.eAId);
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
            onPressed: () => Get.to(Login()),
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
            Provider.of<GlobalNavigationNotifier>(context, listen: false)
                .isDialogOpen = true;
            showDialog<bool>(
                context: context,
                builder: (context) => getDialog(
                      dialogText:
                          AppLocalizations.of(context)!.notLoggedInMessageLike,
                      actions: actions,
                    )).then((_) {
              Provider.of<GlobalNavigationNotifier>(context, listen: false)
                  .isDialogOpen = false;
            });
          }),
    ]);
  }
}

class LikeButton extends StatefulWidget {
  bool isLiked;
  String eAId;

  LikeButton(this.isLiked, this.eAId);

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onLikeButtonTapped(),
      child: Icon(
        Icons.favorite,
        color: widget.isLiked
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }

  Future<void> onLikeButtonTapped() async {
    if (widget.isLiked) {
      try {
        RestService().removeFavouriteEventOrActivity(eAId: widget.eAId);
      } on Exception catch (e) {
        //TODO clear (extern) error handling
        Get.snackbar("", "",
            titleText: Text("" + e.toString()),
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white);
        throw e;
      }
    } else {
      try {
        RestService().addFavouriteEventOrActivity(
            eAId: widget.eAId,
            userId:
                Provider.of<GlobalNavigationNotifier>(context, listen: false)
                    .userId!);
      } on Exception catch (e) {
        Get.snackbar("", "",
            titleText: Text("" + e.toString()),
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white);
        throw e;
      }
    }
    setState(() {
      widget.isLiked = !widget.isLiked;
    });
  }
}
