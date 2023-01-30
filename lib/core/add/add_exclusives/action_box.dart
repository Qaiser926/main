import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:othia/core/add/add_exclusives/forwarding_pages.dart';
import 'package:othia/core/add/add_exclusives/help_functions.dart';
import 'package:othia/core/add/add_exclusives/input_notifier.dart';
import 'package:othia/utils/helpers/builders.dart';
import 'package:othia/utils/helpers/diverse.dart';
import 'package:othia/utils/services/global_navigation_notifier.dart';
import 'package:othia/utils/services/rest-api/amplify/amp.dart';
import 'package:othia/utils/ui/app_dialogs.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:provider/provider.dart';

class ActionBox extends StatelessWidget {
  AddEANotifier inputNotifier;

  ActionBox(this.inputNotifier);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      getHeadline(
          showDivider: false,
          context: context,
          caption: Text(AppLocalizations.of(context)!.addActions,
              style: Theme.of(context).textTheme.headlineLarge)),
      getVerSpace(10.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButton(
              context: context,
              caption: AppLocalizations.of(context)!.delete,
              onTap: () {
                dismissKeyboard();
                showDeleteDialog(context);
              },
              icon: Icons.delete),
          buildButton(
              context: context,
              caption: AppLocalizations.of(context)!.share,
              onTap: () {
                dismissKeyboard();
                final String shareLink =
                    eAShareLinkBuilder(inputNotifier.detailedEA.id!);
                openShare(
                    '${AppLocalizations.of(context)!.shareMessage} $shareLink',
                    context);
              },
              icon: Icons.share),
        ],
      ),
      getVerSpace(10.h),
    ]);
  }

  Widget buildButton(
      {required BuildContext context,
      required String caption,
      required Function onTap,
      required IconData icon}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            border: Border.all(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.all(Radius.circular(10.h))),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.h),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 15.h,
                  ),
                  getHorSpace(10.h),
                  Text(
                    caption,
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Future<void> showDeleteDialog(BuildContext context) async {
    Provider.of<GlobalNavigationNotifier>(context, listen: false).isDialogOpen =
        true;
    String userId = await getUserId();
    showDialog(
      context: context,
      builder: (context) => getDialog(
          dialogText: AppLocalizations.of(context)!.deleteDialog(
              inputNotifier.times[0]
                  ? AppLocalizations.of(context)!.event
                  : AppLocalizations.of(context)!.activity),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                  child: Text(AppLocalizations.of(context)!.cancel),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    closeSnackBar(context);
                    Get.to(DeleteForwardingPage(inputNotifier, userId));
                  },
                  child: Text(AppLocalizations.of(context)!.confirm),
                ),
              ],
            ),
          ]),
    ).then((_) {
      Provider.of<GlobalNavigationNotifier>(context, listen: false)
          .isDialogOpen = false;
    });
  }
}
