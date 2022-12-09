import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../constants/catgories.dart';
import 'exclusives/category_grid_item.dart';
import 'exclusives/expanded_widget.dart';
import 'exclusives/notifier.dart';

class CategoryFilter extends StatelessWidget {
  List<Widget> niceList = getList();
  CategoryFilter({super.key,});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ExpandedCategoryNotifier(),
        )
      ],
      child: CustomScrollView(slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            niceList,
          ),
        )
      ]),
    );
  }
}

List<Widget> getList() {
  List<Widget> allMightyList = [];
  for (int index = 0; index < Categories.categoryIds.length; index += 2) {
    // if (index != 0 && index % 2 == 1) {

    // if (expandedCategoryNotifier.getExpandedIndex == index ||
    //     expandedCategoryNotifier.getExpandedIndex == index - 1) {
    //   allMightyList.add(ExpandedWidget(
    //     expanded: true,
    //     categoryId: Categories.categoryIds[index],
    //   ));
    // } else {
    //   allMightyList.add(ExpandedWidget(
    //     expanded: false,
    //     categoryId: Categories.categoryIds[index],
    //   ));
    // }
    // } else {
    allMightyList.add(Row(
      children: [
        Flexible(
          child: getCategoryGridItem(index: index),
        ),
        Flexible(
          child: getCategoryGridItem(
            index: index + 1,
          ),
        ),
      ],
    ));
    allMightyList.add(ExpandedWidget(
      index:index
    ));
    allMightyList.add(ExpandedWidget(
        index:index+1
    ));

    // allMightyList.add(getExpandedWidget(index + 1));
  }
  // }
  return allMightyList;
}

// Widget getExpandedWidget(int index) {
//   final String categoryId = Categories.categoryIds[index];
//     return ExpandedWidget(
//       categoryId: categoryId,
//     );
// }
