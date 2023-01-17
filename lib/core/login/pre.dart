import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../utils/services/rest-api/rest_api_service.dart';
import '../../utils/ui/ui_utils.dart';
import 'exclusives.dart';
import 'login.dart';
import 'notifier.dart';

class Pre extends StatelessWidget {
  final PageController pageController;

  final Login login;

  const Pre(this.pageController, this.login, {super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController numberController = TextEditingController();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: listItemColor,
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
      ),
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
            getSome("Number", Icons.phone, numberController),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                LoginSignUpNotifier notifier =
                    Provider.of<LoginSignUpNotifier>(context, listen: false);
                notifier.number = numberController.text;

                //TODO (intern) this whole function is temporary, put function in notifier like logout?
                try {
                  //TODO check return value. if successfull forward
                  await RestService()
                      .signIn(password: "1", username: numberController.text);
                  // GlobalNavigationNotifier globalNot =
                  //     Provider.of<GlobalNavigationNotifier>(context,
                  //         listen: false);
                  // globalNot.initializeUserId();
                  // globalNot.initializeUserLoggedIn();
                  // globalNot.notifyListeners();
                  // Get.to(MainPage());
                } on UserNotFoundException catch (e) {
                  notifier.isSignup = true;

                  //forward to sign in
                  // Navigator.push(
                  //   context,
                  //   PageRouteBuilder(
                  //       pageBuilder: ((context, animation, secondaryAnimation) {
                  //         return MultiProvider(providers: [
                  //           ChangeNotifierProvider.value(
                  //             value: Provider.of<LoginSignUpNotifier>(context,
                  //                 listen: false),
                  //           )
                  //         ], child: Login());
                  //       }),
                  //       transitionDuration: Duration.zero,
                  //       reverseTransitionDuration: Duration.zero),
                  // );
                  Get.to(login, duration: Duration.zero);
                } on UserNotConfirmedException catch (e) {
                  //TODO forward to confirmation page
                  //TODO maybe show snackbar or sth
                  //forward user to confirmation page
                  pageController.jumpToPage(3);
                } on InvalidParameterException catch (e) {
                  //TODO somethings wrong. give feedback to the user
                } on NotAuthorizedException catch (e) {
                  //forward user to signin
                  pageController.jumpToPage(1);
                } catch (e) {
                  print(e);
                  //TODO catch specific exception for wrong password and forward user to login

                }
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getAssetImage("facebook.png", width: 80),

                const SizedBox(
                  width: 15,
                ),
                getAssetImage("apple.png", width: 80),

                // const SizedBox(
                //   width: 15,
                // ),
                // Image.asset(
                //   "images/Tiktok.png",
                //   width: 80,
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
