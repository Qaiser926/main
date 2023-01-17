import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:othia/utils/services/rest-api/rest_api_service.dart';
import 'package:provider/provider.dart';

import '../../utils/services/global_navigation_notifier.dart';
import '../main_page.dart';
import 'exclusives.dart';
import 'notifier.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController confirmController = TextEditingController();

    return Container(
      child: Column(
        children: [
          getSome("Confirm Code", Icons.mail, confirmController),
          ElevatedButton(
              onPressed: () {
                try {
                  RestService().resend(
                      username: Provider.of<LoginSignUpNotifier>(context,
                              listen: false)
                          .number!);
                } on Exception catch (e) {
                  //WRONG Code
                }
              },
              child: Text("Resend")),
          ElevatedButton(
              onPressed: () async {
                try {
                  await RestService().confirm(
                      confirmationCode: confirmController.text,
                      username: Provider.of<LoginSignUpNotifier>(context,
                              listen: false)
                          .number!);
                } on CodeMismatchException catch (e) {
                  //TODO show feedback here
                  //WRONG Code
                } on NotAuthorizedException catch (e) {
                  //TODO show feedback here
                  //WRONG Code
                }

                try {
                  RestService().signIn(
                      username: Provider.of<LoginSignUpNotifier>(context,
                              listen: false)
                          .number!,
                      password: Provider.of<LoginSignUpNotifier>(context,
                              listen: false)
                          .password!);
                  GlobalNavigationNotifier globalNot =
                      Provider.of<GlobalNavigationNotifier>(context,
                          listen: false);
                  //TODO perfomance from double await
                  await globalNot.initializeUserLoggedIn();
                  await globalNot.initializeUserId();
                  globalNot.notifyListeners();
                  if (globalNot.isUserLoggedIn) {
                    //TODO maybe forward to where the user was. probably very conplicated cause of state management.
                    Get.to(MainPage());
                  }
                } on Exception catch (e) {
                  //TODO show feedback here
                  //TODO log unexpected behaviour
                }
              },
              child: Text("Confirm"))
        ],
      ),
    );
  }
}
