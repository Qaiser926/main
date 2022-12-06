import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:othia/widgets/openingtimes.dart';

import '../../../utils/ui/ui_utils.dart';

class OpeningTimesSection extends StatelessWidget {
  final Map openingTime;

  const OpeningTimesSection({super.key, required this.openingTime});

  @override
  Widget build(BuildContext context) {
    return  Column(
    children: [
    Row(
    children: [
        getHorSpace(20),
      Text(
      AppLocalizations.of(context)!.openingHours,
        style: Theme.of(context).textTheme.headline2,
        maxLines: 1,
      ),

    ],
    ),OpeningTimes(openingTime: openingTime)
    ],);
  }}