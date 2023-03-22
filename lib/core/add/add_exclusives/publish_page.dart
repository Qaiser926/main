import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/core/add/add_exclusives/help_functions.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:provider/provider.dart';

import 'input_notifier.dart';

class PublishPage extends StatelessWidget {
  AddEANotifier inputNotifier;
  PageController pageController;

  PublishPage(this.inputNotifier, this.pageController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Consumer<AddEANotifier>(
              builder: (context, inputNotifierConsumer, child) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getHeadlineWithInfoDialog(
                    showDivider: false,
                    context: context,
                    infoText: AppLocalizations.of(context)!.visibilityInfoText,
                    caption: inputNotifierConsumer.times[0]
                        ? "${AppLocalizations.of(context)!.event} ${AppLocalizations.of(context)!.visibility}"
                        : "${AppLocalizations.of(context)!.activity} ${AppLocalizations.of(context)!.visibility}",
                  ),
                  getSwitch(
                      context: context,
                      onPressed: inputNotifier.changePrivatePublic,
                      isSelected: inputNotifierConsumer.publicOrPrivate,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5.h),
                          child: Text(
                            AppLocalizations.of(context)!.public,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.h),
                          child: Text(
                            AppLocalizations.of(context)!.private,
                          ),
                        ),
                      ]),
                  getHeadlineWithInfoDialog(
                    context: context,
                    infoText:
                        AppLocalizations.of(context)!.profileVisibilityInfoText,
                    caption: AppLocalizations.of(context)!.profileVisibility,
                  ),
                  getSwitch(
                      context: context,
                      onPressed: inputNotifier.changeOwnedOrForeign,
                      isSelected: inputNotifierConsumer.associateProfile,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5.h),
                          child: Text(
                            AppLocalizations.of(context)!.showProfile,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.h),
                          child: Text(
                            AppLocalizations.of(context)!.hideProfile,
                          ),
                        ),
                      ]),
                  getHeadlineWithInfoDialog(
                    context: context,
                    infoText: AppLocalizations.of(context)!.guidelinesText,
                    caption:
                        AppLocalizations.of(context)!.agreeGuidelinesCaption,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.agreeGuidelinesText),
                      Switch(
                        activeColor: Theme.of(context).colorScheme.primary,
                        value: inputNotifierConsumer.termsAgreed,
                        onChanged: (hasPermissions) {
                          inputNotifierConsumer.termsAgreed = hasPermissions;
                          if (hasPermissions)
                            inputNotifier.termsAgreedErrorMessage = false;
                          inputNotifier.notifyListeners();
                        },
                      ),
                    ],
                  ),
                  inputNotifierConsumer.termsAgreedErrorMessage
                      ? getErrorMessage(context)
                      : SizedBox(),
                  getVerSpace(50.h),
                  ElevatedButton(
                      onPressed: () => publishFunction(context),
                      child: Text(AppLocalizations.of(context)!.publish))
                ]);
          })),
    );
  }

  Widget getErrorMessage(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.agreeGuidelinesErrorMessage,
      style: TextStyle(color: Theme.of(context).colorScheme.error),
    );
  }
}
