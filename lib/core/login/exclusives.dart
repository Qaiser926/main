import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../constants/app_constants.dart';
import '../../constants/colors.dart';
import '../../utils/services/global_navigation_notifier.dart';
import '../../utils/services/rest-api/rest_api_service.dart';
import '../../utils/ui/ui_utils.dart';
import '../../widgets/form_fields.dart';
import '../main_page.dart';
import 'confirm.dart';
import 'login_data.dart';

Widget getCustomTextFormFieldWithPadding(
    {EdgeInsets edgeInsets = const EdgeInsets.symmetric(vertical: 5),
    required TextEditingController controller,
    required IconData iconData,
    required String hintText,
    dynamic initialValue}) {
  return Padding(
    padding: edgeInsets,
    child: CustomTextFormField(
      controller: controller,
      iconData: iconData,
      hintText: hintText,
      initialValue: initialValue,
    ),
  );
}

PreferredSizeWidget getLoginAppBar() {
  return PreferredSize(
    preferredSize: Size.fromHeight(200.0),
    child: Container(
      color: listItemColor,
      child: Column(children: [
        Container(
          margin: const EdgeInsets.only(top: 50),
          child:
              getAssetImage(OthiaConstants.logoName, width: 150, height: 150),
        ),
      ]),
    ),
  );
}

void signIn(LoginSignupData loginSignupData, BuildContext context) async {
  try {
    await RestService().signIn(
      username: loginSignupData.number!,
      password: loginSignupData.password!,
    );
    GlobalNavigationNotifier globalNot =
        Provider.of<GlobalNavigationNotifier>(context, listen: false);
    //TODO perfomance
    await globalNot.initializeUserLoggedIn();
    await globalNot.initializeUserId();
    globalNot.notifyListeners();
    if (globalNot.isUserLoggedIn) {
      //TODO maybe forward to where the user was. probably very conplicated cause of state management.
      Get.to(MainPage());
    }
  } on Exception catch (e) {
    //TODO show feedback here
    //TODO log unexpected behaviour
  }
}

void confirm(LoginSignupData loginSignupData, BuildContext context) async {
  try {
    await RestService().confirm(
        confirmationCode: loginSignupData.confirmCode!,
        username: loginSignupData.number!);
    signIn(loginSignupData, context);
  } on CodeMismatchException catch (e) {
    //TODO show feedback here
    //user put in the wrong auth Code
  } on NotAuthorizedException catch (e) {
    //TODO show feedback here
    //most likely user is already authorized.
  }
}

void signUp(LoginSignupData loginSignupData) async {
  try {
    await RestService().signUp(
        password: loginSignupData.password!,
        email: loginSignupData.email!,
        username: loginSignupData.username!);
    //sign up was successfull. forward user to confirmation
    Get.to(ConfirmationScreen(loginSignupData));
  } on Exception catch (e) {
    //TODO catch specific
    //todo forward to code confirmation page
  }
}

class BaseLoginSignupContainer extends Container {
  BaseLoginSignupContainer({super.key, required Widget child})
      : super(
            child: Container(
                child: child,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                margin: const EdgeInsets.only(
                  top: 30,
                ),
                padding: EdgeInsets.symmetric(horizontal: 22)),
            height: double.infinity,
            width: double.infinity,
            color: listItemColor);
}

class LoginSignUp extends StatelessWidget {
  Column textFields;
  String topText;
  Function onPressed;
  String buttonText;

  LoginSignUp({
    super.key,
    required this.topText,
    required this.textFields,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return BaseLoginSignupContainer(
        child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
              // color: Colors.red,
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 22, bottom: 20),
              child: Text(
                topText,
                style: Theme.of(context).primaryTextTheme.displayMedium,
              )),
          textFields,
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () => onPressed,
            style: ElevatedButton.styleFrom(
                elevation: 18,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
            child: Container(
              width: 180,
              height: 45,
              alignment: Alignment.center,
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    ));
  }
}
