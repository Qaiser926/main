import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:othia/core/login/login_data.dart';
import 'package:othia/utils/services/rest-api/rest_api_service.dart';

import '../../widgets/form_fields.dart';
import 'exclusives.dart';

class ConfirmationScreen extends StatelessWidget {
  LoginSignupData data;

  ConfirmationScreen(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController confirmController = TextEditingController();

    return Scaffold(
        appBar: AppBar(),
        body: LoginSignUp(
          buttonText: AppLocalizations.of(context)!.confirm,
          onPressed: (GlobalKey<FormState> key) async {
            if (key.currentState!.validate()) {
              data.confirmCode = confirmController.text;
              confirm(data, context);
            }
          },
          textFields: [
            //TODO extern only number keyboard should open here
            CustomTextFormField(
              validator: (p0) {
                if (p0 != null) {
                  if (p0.isEmpty) {
                    return AppLocalizations.of(context)!.notEmptyErrorMessage;
                  }
                }
              },
              suffixIcon: TextButton(
                  onPressed: () =>
                      RestService().resendConfirmationCode(email: data.email!),
                  child: Text(AppLocalizations.of(context)!.resend)),
              controller: confirmController,
              iconData: Icons.mail,
              hintText: AppLocalizations.of(context)!.confirmationCode,
            ),
          ],
        ));
  }
}