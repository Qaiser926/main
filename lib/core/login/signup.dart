import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../utils/services/rest-api/rest_api_service.dart';
import 'exclusives.dart';
import 'notifier.dart';

class Signup extends StatelessWidget {
  PageController pageController;

  Signup(PageController this.pageController, {super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneNumberController = TextEditingController(
        text: Provider.of<LoginSignUpNotifier>(context, listen: true).number);
    TextEditingController passwordController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    return Expanded(
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: listItemColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
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
                      AppLocalizations.of(context)!.signup,
                      style: Theme.of(context).primaryTextTheme.displayMedium,
                    )),
                Row(children: [
                  Icon(Icons.phone),
                  Text(phoneNumberController.text),
                ]),
                getSome(AppLocalizations.of(context)!.eMail, Icons.mail,
                    emailController),
                getSome(AppLocalizations.of(context)!.birthdate,
                    Icons.date_range, emailController),
                getSome(AppLocalizations.of(context)!.password, Icons.password,
                    passwordController),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await RestService().signUp(
                          password: passwordController.text,
                          email: emailController.text,
                          username: phoneNumberController.text);
                      //sign up was successfull. forward user to confirmation
                      Provider.of<LoginSignUpNotifier>(context, listen: false)
                          .password = passwordController.text;
                      pageController.jumpToPage(3);
                    } on Exception catch (e) {
                      //TODO catch specific
                      //todo forward to code confirmation page
                    }

                    // dynamic bar = await RestService().isSignedIn();
                    // GlobalNavigationNotifier globalNot =
                    //     Provider.of<GlobalNavigationNotifier>(context,
                    //         listen: false);
                    // globalNot.initializeUserId();
                    // globalNot.initializeUserLoggedIn();
                    // globalNot.notifyListeners();
                    // if (globalNot.isUserLoggedIn) {
                    //   Get.to(MainPage());
                    // }
                    //Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 18,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      width: 200,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.signup,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
