import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:othia/core/detailed/exclusive_widgets/other.dart';
import 'package:othia/widgets/openingtimes.dart';

class OpeningTimesSection extends StatelessWidget {
  final Map openingTime;

  const OpeningTimesSection({super.key, required this.openingTime});

  @override
  Widget build(BuildContext context) {
    return getSection(
      context: context,
      caption: AppLocalizations.of(context)!.openingHours,
      contentWidget: OpeningTimes(openingTime: openingTime),
    );
  }
}

