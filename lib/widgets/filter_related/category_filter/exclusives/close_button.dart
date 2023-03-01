import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:othia/widgets/filter_related/notifiers/abstract_query_notifier.dart';

Widget ClearButton(
    {required AbstractQueryNotifier abstractNotifier,
    required BuildContext context}) {
  return TextButton(
    child: Text(AppLocalizations.of(context)!.clear),
    onPressed: () => abstractNotifier.resetSubcategoryList(context: context),
  );
}
