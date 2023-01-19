import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:othia/core/login/login_data.dart';
import 'package:othia/widgets/form_fields.dart';

import '../../utils/helpers/formatters.dart';
import 'exclusives.dart';

class Signup extends StatelessWidget {
  LoginSignupData loginSignupData;

  Signup(this.loginSignupData, {super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController =
        TextEditingController(text: loginSignupData.email);
    TextEditingController passwordController = TextEditingController();
    TextEditingController repeatPasswordController = TextEditingController();
    TextEditingController genderController = TextEditingController();
    //the birthdate Controller just holds the value that will be shown to the user. The Value that will be parsed to the backend is saved in loginSignupData
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
        value: 3,
      ),
    ];
    bool resetError = false;
    return Scaffold(
      appBar: AppBar(),
      body: LoginSignUp(
          topText: AppLocalizations.of(context)!.signup,
          buttonText: AppLocalizations.of(context)!.signup,
          onPressed: (GlobalKey<FormState> key) {
            if (key.currentState!.validate()) {
              //TODO intern save all provided data
              loginSignupData.password = passwordController.text;
              loginSignupData.email = emailController.text;
              signUp(loginSignupData);
            } else {
              Future.delayed(Duration(seconds: 3))
                  .then((value) => key.currentState?.setState(() {
                        resetError = true;
                        key.currentState?.validate();
                        resetError = false;
                      }));
            }
          },
          textFields: [
            getCustomTextFormFieldWithPadding(
              //TODO intern email validation
              hintText: AppLocalizations.of(context)!.eMail,
              iconData: Icons.mail,
              controller: emailController,
              validator: (p0) {
                if (resetError) {
                  return null;
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
              validator: (p0) {
                if (resetError) {
                  return null;
                } else {
                  if (p0 != null) {
                    if (p0.isEmpty) {
                      return AppLocalizations.of(context)!.notEmptyErrorMessage;
                    }
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
            GestureDetector(
              onTap: () async {
                DateTime? foo = await pickBirthDate(context: context);

                birthdateController.text = foo != null
                    ? parseDateTimeToDDMMYYYFormat(foo)
                    : birthdateController.text;
                loginSignupData.birthdate = foo;
              },
              behavior: HitTestBehavior.translucent,
              child: IgnorePointer(
                ignoring: true,
                child: getCustomTextFormFieldWithPadding(
                  validator: (p0) {
                    if (resetError) {
                      return null;
                    } else {
                      if (p0 != null) {
                        if (p0.isEmpty) {
                          return AppLocalizations.of(context)!
                              .notEmptyErrorMessage;
                        }
                      }
                    }
                  },
                  hintText: AppLocalizations.of(context)!.birthdate,
                  iconData: Icons.date_range,
                  controller: birthdateController,
                ),
              ),
            ),
            getCustomDropdownButtonFormFieldWithPadding(
                validator: (p0) {
                  if (resetError) {
                    return null;
                  } else {
                    if (p0 == null) {
                      return AppLocalizations.of(context)!.notEmptyErrorMessage;
                    }
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
                if (resetError) {
                  return null;
                } else {
                  passwordValidator(p0);
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
                hintText: AppLocalizations.of(context)!.repeatPassword,
                iconData: Icons.password,
                controller: repeatPasswordController,
                validator: (String? val) {
                  if (resetError) {
                    return null;
                  } else {
                    if (val != null) {
                      if (val.isEmpty) {
                        return AppLocalizations.of(context)!
                            .notEmptyErrorMessage;
                      }
                    }
                    if (val != passwordController.text) {
                      return AppLocalizations.of(context)!.repeatPasswordError;
                    }
                  }
                }),
          ]),
    );
  }
}
