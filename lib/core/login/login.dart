import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:othia/core/login/login_data.dart';

import '../../constants/colors.dart';
import 'exclusives.dart';

class Login extends StatelessWidget {
  LoginSignupData data;

  Login(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController =
        TextEditingController(text: data.number);
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: getLoginAppBar(),
      body: BaseLoginSignupContainer(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            // Container(
            //     // color: Colors.red,
            //     alignment: Alignment.topLeft,
            //     margin: const EdgeInsets.only(left: 22, bottom: 20),
            //     child: Text(
            //       "Login",
            //       style: Theme.of(context).primaryTextTheme.displayMedium,
            //     )),

            getCustomTextFormFieldWithPadding(
              controller: usernameController,
              iconData: Icons.phone,
              hintText: "Username",
            ),
            getCustomTextFormFieldWithPadding(
              controller: passwordController,
              iconData: Icons.password,
              hintText: "Password",
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                data.password = passwordController.text;
                data.number = usernameController.text;
                signIn(data, context);
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
          ],
        ),
      )),
    );
  }
}
