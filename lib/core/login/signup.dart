import 'package:checkbox_formfield/checkbox_list_tile_formfield.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/core/login/login_data.dart';
import 'package:othia/widgets/form_fields.dart';

import '../../constants/asset_constants.dart';
import '../../modules/models/shared_data_models.dart';
import '../../utils/helpers/formatters.dart';
import '../add/add_exclusives/help_functions.dart';
import 'exclusives.dart';

class Signup extends StatelessWidget {
  //the birthdate Controller just holds the value that will be shown to the user. The Value that will be parsed to the backend is saved in loginSignupData
  TextEditingController birthdateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  LoginSignupData loginSignupData;

  Signup(this.loginSignupData, {super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.setCurrentScreen(
      screenName: 'signUpScreen',
    );
    TextEditingController emailController =
        TextEditingController(text: loginSignupData.email);
    TextEditingController passwordController = TextEditingController();
    TextEditingController repeatPasswordController = TextEditingController();

    List<DropdownMenuItem<Object>> items = [
      DropdownMenuItem(
        child: Text(AppLocalizations.of(context)!.female),
        value: Gender.female,
      ),
      DropdownMenuItem(
        child: Text(AppLocalizations.of(context)!.male),
        value: Gender.male,
      ),
      DropdownMenuItem(
        child: Text(AppLocalizations.of(context)!.diverseGender),
        value: Gender.diverse,
      ),
    ];
    bool resetError = false;
    String? emailErrorMessage;
    GlobalKey<EditableTextState> emailKey = GlobalKey();
    return Scaffold(
      appBar: AppBar(),
      body: 
      LoginSignUp(
          topText: AppLocalizations.of(context)!.signup,
          buttonText: AppLocalizations.of(context)!.signup,
          onPressed: (GlobalKey<FormState> key) async {
            loginSignupData.userName = this.nameController.text;
            if (key.currentState!.validate()) {
              loginSignupData.password = passwordController.text;
              loginSignupData.email = emailController.text.trim();
              //at the time of coding the function signUp only returns error Messages for the Email inout. if we want to add error messages for other input fields it will get a lot more complicated
              emailErrorMessage = await signUp(loginSignupData, context);
              key.currentState!.validate();
              emailErrorMessage = null;
            } else {
              Future.delayed(Duration(seconds: 3)).then(
                    (value) => key.currentState?.setState(() {
                  resetError = true;
                  key.currentState?.validate();
                  resetError = false;
                }),
              );
            }
          },
          textFields: [
            getCustomTextFormFieldWithPadding(
              errorMaxLines: 2,
              key: emailKey,
              //TODO clear (extern) remove spaces after email
              hintText: AppLocalizations.of(context)!.eMail,
              iconData: Icons.mail,
              controller: emailController,
              validator: (p0) {
                if (resetError) {
                  return null;
                } else if (emailErrorMessage != null) {
                  return emailErrorMessage;
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
                DateTime? pickedBirthDate =
                await pickBirthDate(context: context);

                birthdateController.text = pickedBirthDate != null
                    ? parseDateTimeToDDMMYYYFormat(pickedBirthDate)
                    : birthdateController.text;
                loginSignupData.birthdate = pickedBirthDate;
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
                onChangedFunction: (value) {
                  loginSignupData.gender = value;
                },
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
              iconData: Icons.key,
              controller: passwordController,
              validator: (p0) {
                if (resetError) {
                  return null;
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
            ),
           
            getCustomTextFormFieldWithPadding(
                obscureText: true,
                hintText: AppLocalizations.of(context)!.repeatPassword,
                iconData: Icons.key,
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
            CheckboxListTileFormField(
              title: GestureDetector(
                onTap: () => {
                  getInfoDialog(
                      content: SingleChildScrollView(
                          child: Html(
                        data: AssetConstants.dataProtectionDisclaimer,
                      )),
                      context: context)
                },
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: Text(
                          AppLocalizations.of(context)!.termsConditionsHint,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Theme.of(context).primaryColorLight),
                        ),
                      ),
                      SizedBox(width: 8.h),
                      Icon(Icons.info_outline, size: 20.h)
                    ],
                  ),
                ),
              ),
              checkColor: Theme.of(context).colorScheme.primary,
              activeColor: Theme.of(context).colorScheme.secondary,
              validator: (bool? value) {
                if (resetError) {
                  return null;
                } else {
                  if (value!) {
                    return null;
                  } else {
                    return AppLocalizations.of(context)!.termsConditionsError;
                  }
                }
              },
              autovalidateMode: AutovalidateMode.disabled,
              contentPadding: EdgeInsets.all(1),
            ),
        
          ]),
    
    );
  }
}
