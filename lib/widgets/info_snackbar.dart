import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

GestureDetector eAInfoButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      launchInfoSnackBarButton(context);
    },
    child: Icon(Icons.info_outline),
  );
}

void launchInfoSnackBarButton(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    // TODO improve design

    content: Text(AppLocalizations.of(context)!.explanationEA,
        textAlign: TextAlign.center),
    duration: Duration(seconds: 3, milliseconds: 500),
  ));
}
