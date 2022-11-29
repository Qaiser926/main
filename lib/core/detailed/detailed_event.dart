import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/services/rest-api/rest_api_service.dart';
import '../../widgets/splash_screen.dart';

import 'package:get/get.dart';

class FeaturedEventDetail extends StatelessWidget {
  const FeaturedEventDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: RestService().fetchEventDetails(Get.arguments),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print('builder called');
            if (snapshot.hasError) {
              throw Exception();
            } else {
              return Scaffold(
                body: Row(children: [Text(snapshot.data.toString())]),
              );
            }
          } else {
            return const SplashScreen();
          }
        });
  }
}
