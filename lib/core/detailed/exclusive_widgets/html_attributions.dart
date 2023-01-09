import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:othia/core/detailed/exclusive_widgets/other.dart';

class HTMLAttributions extends StatelessWidget {
  final String htmlAttributions;

  const HTMLAttributions({super.key, required this.htmlAttributions});

  @override
  Widget build(BuildContext context) {
    return getSection(
        context: context,
        caption: AppLocalizations.of(context)!.attributions,
        contentWidget: Html(
          data: htmlAttributions,
        ));
  }
}
