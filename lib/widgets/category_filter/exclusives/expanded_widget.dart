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
        width: expanded ? 0 : 600,
        height: expanded ? 0 : 100,
        child: expanded
            ? SizedBox.shrink()
            : ListView(
      children: List<Widget>.generate(
        subcategoryIds.length,
            (index) => Text(
          subcategoryIds[index],
        ),
      ),
    ),
      );
    } else {
      return Text("Es ist ein unerwartet Fehler aufgetreten");
    }
  }
}
