import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import 'confirm_reset_password.dart';
import 'exclusives.dart';
import 'login_data.dart';

class ResetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController recoverController = TextEditingController();
    return Scaffold(
        appBar: AppBar(),
        body: LoginSignUp(
          textFields: [
            getCustomTextFormFieldWithPadding(
              controller: recoverController,
              iconData: Icons.mail,
              //TODO i10n
              hintText: AppLocalizations.of(context)!.eMail,
            ),
          ],
          buttonText: AppLocalizations.of(context)!.recoverPassword,
          topText: AppLocalizations.of(context)!.recoverPassword,
          onPressed: (key) {
            LoginSignupData loginSignupData = LoginSignupData();
            loginSignupData.email = recoverController.text;
            resetPassword(loginSignupData);
            Get.to(ConfirmResetPassword(loginSignupData),
                duration: Duration.zero);
          },
        ));
  }
}
