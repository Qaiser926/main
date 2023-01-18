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

class LoginSignup extends StatelessWidget {
  LoginSignup({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController numberController = TextEditingController();
    // RestService().signIn(username: "mattistest", password: "12345678");

    return Scaffold(
      appBar: getLoginAppBar(),
      body: BaseLoginSignupContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(

                  // color: Colors.red,
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Login",
                    style: Theme.of(context).primaryTextTheme.displaySmall,
                  )),
              // getSome("Number", Icons.phone, ),
              // TextFormField(decoration: InputDecoration(icon: Icon(Icons.ac_unit))),
              SizedBox(
                height: 10,
              ),
              getCustomTextFormFieldWithPadding(
                controller: numberController,
                iconData: Icons.phone,
                hintText: "Number",
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  LoginSignupData data = LoginSignupData();
                  data.number = numberController.text;
                  try {
                    await RestService()
                        .signIn(password: "1", username: numberController.text);
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
                style: ElevatedButton.styleFrom(
                    elevation: 18,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: Container(
                  width: 180,
                  height: 45,
                  alignment: Alignment.center,
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getAssetImage("signinfacebook.png", width: 220),

                  const SizedBox(
                    width: 15,
                  ),
                  getAssetImage("applesignin.png", width: 180),

                  // const SizedBox(
                  //   width: 15,
                  // ),
                  // Image.asset(
                  //   "images/Tiktok.png",
                  //   width: 80,
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
