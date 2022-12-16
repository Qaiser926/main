import 'package:flutter/material.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:othia/widgets/filter_related/dropdown_bar.dart';
import 'package:provider/provider.dart';

import 'search_notifier.dart';

class DropDownAppBar extends AppBar {
  final String appBarTitle;
  final BuildContext context;

  DropDownAppBar(
      {required this.appBarTitle,
      required this.context,
      super.key,
      bool automaticallyImplyLeading = true})
      : super(
            title: Text(appBarTitle),
            elevation: 0,
            automaticallyImplyLeading: automaticallyImplyLeading,
            bottom: PreferredSize(
              preferredSize: const Size(double.infinity, 50),
              child: Column(
                children: [
                  Consumer<SearchNotifier>(builder: (context, model, child) {
                    return buildDropdownBar(context: context);
                  }),
                  getVerSpace(15)
                ],
              ),
            ));
}

