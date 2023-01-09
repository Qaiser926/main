import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:othia/core/detailed/exclusive_widgets/other.dart';
import 'package:othia/utils/ui/ui_utils.dart';

class DescriptionWidget extends StatelessWidget {
  String description;

  DescriptionWidget({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return getSection(
        context: context,
        caption: AppLocalizations.of(context)!.description,
        contentWidget: getMultilineCustomFontRestricted(
            textTheme: Theme.of(context).textTheme.headlineSmall,
            text: description,
            maxLines: 3));
  }
}
