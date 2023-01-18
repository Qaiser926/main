import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:othia/core/login/login_data.dart';

import 'exclusives.dart';

class Signup extends StatelessWidget {
  LoginSignupData data;

  Signup(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneNumberController =
        TextEditingController(text: data.phoneNumber);
    TextEditingController passwordController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: getLoginAppBar(),
      body: LoginSignUp(
          topText: AppLocalizations.of(context)!.signup,
          buttonText: AppLocalizations.of(context)!.signup,
          onPressed: () {
            data.password = passwordController.text;
            data.email = emailController.text;
            data.phoneNumber = phoneNumberController.text;
            signUp(data);
          },
          textFields: [
            getCustomTextFormFieldWithPadding(
              hintText: "Phone Number",
              iconData: Icons.phone,
              controller: phoneNumberController,
            ),
            getCustomTextFormFieldWithPadding(
              hintText: AppLocalizations.of(context)!.eMail,
              iconData: Icons.mail,
              controller: emailController,
            ),
            getCustomTextFormFieldWithPadding(
              hintText: AppLocalizations.of(context)!.birthdate,
              iconData: Icons.date_range,
              controller: emailController,
            ),
            getCustomTextFormFieldWithPadding(
              hintText: AppLocalizations.of(context)!.password,
              iconData: Icons.password,
              controller: passwordController,
            ),
          ]),
    );
  }
}
