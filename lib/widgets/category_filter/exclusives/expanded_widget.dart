import 'package:flutter/material.dart';

import '../../../constants/catgories.dart';

class ExpandedWidget extends StatelessWidget {
  final String categoryId;
  final bool expanded;
  final List<String> subcategoryIds;

  ExpandedWidget({
    super.key,
    required this.categoryId,
    required this.expanded,
  }) : subcategoryIds = categoryIdToSubcategoryIds.containsKey(categoryId)
            ? categoryIdToSubcategoryIds[categoryId]!
            : [];

  @override
  Widget build(BuildContext context) {
    if (!subcategoryIds.isEmpty) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 200),
        // margin: const EdgeInsets.all(20.0),
        width: expanded ? 600 : 0,
        height: expanded ? 100 : 0,
        child: expanded
            ? ListView(
                children: List<Widget>.generate(
                  subcategoryIds.length,
                  (index) => Text(
                    subcategoryIds[index],
                  ),
                ),
              )
            : SizedBox.shrink(),
      );
    } else {
      return Text("Es ist ein unerwartet Fehler aufgetreten");
    }
  }
}
