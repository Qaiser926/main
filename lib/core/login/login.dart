import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../utils/services/global_navigation_notifier.dart';
import '../../utils/services/rest-api/rest_api_service.dart';
import '../main_page.dart';
import 'exclusives.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Expanded(
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: listItemColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
          margin: const EdgeInsets.only(top: 30),
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
                      "Login",
                      style: Theme.of(context).primaryTextTheme.displayMedium,
                    )),
                getSome("Username", Icons.phone, usernameController),
                getSome("Password", Icons.password, passwordController),
                const SizedBox(
                  height: 20,
                ),

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
                      elevation: 18,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Ink(
                    decoration: BoxDecoration(
                        color: listItemColor,
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
                SizedBox(
                  height: 50,
                ),
                // FadeAnimation(
                //   2,
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Image.asset(
                //         "images/Facebook.png",
                //         width: 80,
                //       ),
                //       const SizedBox(
                //         width: 15,
                //       ),
                //       Image.asset(
                //         "images/Instagram.png",
                //         width: 80,
                //       ),
                //       const SizedBox(
                //         width: 15,
                //       ),
                //       Image.asset(
                //         "images/Tiktok.png",
                //         width: 80,
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          )),
    );
  }
}
