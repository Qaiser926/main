import 'package:flutter/material.dart';

class LoginSignUpNotifier extends ChangeNotifier {
  bool isLogin = false;
  bool isSignup = false;
  String? password;
  String? number;
  String? age;
}
