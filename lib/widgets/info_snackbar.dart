import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

GestureDetector eAInfoButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      launchInfoSnackBarButton(context);
    },
    child: Icon(Icons.info_outline),
  );
}

void launchInfoSnackBarButton(BuildContext context) {
  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  // TODO clear (extern) improve design

  // content: Text(AppLocalizations.of(context)!.explanationEA,
  //     textAlign: TextAlign.center),
  // duration: const Duration(seconds: 3, milliseconds: 500),
  // ));
  Get.snackbar(
    "",
    "",
    titleText: Text(AppLocalizations.of(context)!.explanationEA),
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
  );
}
