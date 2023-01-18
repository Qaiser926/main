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
          buttonText: "Confirm",
          onPressed: () async {
            data.confirmCode = confirmController.text;
            confirm(data, context);
          },
          textFields: [
            CustomTextFormField(
              suffixIcon: TextButton(
                  onPressed: () => print("icon Pressed"),
                  child: Text("Resend")),
              controller: confirmController,
              iconData: Icons.mail,
              hintText: "Confirm Code",
            ),
          ],
          belowButton: ElevatedButton(
              onPressed: () {
                try {
                  RestService().resend(username: data.number!);
                } on Exception catch (e) {
                  //WRONG Code
                }
              },
              child: Text("Resend")),
        ));
  }
}
