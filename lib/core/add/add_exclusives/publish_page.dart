import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/core/add/add_exclusives/help_functions.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:provider/provider.dart';

import 'input_notifier.dart';

class PublishPage extends StatelessWidget {
  AddEANotifier inputNotifier;

  PublishPage(this.inputNotifier);

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
                      context: context,
                      infoText:
                          "Public events or activities will be shown on our platform whereas private event or activities can only be accessed via a sharing url",
                      caption: "Visibility"),
                  getSwitch(
                      context: context,
                      onPressed: inputNotifier.changePrivatePublic,
                      isSelected: inputNotifierConsumer.privateOrPublic,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5.h),
                          child: Text("Public"),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.h),
                          child: Text('Private'),
                        ),
                      ]),
                  getHeadlineWithInfoDialog(
                      context: context,
                      infoText:
                          "The provided info are in line with the guidelines",
                      caption: "Agree to terms"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("I agree with the terms"),
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
                      child: Text("Publish"))
                ]);
          })),
    );
  }

  Widget getErrorMessage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "You have to have to agree with our terms",
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        )
      ],
    );
  }
}
