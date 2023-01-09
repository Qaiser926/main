import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

void dismissKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

// TODO include share image to share, change share Image to Othia logo
String shareImage = '8063ce0b-3645-4fcb-8445-f9ea23243e16.jpg';

void openShare(String shareString) {
  Share.share(shareString);
}

void closeSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
}
