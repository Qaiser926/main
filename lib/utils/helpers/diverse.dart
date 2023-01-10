import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

void dismissKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

// TODO (extern) when sharing, also include the Othia logo in the share message
void openShare(String shareString) {
  Share.share(shareString);
}

void closeSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
}
