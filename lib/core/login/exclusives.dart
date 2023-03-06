import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../constants/app_constants.dart';
import '../../constants/colors.dart';
import '../../modules/models/user_info/user_info.dart';
import '../../utils/services/global_navigation_notifier.dart';
import '../../utils/services/rest-api/amplify/amp.dart';
import '../../utils/services/rest-api/rest_api_service.dart';
import '../../utils/ui/ui_utils.dart';
import '../../widgets/form_fields.dart';
import '../main_page.dart';
import 'confirm.dart';
import 'confirm_reset_password.dart';
import 'login.dart';
import 'login_data.dart';

Widget getCustomTextFormFieldWithPadding(
    {EdgeInsets edgeInsets = const EdgeInsets.only(top: 10),
    TextEditingController? controller,
    int errorMaxLines = 1,
    required IconData iconData,
    required String hintText,
    bool obscureText = false,
    String? Function(String?)? validator,
    List<FilteringTextInputFormatter>? inputFormatters,
    String? counterText,
    Widget? suffixIcon,
    void Function()? onTap,
    Key? key,
    bool enabled = true,
    dynamic initialValue}) {
  return Padding(
    padding: edgeInsets,
    child: CustomTextFormField(
      errorMaxLines: errorMaxLines,
      key: key,
      onTap: onTap,
      enabled: enabled,
      inputFormatters: inputFormatters,
      suffixIcon: suffixIcon,
      counterText: counterText,
      obscureText: obscureText,
      maxLines: 1,
      controller: controller,
      iconData: iconData,
      hintText: hintText,
      initialValue: initialValue,
      validator: validator,
    ),
  );
}

Widget getCustomDropdownButtonFormFieldWithPadding({
  required BuildContext context,
  required List<DropdownMenuItem<Object>> items,
  required String hintText,
  required IconData iconData,
  required void Function(Object?) onChangedFunction,
  String? Function(Object?)? validator,
  EdgeInsets edgeInsets = const EdgeInsets.only(top: 10),
}) {
  return Padding(
      padding: edgeInsets,
      child: DropdownButtonFormField(
          validator: validator,
          hint: Text(hintText),
          items: items,
          onChanged: onChangedFunction,
          decoration: InputDecoration(
              prefixIcon: Icon(iconData),
              contentPadding: EdgeInsets.all(5.h),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary),
              ),
              border: OutlineInputBorder())));
}

PreferredSizeWidget getLoginAppBar() {
  return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: Row(
        children: [IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back))],
      ));
}

Future<String?> loginOrSignIn(LoginSignupData loginSignupData, bool isSignUp,
    BuildContext context) async {
  try {
    await RestService().signIn(
      email: loginSignupData.email!,
      password: loginSignupData.password!,
    );
    if (isSignUp) {
      storeUserDataToDB(loginSignupData);
    }
    GlobalNavigationNotifier globalNot =
        Provider.of<GlobalNavigationNotifier>(context, listen: false);
    //TODO intern performance
    await globalNot.initializeUserLoggedIn();
    await globalNot.initializeUserId();
    globalNot.notifyListeners();
    if (globalNot.isUserLoggedIn) {
      //TODO intern maybe forward to where the user was. probably very complicated cause of state management.
      Get.to(MainPage());
    }
  } on UserNotConfirmedException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(AppLocalizations.of(context)!.notYetConfirmed),
    ));
    //forward user to confirmation page
    Get.to(ConfirmationScreen(loginSignupData), duration: Duration.zero);
  } on InvalidParameterException catch (e) {
    //TODO (intern) log this OT-29
  } on UserNotFoundException catch (e) {
    //wrong email
    return AppLocalizations.of(context)!.wrongCredentialsError;
  } on NotAuthorizedException catch (e) {
    //wrong password
    return AppLocalizations.of(context)!.wrongCredentialsError;
  } catch (e) {
    //TODO (intern) log unexpected exeption. OT-29
    print(e);
  }
}

Future<String?> resetPassword(LoginSignupData loginSignupData) async {
  try {
    await RestService().resetPassword(email: loginSignupData.email!);
    Get.to(ConfirmResetPassword(loginSignupData), duration: Duration.zero);
  } on UserNotFoundException catch (e) {
    return AppLocalizations.of(loginContext)!.noEmailError;
  } on Exception catch (e) {
    //TODO (intern) log unexpected exception. OT-29
    print(e);
  }
}

