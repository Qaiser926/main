import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:othia/core/login/login_data.dart';

import '../../constants/colors.dart';
import 'exclusives.dart';

class Signup extends StatelessWidget {
  LoginSignupData data;

  Signup(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneNumberController =
        TextEditingController(text: data.number);
    TextEditingController passwordController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: getLoginAppBar(),
      body: BaseLoginSignupContainer(
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
            getCustomTextFormFieldWithPadding(
              hintText: "Phone Number",
              iconData: Icons.phone,
              controller: phoneNumberController,
            ),
            getCustomTextFormFieldWithPadding(
              hintText: AppLocalizations.of(context)!.eMail,
              iconData: Icons.mail,
              controller: emailController,
            ),
            getCustomTextFormFieldWithPadding(
              hintText: AppLocalizations.of(context)!.birthdate,
              iconData: Icons.date_range,
              controller: emailController,
            ),
            getCustomTextFormFieldWithPadding(
              hintText: AppLocalizations.of(context)!.password,
              iconData: Icons.password,
              controller: passwordController,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                data.password = passwordController.text;
                data.email = emailController.text;
                data.username = phoneNumberController.text;
                signUp(data);
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
                    color: bgColor, borderRadius: BorderRadius.circular(20)),
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
