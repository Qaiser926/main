import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/utils/ui/ui_utils.dart';

class DescriptionWidget extends StatelessWidget {
  String description;

  DescriptionWidget({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
        EdgeInsets.symmetric(horizontal: 20.h),
        child:
        Flexible(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
          Divider(thickness: 3.h),
          getVerSpace(25),
          Text(
            AppLocalizations.of(context)!.description,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          getVerSpace(25),
          getMultilineCustomFontRestricted(
              textTheme: Theme.of(context).textTheme.headlineSmall,
              text: description,
              maxLines: 3),
          getVerSpace(25.h),
        ]),)
    ,
    );

  }
}
