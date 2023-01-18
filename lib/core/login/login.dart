import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:othia/core/login/login_data.dart';

import 'exclusives.dart';

class Login extends StatelessWidget {
  LoginSignupData data;

  Login(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneNumberController =
        TextEditingController(text: data.phoneNumber);
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: getLoginAppBar(),
      body: LoginSignUp(
          buttonText: 'Login',
          onPressed: () {
            data.password = passwordController.text;
            data.phoneNumber = phoneNumberController.text;
            signIn(data, context);
          },
          textFields: [
            getCustomTextFormFieldWithPadding(
              controller: phoneNumberController,
              iconData: Icons.phone,
              hintText: "Username",
            ),
            getCustomTextFormFieldWithPadding(
              controller: passwordController,
              iconData: Icons.password,
              hintText: "Password",
            )
          ]),
    );
  }
}
