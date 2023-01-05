import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../modules/models/user_info/user_info.dart';
import '../../../utils/services/data_handling/data_handling.dart';
import '../../../utils/services/rest-api/rest_api_service.dart';
import '../profile.dart';
import '../user_info_notifier.dart';

enum ProfileFields { name, eMail, birthdate, gender }

enum WidgetTypes { icon, title, dialogTitle }

class EditProfile extends StatelessWidget {
  final UserInfoNotifier userInfoNotifier;

  EditProfile(UserInfoNotifier this.userInfoNotifier, {super.key});

  late final BuildContext localizationAndThemeContext;

  @override
  Widget build(BuildContext context) {
    localizationAndThemeContext = context;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: userInfoNotifier,
          )
        ],
        builder: (context, child) {
          return SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 1000,
              child: Scaffold(
                bottomNavigationBar: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: primaryColor,
                        backgroundColor: listItemColor,
                        minimumSize: Size(
                            double.infinity, 35.h), // <--- this line helped me
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(AppLocalizations.of(
                                        localizationAndThemeContext)!
                                    .deleteAccountDialogTitle),
                                content: Text(AppLocalizations.of(
                                        localizationAndThemeContext)!
                                    .deleteAccountDialogContent),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(AppLocalizations.of(
                                              localizationAndThemeContext)!
                                          .cancel)),
                                  TextButton(
                                      onPressed: () {
                                        RestService().deleteAccount("as"
                                            // userInfoNotifier.userInfo.userId
                                            );
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(AppLocalizations.of(
                                              localizationAndThemeContext)!
                                          .delete)),
                                ],
                              );
                            });
                      },
                      child: Text(
                        // TODO
                        "Delete Account",
                      ),
                    ),
                  ),
                ),
                body: Consumer<UserInfoNotifier>(
                    builder: (context, model, child) {
                  TextEditingController nameController = TextEditingController(
                      text: model.newUserInfo.profileName);
                  TextEditingController emailController = TextEditingController(
                      text: model.newUserInfo.profileEMail);
                  TextEditingController birthdateController =
                      TextEditingController(text: model.newUserInfo.birthdate);
                  TextEditingController genderController =
                      TextEditingController(text: model.newUserInfo.gender);
                  return Column(children: [
                    getProfilePhotoStack(model.newUserInfo, context),
                    SizedBox(
                      height: 20,
                    ),
                    getItem(
                      context,
                      profileField: ProfileFields.name,
                      controller: nameController,
                    ),
                    // Divider(),
                    // getItem(
                    //   context,
                    //   profileField: ProfileFields.eMail,
                    //   controller: emailController,
                    // ),
                    Divider(),
                    getItem(
                      context,
                      profileField: ProfileFields.gender,
                      controller: genderController,
                    ),
                    Divider(),
                    getItem(
                      context,
                      profileField: ProfileFields.birthdate,
                      controller: birthdateController,
                    ),
                  ]);
                }),
              ),
            ),
          );
        });
  }

  Future getDialog(BuildContext context, String initValue, Widget title,
      ProfileFields profileField) {
    TextEditingController controller = TextEditingController(text: initValue);
    controller.selection =
        TextSelection(baseOffset: 0, extentOffset: controller.text.length);

    dynamic val = showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: title,
          actions: [
            TextFormField(
              autofocus: true,
              controller: controller,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, null),
                  child: Text(AppLocalizations.of(localizationAndThemeContext)!
                      .cancel)),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, controller.text),
                  child: Text(
                      AppLocalizations.of(localizationAndThemeContext)!.save)),
            ]),
          ],
        );
      },
    );
    return val;
  }

  Widget getItem(
    BuildContext context, {
    required ProfileFields profileField,
    required TextEditingController controller,
  }) {
    Map<WidgetTypes, Widget> dynamicWidgets = getFieldValues(profileField);

    return InkWell(
      onTap: () async {
        Future val = getDialog(context, controller.text,
            dynamicWidgets[WidgetTypes.dialogTitle]!, profileField);
        Provider.of<UserInfoNotifier>(context, listen: false)
            .updateUserInfo(profileField: profileField, value: await val);
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
                Text(controller.text),
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
                  userInfoNotifier.updateUserInfo(image: img64);
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

  Map<WidgetTypes, Widget> getFieldValues(ProfileFields profileFields) {
    switch (profileFields) {
      case ProfileFields.birthdate:
        {
          String title =
              AppLocalizations.of(localizationAndThemeContext)!.birthdate;
          return {
            WidgetTypes.title: getTitle(title),
            WidgetTypes.icon: getIcon(Icons.date_range),
            WidgetTypes.dialogTitle: getDialogTitle(
                AppLocalizations.of(localizationAndThemeContext)!
                    .profileDialogTitle(title)),
          };
        }

      case ProfileFields.gender:
        {
          String title =
              AppLocalizations.of(localizationAndThemeContext)!.gender;
          return {
            WidgetTypes.title: getTitle(title),
            WidgetTypes.icon: getIcon(Icons.accessibility_new),
            WidgetTypes.dialogTitle: getDialogTitle(
                AppLocalizations.of(localizationAndThemeContext)!
                    .profileDialogTitle(title)),
          };
        }

      case ProfileFields.eMail:
        {
          String title =
              AppLocalizations.of(localizationAndThemeContext)!.eMail;
          return {
            WidgetTypes.title: getTitle(title),
            WidgetTypes.icon: getIcon(Icons.alternate_email_outlined),
            WidgetTypes.dialogTitle: getDialogTitle(
                AppLocalizations.of(localizationAndThemeContext)!
                    .profileDialogTitle(title)),
          };
        }

      case ProfileFields.name:
        {
          return getWidgetMap(
              AppLocalizations.of(localizationAndThemeContext)!.name,
              Icons.account_circle);
        }
    }
  }

  Map<WidgetTypes, Widget> getWidgetMap(String title, IconData iconData) {
    return {
      WidgetTypes.title: getTitle(title),
      WidgetTypes.icon: getIcon(iconData),
      WidgetTypes.dialogTitle: getDialogTitle(
          AppLocalizations.of(localizationAndThemeContext)!
              .profileDialogTitle(title)),
    };
  }

  Icon getIcon(IconData iconData) {
    return Icon(iconData);
  }

  Text getTitle(String headlineText) {
    return Text(headlineText,
        style:
            Theme.of(localizationAndThemeContext).primaryTextTheme.labelMedium);
  }

  Text getDialogTitle(String title) {
    return Text(title);
  }
}
