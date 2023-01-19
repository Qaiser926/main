import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:othia/core/login/reset_password.dart';
import 'package:othia/core/login/signup.dart';

import 'exclusives.dart';
import 'login_data.dart';

//TODO overall sigup and sign in steps: provide feeback for the user after wrong inputs

late BuildContext loginContext;

class Login extends StatelessWidget {
  Login({super.key});

  @override
  Widget build(BuildContext context) {
    loginContext = context;
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: LoginSignUp(
          buttonText: AppLocalizations.of(context)!.login,
          topText: AppLocalizations.of(context)!.login,
          onPressed: (GlobalKey<FormState> key) async {
            if (key.currentState!.validate()) {
              LoginSignupData data = LoginSignupData();
              data.email = emailController.text;
              data.password = passwordController.text;
              signIn(data, context);
            }
          },
          textFields: [
            getCustomTextFormFieldWithPadding(
              controller: emailController,
              iconData: Icons.mail,
              hintText: AppLocalizations.of(context)!.eMail,
            ),
            getCustomTextFormFieldWithPadding(
                obscureText: true,
                controller: passwordController,
                iconData: Icons.key,
                hintText: AppLocalizations.of(context)!.password,
                validator: passwordValidator)
          ],
          betweenButtonAndTextFields: SizedBox(
            height: 30,
            child: TextButton(
                onPressed: () =>
                    Get.to(ResetPassword(), duration: Duration.zero),
                child: Text(AppLocalizations.of(context)!.recoverPassword)),
          ),
          belowButton: Column(
            children: [
              const Divider(),

              getLoginSignupButton(
                  buttonText: AppLocalizations.of(context)!.signup,
                  onPressed: (key) {
                    LoginSignupData data = LoginSignupData();
                    data.email = emailController.text;
                    data.password = passwordController.text;
                    Get.to(Signup(data), duration: Duration.zero);
                  }),
              //TODO (intern) add auth Providers like facebook, google, apple ...
            ],
          )),
    );
  }
}
