import 'package:flutter/material.dart';
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
        appBar: getLoginAppBar(),
        body: LoginSignUp(
          //TODO i10n
          buttonText: "Confirm",
          onPressed: () async {
            data.confirmCode = confirmController.text;
            confirm(data, context);
          },
          textFields: [
            //TODO extern only number keyboard should open here
            CustomTextFormField(
              suffixIcon: TextButton(
                  onPressed: () => RestService()
                      .resendConfirmationCode(phoneNumber: data.phoneNumber!),
                  //TODO i10n
                  child: Text("Resend")),
              controller: confirmController,
              iconData: Icons.mail,
              //TODO i10n
              hintText: "Confirm Code",
            ),
          ],
        ));
  }
}
