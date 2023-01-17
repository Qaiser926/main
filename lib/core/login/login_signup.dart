import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:othia/core/login/pre.dart';
import 'package:othia/core/login/signup.dart';
import 'package:provider/provider.dart';

import '../../constants/app_constants.dart';
import '../../utils/ui/ui_utils.dart';
import 'confirm.dart';
import 'login.dart';
import 'notifier.dart';

class LoginSignup extends StatelessWidget {
  late final PageController _pageController;

  LoginSignup({super.key}) {
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    // RestService().signIn(username: "mattistest", password: "12345678");

    LoginSignUpNotifier loginSignUpNotifier = LoginSignUpNotifier();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.0),
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(top: 50),
            child:
                getAssetImage(OthiaConstants.logoName, width: 150, height: 150),
          ),
        ]),
      ),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: loginSignUpNotifier,
          )
        ],
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Pre(_pageController),
            Login(),
            Signup(_pageController),
            ConfirmationScreen(),
          ],
        ),
      ),
    );
  }
}
