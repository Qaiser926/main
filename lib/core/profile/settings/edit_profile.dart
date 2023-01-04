import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../modules/models/user_info/user_info.dart';
import '../../../utils/services/data_handling/data_handling.dart';
import '../profile.dart';
import '../user_info_notifier.dart';

class EditProfile extends StatelessWidget {
  final UserInfoNotifier userInfoNotifier;

  EditProfile(UserInfoNotifier this.userInfoNotifier, {super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: userInfoNotifier.newUserInfo.profileName);
    TextEditingController emailController =
        TextEditingController(text: userInfoNotifier.newUserInfo.profileEMail);
    TextEditingController birthdateController =
        TextEditingController(text: "birthdate");
    TextEditingController genderController =
        TextEditingController(text: "diverse");
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: userInfoNotifier,
          )
        ],
        builder: (context, child) {
          return SafeArea(
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
                              title: Text(
                                  "Do you really want to delete your account?"),
                              content: Text(
                                  "this step is nicht rückgängig zu machen"),
                              actions: [
                                TextButton(onPressed: () {}, child: Text("sf")),
                                TextButton(
                                    onPressed: () {}, child: Text("csf")),
                              ],
                            );
                          });

                      // AlertDialog(title: Text("dfd"),);
                      //
                      //
                      // await Dialog(
                      //   child: Text("dfssd"),
                      // );
                      //TODO account deletion workflow
                    },
                    child: Text(
                      "Delete Account",
                    ),
                  ),
                ),
              ),
              body:
                  Consumer<UserInfoNotifier>(builder: (context, model, child) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(children: [
                    getProfilePhotoStack(model.newUserInfo, context),
                    getItem(context,
                        controller: nameController,
                        headline: "Name",
                        leadingIcon: Icons.account_circle, onTap: () {
                      print("name pressed");
                    }),
                    Divider(),
                    getItem(context,
                        controller: emailController,
                        headline: "Email",
                        leadingIcon: Icons.alternate_email_outlined, onTap: () {
                      print("email pressed");
                    }),
                  ]),
                );
              }),
            ),
          );
        });
  }

  Widget getItem(BuildContext context,
      {required TextEditingController controller,
      required IconData leadingIcon,
      required String headline,
      required Function onTap}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => onTap(),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(leadingIcon),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(headline, style: Theme.of(context).primaryTextTheme.caption),
              Text(controller.text),
              Flexible(
                child: Text(
                  "LAAAAAAAAAANGE BESCHREIBUBNGLorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
                  style: Theme.of(context).primaryTextTheme.labelSmall,
                ),
              ),
            ],
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
              // TODO forward to change profile page
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
}
