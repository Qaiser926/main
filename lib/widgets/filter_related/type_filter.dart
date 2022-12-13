import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:provider/provider.dart';

import 'get_reset_apply_filter.dart';
import 'search_notifier.dart';

enum EAType { events, activities, eventsActivites }

Future<dynamic> typeFilterDialog({required BuildContext context}) {
  var test = Provider.of<SearchNotifier>(context, listen: false);
  return showModalBottomSheet(
      isScrollControlled: true,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      context: context,
      builder: (_) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: test,
            )
          ],
          child: Wrap(
            children: [TypeFilter(context: context)],
          ),
        );
      });
}

class TypeFilter extends StatefulWidget {
  BuildContext context;

  TypeFilter({super.key, required BuildContext this.context});

  @override
  State<TypeFilter> createState() => _TypeFilterState(context: this.context);
}

class _TypeFilterState extends State<TypeFilter> {
  late EAType? eAType;

  _TypeFilterState({required BuildContext context}) {
    eAType = Provider.of<SearchNotifier>(context, listen: false).getEAType;
  }

  @override
  void initState() {
    super.initState();
  }

  Widget getTypeButton(
      {required BuildContext context,
      required String caption,
      required Function onTapFunction,
      required bool coloredBorder}) {
    Color? borderColor = null;
    if (coloredBorder) {
      borderColor = Theme.of(context).colorScheme.primary;
    } else {
      borderColor = Theme.of(context).highlightColor;
    }
    return Padding(
      padding: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () => onTapFunction(),
        child: Container(
          // margin: EdgeInsets.only(right: 12.h, left: 20.h ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.h),
            border: Border.all(color: borderColor),
          ),

          child: Padding(
            padding: EdgeInsets.all(7.h),
            child: getCustomFont(
              text: caption,
              fontSize: 14.sp,
              maxLine: 1,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  bool determineEnabled({required EAType eAType}) {
    if (eAType ==
        Provider.of<SearchNotifier>(context, listen: false).getEAType) {
      return true;
    } else {
      return false;
    }
  }

  Function getTypeFunction({required EAType eAType}) {
    if (eAType ==
        Provider.of<SearchNotifier>(context, listen: false).getEAType) {
      return () => {
            setState(() {
              this.eAType = null;
              Provider.of<SearchNotifier>(context, listen: false)
                  .changeEAType(eAType: null);
            })
          };
    } else {
      return () => {
            setState(() {
              this.eAType = eAType;
              Provider.of<SearchNotifier>(context, listen: false)
                  .changeEAType(eAType: eAType);
            })
          };
    }
  }

  List<Widget> getTypeButtons({required BuildContext context}) {
    List<Widget> sortButtons = [
      getTypeButton(
          context: context,
          caption: AppLocalizations.of(context)!.eventsActivities,
          onTapFunction: getTypeFunction(eAType: EAType.eventsActivites),
          coloredBorder: determineEnabled(eAType: EAType.eventsActivites)),
      getTypeButton(
          context: context,
          caption: AppLocalizations.of(context)!.events,
          onTapFunction: getTypeFunction(eAType: EAType.events),
          coloredBorder: determineEnabled(eAType: EAType.events)),
      getTypeButton(
          context: context,
          caption: AppLocalizations.of(context)!.activities,
          onTapFunction: getTypeFunction(eAType: EAType.activities),
          coloredBorder: determineEnabled(eAType: EAType.activities)),
    ];
    return sortButtons;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [CloseButton()])),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: getTypeButtons(context: context),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: getShowResultsButton(
              context: context,
              function: Provider.of<SearchNotifier>(context, listen: false)
                  .changeEAType,
              functionArguments: {#eAType: eAType}),
        )
      ],
    );
  }
}

String getTypeCaption({required BuildContext context}) {
  EAType? eAType =
      Provider.of<SearchNotifier>(context, listen: false).getEAType;
  if (eAType != null) {
    return getCaptionForType(eAType: eAType, context: context);
  } else {
    return AppLocalizations.of(context)!.type;
  }
}

String getCaptionForType(
    {required EAType eAType, required BuildContext context}) {
  Map typeMap = {
    EAType.eventsActivites: AppLocalizations.of(context)!.eventsActivities,
    EAType.events: AppLocalizations.of(context)!.events,
    EAType.activities: AppLocalizations.of(context)!.activities,
  };
  return typeMap[eAType];
}
