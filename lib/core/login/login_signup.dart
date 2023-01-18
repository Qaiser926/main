import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:othia/core/login/signup.dart';

import '../../utils/services/rest-api/rest_api_service.dart';
import '../../utils/ui/ui_utils.dart';
import 'confirm.dart';
import 'exclusives.dart';
import 'login.dart';
import 'login_data.dart';

//TODO overall sigup and sign in steps: provide feeback for the user after wrong inputs

class LoginSignup extends StatelessWidget {
  LoginSignup({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController numberController = TextEditingController();

    return Scaffold(
      appBar: getLoginAppBar(),
      body: LoginSignUp(
        //TODO i10n
        buttonText: 'Login',
        //TODO i10n
        topText: "Login",
        onPressed: () async {
          LoginSignupData data = LoginSignupData();
          data.phoneNumber = numberController.text;
          try {
            //TODO can we have a nicer workaround here?
            await RestService()
                .signIn(password: "1", phoneNumber: numberController.text);
          } on UserNotFoundException catch (e) {
            //forward to sign in
            Get.to(Signup(data), duration: Duration.zero);
          } on UserNotConfirmedException catch (e) {
            //TODO maybe show snackbar or sth
            //forward user to confirmation page
            Get.to(ConfirmationScreen(data), duration: Duration.zero);
          } on InvalidParameterException catch (e) {
            //TODO somethings wrong. give feedback to the user
          } on NotAuthorizedException catch (e) {
            //forward user to login
            Get.to(Login(data), duration: Duration.zero);
          } catch (e) {
            //TODO log unexpected exeption.
            print(e);
          }
        },
        textFields: [
          getCustomTextFormFieldWithPadding(
            controller: numberController,
            iconData: Icons.phone,
            //TODO i10n
            hintText: "Number",
          ),
        ],
        belowButton: Column(
          //TODO implement auth provider. make buttons from these icons
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getAssetImage("signinfacebook.png", width: 220),

            const SizedBox(
              width: 15,
            ),
            getAssetImage("applesignin.png", width: 180),

            //TODO add missing auth providers
          ],
        ),
      ),
    );
  }
}
