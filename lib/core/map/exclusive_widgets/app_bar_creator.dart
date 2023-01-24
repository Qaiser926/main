import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:othia/widgets/filter_related/filter_frameworks/dropdown_appbar.dart';
import 'package:othia/widgets/filter_related/filter_frameworks/map_filter.dart';
import 'package:othia/widgets/filter_related/notifiers/map_notifier.dart';
import 'package:provider/provider.dart';

SafeArea buildMapAppBar(
    {required BuildContext context, required dynamic body}) {
  return SafeArea(
      child: Consumer<MapNotifier>(builder: (context, model, child) {
    return Scaffold(
      primary: true,
      appBar: DropDownAppBar(
          filter: Consumer<MapNotifier>(builder: (context, model, child) {
            return MapFilter(
                    context: context,
                    dynamicProvider:
                        Provider.of<MapNotifier>(context, listen: false))
                .buildDropdownBar();
          }),
          context: context,
          appBarTitle: AppLocalizations.of(context)!.discover,
          automaticallyImplyLeading: true,
          onBackPressed: () {
            Get.back();
          }),
      body: body,
    );
  }));
}
