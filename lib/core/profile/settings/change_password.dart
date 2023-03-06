import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../utils/helpers/validators.dart';
import '../../../utils/services/rest-api/rest_api_service.dart';

// TODO (intern) notify users about success / failure

enum ChangePasswordFields {
  _old,
  _new,
  _confirm,
}

class ChangeNot extends ChangeNotifier {
  Map<ChangePasswordFields, bool> changePasswordFields = {
    ChangePasswordFields._confirm: true,
    ChangePasswordFields._new: true,
    ChangePasswordFields._old: true
  };

  bool shouldObscureText(ChangePasswordFields changePasswordField) {
    return changePasswordFields.containsKey(changePasswordField)
        ? changePasswordFields[changePasswordField]!
        : true;
  }

  void switchObscureText(ChangePasswordFields changePasswordField) {
    changePasswordFields[changePasswordField] =
        changePasswordFields.containsKey(changePasswordField)
            ? !changePasswordFields[changePasswordField]!
            : true;
    notifyListeners();
  }
}

class ChangePasswordScreen extends StatelessWidget {
  GlobalKey<FormState> changePasswordKey = GlobalKey();

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  late final BuildContext localizationContext;

  @override
  Widget build(BuildContext context) {
    localizationContext = context;
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: ChangeNot())],
      child: Scaffold(
        // TODO clear (extern) align colors
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight: 53.h,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.primary,
              )),
          title: Text(AppLocalizations.of(context)!.changePassword),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<ChangeNot>(builder: (context, model, child) {
                  return Form(
                    key: changePasswordKey,
                    child: Column(children: [
                      PasswordFormField(
                        hintText: AppLocalizations.of(localizationContext)!
                            .oldPassword,
                        controller: _oldPasswordController,
                        obscureText:
                            model.shouldObscureText(ChangePasswordFields._old),
                        validator: oldPasswordValidator,
                        onPressed: getOnPressedFunction(
                            context, ChangePasswordFields._old),
                      ),
                      getVerSpace(20.h),
                      PasswordFormField(
                        hintText: AppLocalizations.of(localizationContext)!
                            .newPassword,
                        controller: _newPasswordController,
                        validator: newPasswordValidator,
                        obscureText:
                            model.shouldObscureText(ChangePasswordFields._new),
                        onPressed: getOnPressedFunction(
                            context, ChangePasswordFields._new),
                      ),
                      getVerSpace(5.h),
                      PasswordFormField(
                        hintText: AppLocalizations.of(localizationContext)!
                            .confirmPassword,
                        controller: _confirmPasswordController,
                        obscureText: model
                            .shouldObscureText(ChangePasswordFields._confirm),
                        onPressed: getOnPressedFunction(
                            context, ChangePasswordFields._confirm),
                        validator: newPasswordValidator,
                      ),
                    ]),
                  );
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          if (changePasswordKey.currentState!.validate()) {
                            RestService().updatePassword(
                                oldPassword: _oldPasswordController.text,
                                newPassword: _confirmPasswordController.text);
                          } else {
                            //input is not valid. do nothing
                          }
                        },
                        child: Text(
                            AppLocalizations.of(localizationContext)!.confirm))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? oldPasswordValidator(String value) {
    if (!checkMinPasswordLength(value)) {
      return AppLocalizations.of(localizationContext)!
          .shortPasswordErrorMessage(OtherConstants.minPasswordLength);
    } else if (!checkMaxPasswordLength(value)) {
      return AppLocalizations.of(localizationContext)!
          .longPasswordErrorMessage(OtherConstants.maxPasswordLength);
    } else {
      return null;
    }
  }

  String? newPasswordValidator(String value) {
    if (!checkMinPasswordLength(value)) {
      return AppLocalizations.of(localizationContext)!
          .shortPasswordErrorMessage(OtherConstants.minPasswordLength);
    } else if (!checkMaxPasswordLength(value)) {
      return AppLocalizations.of(localizationContext)!
          .longPasswordErrorMessage(OtherConstants.maxPasswordLength);
    } else if (_newPasswordController.text != _confirmPasswordController.text) {
      return AppLocalizations.of(localizationContext)!
          .matchingPasswordErrorMessage;
    } else {
      return null;
    }
  }

  Function getOnPressedFunction(
      BuildContext context, ChangePasswordFields changePasswordField) {
    onPressed() {
      ChangeNot changeNot = Provider.of<ChangeNot>(context, listen: false);
      changeNot.switchObscureText(changePasswordField);
    }

    return onPressed;
  }
}

class PasswordFormField extends TextFormField {
  PasswordFormField(
      {super.key,
      required bool obscureText,
      required String hintText,
      required Function onPressed,
      required TextEditingController controller,
      Function? validator})
      : super(
          controller: controller,
          obscureText: obscureText,
          validator: validator != null ? (value) => validator(value) : null,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(5.h),
            border: OutlineInputBorder(),
            hintText: hintText,
            suffixIcon: IconButton(
              onPressed: () => onPressed(),
              icon: Icon(
                Icons.remove_red_eye_sharp,
                color: obscureText ? greyColor : primaryColor,
              ),
            ),
          ),
        );
}
