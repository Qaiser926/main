import 'package:flutter/material.dart';
import 'package:othia/utils/ui/ui_utils.dart';

class DropDownAppBar extends AppBar {
  final String appBarTitle;
  final BuildContext context;
  final Widget filter;

  DropDownAppBar(
      {required this.appBarTitle,
      required this.context,
      required this.filter,
      super.key,
      bool automaticallyImplyLeading = true})
      : super(
            title: Text(appBarTitle),
            elevation: 0,
            automaticallyImplyLeading: automaticallyImplyLeading,
            bottom: PreferredSize(
              preferredSize: const Size(double.infinity, 50),
              child: Column(
                children: [filter, getVerSpace(15)],
              ),
            ));
}

