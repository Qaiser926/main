import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            [Divider(),
              getVerSpace(10),
              Text(AppLocalizations.of(context)!.description, style: Theme.of(context).textTheme.headline2,),
              getVerSpace(10),
              getMultilineCustomFontRestricted(textTheme: Theme.of(context)
                  .textTheme.headline4, text: description, maxLines: 3)]),)
    ,
    );

  }
}
