import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:othia/modules/models/shared_data_models.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:othia/widgets/form_fields.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../modules/models/user_info/user_info.dart';
import '../../../utils/helpers/formatters.dart';
import '../../../utils/services/data_handling/data_handling.dart';
import '../../../utils/services/rest-api/amplify/amp.dart';
import '../../../utils/services/rest-api/rest_api_service.dart';
import '../profile.dart';
import '../user_info_notifier.dart';

enum FieldType { name, birthdate, gender }

enum WidgetTypes {
  icon,
  title,
  validationFunction,
  formKey,
}

// TODO clear (extern) when opening the dialogs, the bottom overflows. Please solve this. It is not required that the "Delete Account" button stays in a bottom app bar.

class EditProfile extends StatefulWidget {
  final UserInfoNotifier userInfoNotifier;

  EditProfile(UserInfoNotifier this.userInfoNotifier, {super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late final BuildContext localizationAndThemeContext;

  @override
  Widget build(BuildContext context) {
    localizationAndThemeContext = context;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: widget.userInfoNotifier,
          )
        ],
        builder: (context, child) {
          return SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 1000,
              child: Scaffold(
                appBar: AppBar(
                    // TODO clear (extern) align design
                    leading: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    toolbarHeight: 53.h,
                    elevation: 0,
                    title: Text(AppLocalizations.of(context)!.editProfile),
                    centerTitle: true,
                    automaticallyImplyLeading: false),
                bottomNavigationBar: getDeleteButton(context),
                body: Consumer<UserInfoNotifier>(
                    builder: (context, model, child) {
                  TextEditingController nameController = TextEditingController(
                      text: model.newUserInfo.profileName);
                  TextEditingController emailController = TextEditingController(
                      text: model.newUserInfo.profileEmail);
                  TextEditingController birthdateController =
                      TextEditingController(
                          text: model.newUserInfo.birthdate.toString());
                  TextEditingController genderController =
                      TextEditingController(
                          text: genderToString(
                              model.newUserInfo.gender, context));
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: ListView(children: [
                      getVerSpace(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          getProfilePhotoStack(model.newUserInfo, context),
                        ],
                      ),
                      getVerSpace(40.h),
                      getItem(
                        context,
                        fieldType: FieldType.name,
                        controller: nameController,
                      ),
                      getVerSpace(5.h),
                      Divider(
                        thickness: 2.h,
                      ),
                      getVerSpace(15.h),
                      getItem(
                        context,
                        fieldType: FieldType.gender,
                        controller: genderController,
                      ),
                      getVerSpace(5.h),
                      Divider(
                        thickness: 2.h,
                      ),
                      getVerSpace(15.h),
                      getItem(
                        context,
                        fieldType: FieldType.birthdate,
                        controller: birthdateController,
                      ),
                    ]),
                  );
                }),
              ),
            ),
          );
        });
  }

  Widget getDeleteButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: primaryColor,
            backgroundColor: listItemColor,
            minimumSize:
                Size(double.infinity, 35.h), // <--- this line helped me
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                        AppLocalizations.of(localizationAndThemeContext)!
                            .deleteAccountDialogTitle),
                    content: Text(
                        AppLocalizations.of(localizationAndThemeContext)!
                            .deleteAccountDialogContent),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                              AppLocalizations.of(localizationAndThemeContext)!
                                  .cancel)),
                      TextButton(
                          onPressed: () async {
                            dynamic restResponse =
                                await RestService().deleteAccount();
                            try {
                              if (restResponse.statusCode == 200) {
                                deleteUser();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(AppLocalizations.of(
                                          localizationAndThemeContext)!
                                      .deleteAccountSuccess),
                                ));
                              } else {
                                throw Exception();
                              }
                            } on Exception catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(AppLocalizations.of(
                                              localizationAndThemeContext)!
                                          .deleteAccountFailure)));
                            }
                            Navigator.of(context).pop();
                          },
                          child: Text(
                              AppLocalizations.of(localizationAndThemeContext)!
                                  .delete)),
                    ],
                  );
                });
          },
          child: Text(
            AppLocalizations.of(localizationAndThemeContext)!.deleteAccount,
          ),
        ),
      ),
    );
  }

  Future getDialog(
      {required BuildContext context,
      required dynamic initValue,
      required Text hint,
      required GlobalKey<FormState> formKey,
      required String? Function(String?) validationFunction,
      required FieldType fieldType}) {
    TextEditingController controller = TextEditingController(text: initValue);
    controller.selection =
        TextSelection(baseOffset: 0, extentOffset: controller.text.length);

    dynamic val = showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            getVerSpace(10.h),
            Form(
              key: formKey,
              child: fieldType == FieldType.name
                  ? TextFormField(
                      autofocus: true,
                      decoration: new InputDecoration(
                          contentPadding: EdgeInsets.all(5.h),
                          border: OutlineInputBorder(),
                          hintText: hint.data),
                      controller: controller,
                      validator: validationFunction,
                    )
                  : getDropDownFormField(
                      context: context,
                      hintText: hint.data!,
                      dropDownList: [
                        AppLocalizations.of(localizationAndThemeContext)!
                            .female,
                        AppLocalizations.of(localizationAndThemeContext)!.male,
                        AppLocalizations.of(localizationAndThemeContext)!
                            .diverse
                      ],
                      defaultValue: initValue,
                      onInvalidErrorText: "cannot be empty",
                      onChangedFunction: (value) {
                        controller.value = TextEditingValue(text: value);
                      },
                    ),
            ),
            getVerSpace(10.h),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, null),
                  child: Text(AppLocalizations.of(localizationAndThemeContext)!
                      .cancel)),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.pop(context, controller.text);
                    }
                  },
                  child: Text(
                      AppLocalizations.of(localizationAndThemeContext)!.save)),
            ]),
          ],
        );
      },
    );
    return val;
  }

  String? _validateName(String? text) {
    if (text?.length == 0) {
      return AppLocalizations.of(context)!.editNameErrorMessage;
    }
    return null;
  }

  Widget getItem(
    BuildContext context, {
    required FieldType fieldType,
    required TextEditingController controller,
  }) {
    Map<WidgetTypes, dynamic> dynamicWidgets = getFieldValues(fieldType);

    return InkWell(
      onTap: () async {
        Future<dynamic> dialogReturn = fieldType != FieldType.birthdate
            ? getDialog(
                context: context,
                initValue: controller.text,
                hint: dynamicWidgets[WidgetTypes.title]!,
                formKey: dynamicWidgets[WidgetTypes.formKey]!,
                validationFunction:
                    dynamicWidgets[WidgetTypes.validationFunction],
                fieldType: fieldType)
            : pickBirthDate(
                initialDate: controller.value.text, context: context);
        Provider.of<UserInfoNotifier>(context, listen: false).updateUserInfo(
            profileField: fieldType,
            value: fieldType == FieldType.gender
                ? stringToGender(await dialogReturn, context)
                : await dialogReturn);
      },
      child: Container(
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          dynamicWidgets[WidgetTypes.icon]!,
          SizedBox(
            width: 10,
          ),
          SizedBox(
            height: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dynamicWidgets[WidgetTypes.title]!,
                Text(fieldType != FieldType.birthdate
                    ? controller.text
                    : parseDateTimeToDDMMYYYFormat(
                        DateTime.parse(controller.text))),
              ],
            ),
          ),
          Spacer(),
          Icon(Icons.edit),
        ]),
      ),
    );
  }

  Stack getProfilePhotoStack(UserInfo userInfo, BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
            radius: 90, backgroundImage: getProfilePictureNullSafe(userInfo)),
        Positioned(
          child: Container(
            height: 30.h,
            width: 30.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.h),
                color: Theme.of(context).colorScheme.primary,
                boxShadow: [
                  BoxShadow(
                      color: shadowColor,
                      offset: const Offset(0, 8),
                      blurRadius: 27)
                ]),
            padding: EdgeInsets.all(5.h),
            child: GestureDetector(
              onTap: () async {
                String? path = await getFromGallery();
                if (path != null) {
                  final bytes = File(path).readAsBytesSync();
                  final img64 = base64Encode(bytes);
                  widget.userInfoNotifier.updateUserInfo(image: img64);
                }
              },
              child: Icon(
                Icons.edit,
                size: 20.h,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }

  Map<WidgetTypes, dynamic> getFieldValues(FieldType profileFields) {
    switch (profileFields) {
      case FieldType.birthdate:
        {
          String title =
              AppLocalizations.of(localizationAndThemeContext)!.birthdate;
          return {
            WidgetTypes.title: getTitle(title),
            WidgetTypes.icon: Icon(Icons.date_range),
            WidgetTypes.formKey: GlobalKey<FormState>(),
            WidgetTypes.validationFunction: (_) {}
          };
        }

      case FieldType.gender:
        {
          String title =
              AppLocalizations.of(localizationAndThemeContext)!.gender;
          return {
            WidgetTypes.title: getTitle(title),
            WidgetTypes.icon: Icon(Icons.accessibility_new),
            WidgetTypes.formKey: GlobalKey<FormState>(),
            WidgetTypes.validationFunction: (_) {}
          };
        }

      case FieldType.name:
        {
          String title = AppLocalizations.of(localizationAndThemeContext)!.name;
          return {
            WidgetTypes.title: getTitle(title),
            WidgetTypes.icon: Icon(Icons.person),
            WidgetTypes.formKey: GlobalKey<FormState>(),
            WidgetTypes.validationFunction: _validateName
          };
        }
    }
  }

  Text getTitle(String headlineText) {
    return Text(headlineText,
        style:
            Theme.of(localizationAndThemeContext).primaryTextTheme.labelMedium);
  }
}
