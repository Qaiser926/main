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
    TextEditingController emailController =
        TextEditingController(text: data.email);
    TextEditingController passwordController = TextEditingController();
    TextEditingController repeatPasswordController = TextEditingController();
    TextEditingController genderController = TextEditingController();
    TextEditingController birthdateController = TextEditingController();
    TextEditingController nameController = TextEditingController();

    List<DropdownMenuItem<Object>> items = [
      DropdownMenuItem(
        child: Text(AppLocalizations.of(context)!.female),
        value: 1,
      ),
      DropdownMenuItem(
        child: Text(AppLocalizations.of(context)!.male),
        value: 2,
      ),
      DropdownMenuItem(
        child: Text(AppLocalizations.of(context)!.diverseGender),
        value: 2,
      ),
    ];
    return Scaffold(
      appBar: AppBar(),
      body: LoginSignUp(
          topText: AppLocalizations.of(context)!.signup,
          buttonText: AppLocalizations.of(context)!.signup,
          onPressed: (GlobalKey<FormState> key) {
            if (key.currentState!.validate()) {
              //TODO intern save all provided data
              data.password = passwordController.text;
              data.email = emailController.text;
              signUp(data);
            }
          },
          textFields: [
            getCustomTextFormFieldWithPadding(
              //TODO intern email validation
              hintText: AppLocalizations.of(context)!.eMail,
              iconData: Icons.mail,
              controller: emailController,
            ),
            getCustomTextFormFieldWithPadding(
              validator: (p0) {
                if (p0 != null) {
                  if (p0.isEmpty) {
                    return AppLocalizations.of(context)!.notEmptyErrorMessage;
                  }
                }
              },
              hintText: AppLocalizations.of(context)!.name,
              iconData: Icons.person,
              suffixIcon: IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          AppLocalizations.of(context)!.signupNameHintText),
                    ));
                  },
                  icon: Icon(Icons.info_outline)),
              controller: nameController,
            ),
            getCustomTextFormFieldWithPadding(
              validator: (p0) {
                if (p0 != null) {
                  if (p0.isEmpty) {
                    return AppLocalizations.of(context)!.notEmptyErrorMessage;
                  }
                }
              },
              //TODO date picker instead of text input
              //TODO date validation
              hintText: AppLocalizations.of(context)!.birthdate,
              iconData: Icons.date_range,
              controller: birthdateController,
            ),
            getCustomDropdownButtonFormFieldWithPadding(
                validator: (p0) {
                  if (p0 != null) {
                    return AppLocalizations.of(context)!.notEmptyErrorMessage;
                  }
                },
                context: context,
                iconData: Icons.accessibility_new,
                hintText: AppLocalizations.of(context)!.gender,
                items: items),
            getCustomTextFormFieldWithPadding(
              obscureText: true,
              hintText: AppLocalizations.of(context)!.password,
              iconData: Icons.password,
              controller: passwordController,
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
                iconData: Icons.password,
                controller: repeatPasswordController,
                validator: (String? val) {
                  if (val != null) {
                    if (val.isEmpty) {
                      return AppLocalizations.of(context)!.notEmptyErrorMessage;
                    }
                  }
                  if (val != passwordController.text) {
                    return AppLocalizations.of(context)!.repeatPasswordError;
                  }
                }),
          ]),
    );
  }
}
