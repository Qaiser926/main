import 'package:flutter/material.dart';
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
    RestService().logout();
    // TODO (extern) error handling
    userId = null;
    isUserLoggedIn = false;
    notifyListeners();
    // TODO (extern) update the other screens such that show their logged out behaviour, e.g. initialize them anew
  }
}
