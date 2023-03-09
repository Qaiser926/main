import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:othia/core/login/login_data.dart';
import 'package:othia/utils/services/rest-api/rest_api_service.dart';
import 'package:othia/widgets/nav_bar/nav_bar_notifier.dart';

import '../../widgets/form_fields.dart';
import '../main_page.dart';
import 'exclusives.dart';

class ConfirmResetPassword extends StatelessWidget {
  LoginSignupData loginSignupData;

  ConfirmResetPassword(this.loginSignupData, {super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController confirmController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController repeatPasswordController = TextEditingController();

    return Scaffold(
        appBar: AppBar(),
        body: LoginSignUp(
          buttonText: AppLocalizations.of(context)!.confirm,
          onPressed: (GlobalKey<FormState> key) async {
            if (key.currentState!.validate()) {
              await RestService().confirmResetPassword(
                  email: loginSignupData.email!,
                  newPassword: newPasswordController.text,
                  confirmationCode: confirmController.text);
              await RestService().signIn(
                  email: loginSignupData.email!,
                  password: newPasswordController.text);
              Get.to(MainPage());
            }
          },
          textFields: [
            //TODO clear (extern) only number keyboard should open here
            CustomTextFormField(
              numberInput: true,
              validator: (p0) {
                if (p0 != null) {
                  if (p0.isEmpty) {
                    return AppLocalizations.of(context)!.notEmptyErrorMessage;
                  }
                }
              },
              suffixIcon: TextButton(
                  onPressed: () {
                    RestService().resetPassword(email: loginSignupData.email!);
                  },
                  child: Text(AppLocalizations.of(context)!.resend)),
              controller: confirmController,
              iconData: Icons.mail,
              hintText: AppLocalizations.of(context)!.confirmationCode,
            ),

            getCustomTextFormFieldWithPadding(
              obscureText: true,
              hintText: AppLocalizations.of(context)!.password,
              iconData: Icons.key,
              controller: newPasswordController,
              validator: (p0) {
                passwordValidator(p0);
                if (p0 != null) {
                  if (p0.isEmpty) {
                    return AppLocalizations.of(context)!.notEmptyErrorMessage;
                  }
                }
              },
            ),
            getCustomTextFormFieldWithPadding(
                obscureText: true,
                hintText: AppLocalizations.of(context)!.repeatPassword,
                iconData: Icons.key,
                controller: repeatPasswordController,
                validator: (String? val) {
                  if (val != null) {
                    if (val.isEmpty) {
                      return AppLocalizations.of(context)!.notEmptyErrorMessage;
                    }
                  }
                  if (val != newPasswordController.text) {
                    return AppLocalizations.of(context)!.repeatPasswordError;
                  }
                }),
          ],
        ));
  }
}
