import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sliver_tools/sliver_tools.dart';

class Section extends MultiSliver {
  Section({
    Key? key,
    required String title,
    Color headerColor = Colors.white,
    Color titleColor = Colors.black,
    required List<Widget> items,
  }) : super(
    key: key,
    pushPinnedChildren: true,
    children: [
  SliverPinnedHeader(
  child: ColoredBox(
  color: headerColor,
    child: ListTile(
      textColor: titleColor,
      title: Text(title),
    ),
  ),),
      SliverList(delegate: SliverChildBuilderDelegate((context, index) {
      return items[index];
      },)),

  ],
  );
}

