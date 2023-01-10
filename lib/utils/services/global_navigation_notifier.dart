import 'package:flutter/material.dart';
import 'package:othia/utils/services/rest-api/amplify/amp.dart';

import '../services/rest-api/rest_api_service.dart';

class GlobalNavigationNotifier extends ChangeNotifier {
  int navigationBarIndex = 0;
  bool isDialogOpen = false;
  late bool isUserLoggedIn;
  late String? userId;

  GlobalNavigationNotifier() {
    initializeUserLoggedIn();
    initializeUserId();
  }

  Future<void> initializeUserLoggedIn() async {
    isUserLoggedIn = await RestService().isSignedIn();
  }

  Future<void> initializeUserId() async {
    userId = await getUserId();
  }

  Future<void> logout() async {
    RestService().logout();
    // TODO (extern) error handling
    userId = null;
    isUserLoggedIn = false;
    notifyListeners();
  }
}