Future<String?> confirm(
    LoginSignupData loginSignupData, BuildContext context) async {
  try {
    await RestService().confirmSignUp(
        confirmationCode: loginSignupData.confirmCode!,
        email: loginSignupData.email!);
    // confirmation successful. user is stored to data base after successful signing in (only then the id can be retrieved)
    return loginOrSignIn(loginSignupData, true, context);
  } on CodeMismatchException catch (e) {
    //user put in the wrong auth Code
    return AppLocalizations.of(loginContext)!.wrongCode;
  } on NotAuthorizedException catch (e) {
    //most likely user is already authorized.
    return AppLocalizations.of(loginContext)!.probalbyAlreadyAuthorized;
  }
}

UserInfo mapLogInDataToUserInfo(
    LoginSignupData loginSignupData, String userId) {
  return UserInfo(
      userId: userId,
      gender: loginSignupData.gender,
      birthdate: loginSignupData.birthdate,
      profileName: loginSignupData.userName!,
      profileEmail: loginSignupData.email!,
      upcomingEventIds: [],
      pastEventIds: [],
      activityIds: []);
}

Future<void> storeUserDataToDB(LoginSignupData loginSignupData) async {
try {
    String userId = await getUserId();
  UserInfo userInfo = mapLogInDataToUserInfo(loginSignupData, userId);
  // TODO clear (extern) error handling
  RestService().savePrivateUserInfo(userInfo: userInfo);
}on SocketException  catch (e) {
  Get.snackbar("", "",titleText: Text(e.toString()),snackPosition: SnackPosition.BOTTOM);
 rethrow;
}
}

Future<String?> signUp(
    LoginSignupData loginSignupData, BuildContext context) async {
  try {
    await RestService().signUp(
      password: loginSignupData.password!,
      email: loginSignupData.email!,
    );
    //sign up was successful. forward user to confirmation
    Get.to(ConfirmationScreen(loginSignupData));
  } on InvalidParameterException catch (e) {
    return AppLocalizations.of(loginContext)!.invalidMailError;
  } on UsernameExistsException catch (e) {
    return AppLocalizations.of(loginContext)!.emailInUse;
  } on AmplifyException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(AppLocalizations.of(loginContext)!.unspecifiedError),
    ));
  } on Exception catch (e) {
    //TODO (intern) log unexpected exeption. OT-29
  }
}

class BaseLoginSignupContainer extends Container {
  BaseLoginSignupContainer({super.key, required Widget child})
      : super(
          child: child,
          padding: EdgeInsets.symmetric(horizontal: 22),
          height: double.infinity,
          width: double.infinity,
          color: bgColor,
        );
}

class LoginSignUp extends StatelessWidget {
  List<Widget> textFields;
  String? topText;
  Function onPressed;
  String buttonText;
  Widget? belowButton;

  Widget? betweenButtonAndTextFields;

  LoginSignUp(
      {super.key,
      this.topText,
      required this.textFields,
      required this.onPressed,
      required this.buttonText,
      this.belowButton,
      this.betweenButtonAndTextFields});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BaseLoginSignupContainer(
        child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          getAssetImage(
            width: 130,
            OthiaConstants.logoName,
          ),
          const SizedBox(
            height: 30,
          ),
          topText != null
              ? Container(
                  // color: Colors.red,
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    topText!,
                    style: Theme.of(context).primaryTextTheme.headlineLarge,
                  ))
              : const SizedBox(
                  height: 20,
                ),
          const SizedBox(
            height: 10,
          ),
          Form(
            key: formKey,
            child: Column(
              children: textFields,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              betweenButtonAndTextFields ?? const SizedBox.expand(),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(80)),
            width: MediaQuery.of(context).size.width / 1.4,
            child: getLoginSignupButton(
                onPressed: onPressed, buttonText: buttonText, key: formKey),
          ),
          Container(
              width: MediaQuery.of(context).size.width / 1.4,
              child: Center(child: belowButton ?? const SizedBox.shrink())),
        ],
      ),
    ));
  }
}

Widget getLoginSignupButton(
    {required Function onPressed, required String buttonText, GlobalKey? key}) {
  return Column(children: [
    Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        //TODO clear (extern) align button Size
        onPressed: () => onPressed(key),
        style: ElevatedButton.styleFrom(
            elevation: 18,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        child: Container(
          height: 47,
          alignment: Alignment.center,
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    )
  
  ]);
}

String? passwordValidator(String? val) {
  if (val != null) {
    if (val.length < 7) {
      return AppLocalizations.of(loginContext)!.passwordLengthError;
    }
  } else {
    //TODO intern
  }
}
