import 'package:flutter/material.dart';
import 'package:othia/core/login/signup.dart';

import '../../constants/app_constants.dart';
import '../../utils/ui/ui_utils.dart';
import 'login.dart';

class LoginSignup extends StatelessWidget {
  const LoginSignup({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: PageView(
        children: [
          Login(),
          Signup(),
        ],
      ),
    );
  }
}
