import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:othia/core/main_page.dart';
import 'package:othia/utils/services/global_navigation_notifier.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../utils/services/rest-api/rest_api_service.dart';
import 'anim.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 100),
                child: FadeAnimation(
                  2,
                  Text(
                    "Othia",
                    style: Theme.of(context).primaryTextTheme.displayLarge,
                  ),
                )),
            Expanded(
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: listItemColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  margin: const EdgeInsets.only(top: 60),
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
                            child: FadeAnimation(
                              2,
                              Text(
                                "Login",
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .displayMedium,
                              ),
                            )),
                        getSome("Username", Icons.email, usernameController),
                        getSome("Password", Icons.password, passwordController),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          2,
                          ElevatedButton(
                            onPressed: () async {
                              //TODO (intern) this whole function is temporary, put function in notifier like logout?
                              dynamic foo = await RestService().isSignedIn();
                              await RestService().signIn(
                                  password: passwordController.text,
                                  username: usernameController.text);
                              dynamic bar = await RestService().isSignedIn();
                              GlobalNavigationNotifier globalNot =
                                  Provider.of<GlobalNavigationNotifier>(context,
                                      listen: false);
                              globalNot.initializeUserId();
                              globalNot.initializeUserLoggedIn();
                              globalNot.notifyListeners();
                              if (globalNot.isUserLoggedIn) {
                                Get.to(MainPage());
                              }
                              //Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                                shadowColor: primaryColor,
                                elevation: 18,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            child: Ink(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [bgColor, listItemColor]),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Container(
                                width: 200,
                                height: 50,
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
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        FadeAnimation(
                          2,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "images/Facebook.png",
                                width: 80,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Image.asset(
                                "images/Instagram.png",
                                width: 80,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Image.asset(
                                "images/Tiktok.png",
                                width: 80,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget getSome(String hintText, IconData iconData, TextEditingController controller) {
    return FadeAnimation(
      2,
      Container(
          width: double.infinity,
          height: 70,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: primaryColor),
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(iconData),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: controller,
                    maxLines: 1,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: hintText,
                      label: Text(hintText),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
