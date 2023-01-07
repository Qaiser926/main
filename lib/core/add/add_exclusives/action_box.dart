import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/core/add/add_exclusives/help_functions.dart';
import 'package:othia/utils/ui/ui_utils.dart';

class ActionBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      getHeadline(
          showDivider: false,
          context: context,
          caption: Text(AppLocalizations.of(context)!.addActions,
              style: Theme.of(context).textTheme.headlineLarge)),
      getVerSpace(10.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButton(
              context: context,
              caption: AppLocalizations.of(context)!.delete,
              onTap: () {},
              icon: Icons.delete),
          buildButton(
              context: context,
              caption: AppLocalizations.of(context)!.share,
              onTap: () {},
              icon: Icons.share),
        ],
      ),
      getVerSpace(10.h),
    ]);
  }

  Widget buildButton(
      {required BuildContext context,
      required String caption,
      required Function onTap,
      required IconData icon}) {
    return GestureDetector(
      onTap: onTap(),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            border: Border.all(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.all(Radius.circular(20.h.h))),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.h),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 15.h,
                  ),
                  getHorSpace(10.h),
                  Text(
                    caption,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
