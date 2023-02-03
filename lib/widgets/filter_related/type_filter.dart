import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/widgets/info_snackbar.dart';
import 'package:provider/provider.dart';

import 'get_reset_apply_filter.dart';
import 'notifiers/abstract_query_notifier.dart';

enum EAType { events, activities, eventsActivities }

Future<dynamic> typeFilterDialog(
    {required BuildContext context,
    required AbstractQueryNotifier dynamicProvider}) {
  return showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      isScrollControlled: true,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      context: context,
      builder: (_) {
        // Scaffold is required to allow the snackbar to be showed
        return ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0.h),
                topLeft: Radius.circular(20.0.h)),
            child: Container(
              height: 183.h,
              child: Scaffold(
                  body: MultiProvider(
                      providers: [
                    ChangeNotifierProvider.value(
                      value: dynamicProvider,
                    )
                  ],
                      child: TypeFilter(
                        dynamicProvider: dynamicProvider,
                      ))),
            ));
      });
}

class TypeFilter<T> extends StatefulWidget {
  AbstractQueryNotifier dynamicProvider;

  TypeFilter({super.key, required this.dynamicProvider});

  @override
  State<TypeFilter> createState() =>
      _TypeFilterState(dynamicProvider: this.dynamicProvider);
}

class _TypeFilterState<T> extends State<TypeFilter> {
  late EAType? eAType;
  AbstractQueryNotifier dynamicProvider;

  _TypeFilterState({required this.dynamicProvider}) {
    eAType = dynamicProvider.getEAType;
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
            child: Text(caption),
          ),
        ),
      ),
    );
  }

  bool determineEnabled(
      {required EAType eAType, required AbstractQueryNotifier model}) {
    if (eAType == model.eAType) {
      return true;
    } else {
      return false;
    }
  }

  Function getTypeFunction({required EAType eAType}) {
    if (eAType == dynamicProvider.getEAType) {
      return () => {
            setState(() {
              this.eAType = null;
              dynamicProvider.setEAType(eAType: null);
            })
          };
    } else {
      return () => {
            setState(() {
              this.eAType = eAType;
              dynamicProvider.setEAType(eAType: eAType);
            })
          };
    }
  }

  List<Widget> getTypeButtons(
      {required BuildContext context, required AbstractQueryNotifier model}) {
    List<Widget> sortButtons = [
      getTypeButton(
          context: context,
          caption: AppLocalizations.of(context)!.eventsActivities,
          onTapFunction: getTypeFunction(eAType: EAType.eventsActivities),
          coloredBorder:
              determineEnabled(eAType: EAType.eventsActivities, model: model)),
      getTypeButton(
          context: context,
          caption: AppLocalizations.of(context)!.events,
          onTapFunction: getTypeFunction(eAType: EAType.events),
          coloredBorder: determineEnabled(eAType: EAType.events, model: model)),
      getTypeButton(
          context: context,
          caption: AppLocalizations.of(context)!.activities,
          onTapFunction: getTypeFunction(eAType: EAType.activities),
          coloredBorder:
              determineEnabled(eAType: EAType.activities, model: model)),
    ];
    return sortButtons;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AbstractQueryNotifier>(builder: (context, model, child) {
      return Column(
        children: [
          Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.h),
                      child: eAInfoButton(context),
                    ),
                    CloseButton()
                  ])),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: getTypeButtons(context: context, model: model),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: getShowResultsButton(
                context: context,
                functionAccept: dynamicProvider.changeEAType,
                functionArgumentsAccept: {#eAType: eAType},
                functionReset: dynamicProvider.resetEAType,
                functionArgumentsReset: {},
                closeDialog: true),
          )
        ],
      );
    });
  }
}

String getTypeCaption({
  required BuildContext context,
  required AbstractQueryNotifier dynamicProvider,
}) {
  if (dynamicProvider.typeFilterActivated) {
    EAType? eAType = dynamicProvider.getEAType;
    if (eAType != null) {
      return getCaptionForType(eAType: eAType, context: context);
    } else {
      return AppLocalizations.of(context)!.type;
    }
  } else {
    return AppLocalizations.of(context)!.type;
  }
}

String getCaptionForType(
    {required EAType eAType, required BuildContext context}) {
  Map typeMap = {
    EAType.eventsActivities: AppLocalizations.of(context)!.eventsActivities,
    EAType.events: AppLocalizations.of(context)!.events,
    EAType.activities: AppLocalizations.of(context)!.activities,
  };
  return typeMap[eAType];
}
