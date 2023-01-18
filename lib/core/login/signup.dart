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
            //TODO these are not all the fields we want from the user.
            //TODO we also need: gender, liked categories, and more (see ppp)
            getCustomTextFormFieldWithPadding(
              //TODO i10n
              //TODO validation or maybe let aws handle validation?
              hintText: "Phone Number",
              iconData: Icons.phone,
              controller: phoneNumberController,
            ),
            getCustomTextFormFieldWithPadding(
              //TODO validation or maybe let aws handle validation?
              hintText: AppLocalizations.of(context)!.eMail,
              iconData: Icons.mail,
              controller: emailController,
            ),
            getCustomTextFormFieldWithPadding(
              //TODO date picker instead of text input
              //TODO validation or maybe let aws handle validation?
              hintText: AppLocalizations.of(context)!.birthdate,
              iconData: Icons.date_range,
              controller: emailController,
            ),
            getCustomTextFormFieldWithPadding(
              //TODO hide input chars.
              hintText: AppLocalizations.of(context)!.password,
              iconData: Icons.password,
              controller: passwordController,
            ),
          ]),
    );
  }
}
