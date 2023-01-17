import 'package:flutter/material.dart';

import '../../utils/services/rest-api/rest_api_service.dart';

class LoginSignup extends StatelessWidget {
  const LoginSignup({super.key});

  @override
  Widget build(BuildContext context) {
    RestService().signIn(username: "mattistest", password: "12345678");

    return Scaffold(
      body: Container(color: Colors.green),
    );
  }
}
