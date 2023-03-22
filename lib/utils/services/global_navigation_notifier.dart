import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:othia/utils/services/rest-api/amplify/amp.dart';

import '../services/rest-api/rest_api_service.dart';

class GlobalNavigationNotifier extends ChangeNotifier {
  int navigationBarIndex = 0;
  bool isDialogOpen = false;
  late bool isUserLoggedIn;
  String? userId;

  GlobalNavigationNotifier();

  Future<void> initializeUserLoggedIn() async {
    isUserLoggedIn = await RestService().isSignedIn();
  }

  Future<void> initializeUserId() async {
    if (isUserLoggedIn) {
      userId = await getUserId();
    }
  }

  Future<void> logout() async {
    try {
      RestService().logout();
    } catch (e) {
      print("error");
      Get.snackbar("", "",
          titleText: Text(e.toString()),
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white);
    }
    // RestService().logout();
    // TODO clear (extern) error handling
    //TODO (intern) user ID should never be null. if a user logs out he get a new id as a unauthenticated user #OT-34
    userId = null;
    isUserLoggedIn = false;
    notifyListeners();
    RestService();
    resetScreenState;
    // TODO clear (extern) update the other screens such that show their logged out behaviour, e.g. initialize them anew
  }
}

void resetScreenState(BuildContext context) {
  Navigator.pushNamedAndRemoveUntil(
    context,
    '/screen',
    (route) => false,
  );
}