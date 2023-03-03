import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:othia/core/login/reset_password.dart';
import 'package:othia/core/login/signup.dart';

import 'exclusives.dart';
import 'login_data.dart';

late BuildContext loginContext;

class Login extends StatelessWidget {
  Login({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.setCurrentScreen(
      screenName: 'loginScreen',
    );
    loginContext = context;
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    String? errorMessage;
    return Scaffold(
      appBar: AppBar(),
      body: LoginSignUp(
          buttonText: AppLocalizations.of(context)!.login,
          topText: AppLocalizations.of(context)!.login,
          onPressed: (GlobalKey<FormState> key) async {
            if (key.currentState!.validate()) {
              LoginSignupData loginData = LoginSignupData();
              loginData.email = emailController.text.trim();
              loginData.password = passwordController.text.trim();
              String? result = await loginOrSignIn(loginData, true, context);
              if (result != null) {
                errorMessage = result;
                key.currentState?.validate();
                errorMessage = null;
              }
            }
          },
          textFields: [
            getCustomTextFormFieldWithPadding(
              //TODO clear (extern) remove spaces after email
              controller: emailController,
              iconData: Icons.mail,
              hintText: AppLocalizations.of(context)!.eMail,
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
            ),
            getCustomTextFormFieldWithPadding(
              obscureText: true,
              controller: passwordController,
              iconData: Icons.key,
              hintText: AppLocalizations.of(context)!.password,
              validator: (p0) {
                if (errorMessage != null) {
                  return errorMessage;
                } else {
                  String? result = passwordValidator(p0);
                  if (result != null) {
                    return result;
                  }
                  if (p0 != null) {
                    if (p0.isEmpty) {
                      return AppLocalizations.of(context)!.notEmptyErrorMessage;
                    }
                  }
                }
              },
            )
          ],
          betweenButtonAndTextFields: SizedBox(
            height: 30,
            child: Padding(
              padding:  EdgeInsets.only(left: 0.w),
              child: TextButton(
                  onPressed: () =>
                      Get.to(ResetPassword(), duration: Duration.zero),
                  child: Text(AppLocalizations.of(context)!.recoverPassword)),
            ),
          ),
          belowButton: Column(
            children: [
              const Divider(),
              getLoginSignupButton(
                  buttonText: AppLocalizations.of(context)!.signup,
                  onPressed: (key) {
                    LoginSignupData data = LoginSignupData();
                    data.email = emailController.value.text.trim();
                    data.password = passwordController.text.trim();
                    Get.to(Signup(data), duration: Duration.zero);
                  }),
              //TODO (intern) add auth Providers like facebook, google, apple ...
            ],
          )),
    );
  }
}
