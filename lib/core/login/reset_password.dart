import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'exclusives.dart';
import 'login_data.dart';

class ResetPassword extends StatelessWidget {
  @override
  String? errorMessage;

  Widget build(BuildContext context) {
    TextEditingController recoverController = TextEditingController();
    return Scaffold(
        appBar: AppBar(),
        body: LoginSignUp(
          textFields: [
            getCustomTextFormFieldWithPadding(
              validator: (p0) {
                if (errorMessage != null) {
                  return errorMessage;
                } else {
                  if (p0 != null) {
                    if (p0.isEmpty) {
                      return AppLocalizations.of(context)!.notEmptyErrorMessage;
                    }
                  }
                }
              },
              controller: recoverController,
              iconData: Icons.mail,
              //TODO i10n
              hintText: AppLocalizations.of(context)!.eMail,
            ),
          ],
          buttonText: AppLocalizations.of(context)!.recoverPassword,
          topText: AppLocalizations.of(context)!.recoverPassword,
          onPressed: (key) async {
            if (key.currentState!.validate()) {
              LoginSignupData loginSignupData = LoginSignupData();
              loginSignupData.email = recoverController.text;
              String? result = await resetPassword(loginSignupData);
              if (result != null) {
                key.currentState?.setState(() {
                  errorMessage = result;
                  key.currentState?.validate();
                  errorMessage = null;
                });
              } else {
                loginOrSignIn(loginSignupData, false, context);
              }
            }
          },
        ));
  }
}
