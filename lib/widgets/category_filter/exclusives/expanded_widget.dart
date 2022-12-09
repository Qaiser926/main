import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constants/catgories.dart';
import 'notifier.dart';

class ExpandedWidget extends StatelessWidget {
  final List<String> subcategoryIds;
  final int expandedHeight;
  static const int singleExpandedHeight = 50;
  final int index;

  ExpandedWidget({
    super.key,
    required this.index,
  }) : subcategoryIds = categoryIdToSubcategoryIds
                .containsKey(Categories.categoryIds[index])
            ? categoryIdToSubcategoryIds[Categories.categoryIds[index]]!
            : [],
        expandedHeight = subcategoryIds.length * singleExpandedHeight;

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpandedCategoryNotifier>(builder: (context, model, child) {
      bool expanded = model.getExpandedIndex == index;
      if (!subcategoryIds.isEmpty) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 200),
          // margin: const EdgeInsets.all(20.0),
          width: expanded ? 600 : 0,
          height: expanded ? 100 : 0,
          child: expanded
              ? Container(
                  child: Column(
                    children: List<Widget>.generate(
                        subcategoryIds.length,
                        (index) => Row(
                              children: [
                                Container(child:Text(subcategoryIds[index]))
                              ],
                            )),
                  ),
                )
              : SizedBox.shrink(),
        );
      } else {
        //TODO
        return Text("Es ist ein unerwartet Fehler aufgetreten");
      }
    });
  }
}
