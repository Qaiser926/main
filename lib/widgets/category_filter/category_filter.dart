import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../constants/catgories.dart';
import 'exclusives/category_grid_item.dart';
import 'exclusives/expanded_widget.dart';
import 'exclusives/notifier.dart';

class CategoryFilter extends StatelessWidget {
  const CategoryFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ExpandedCategoryNotifier(),
        )
      ],
      child:
          Consumer<ExpandedCategoryNotifier>(builder: (context, model, child) {
        return CustomScrollView(slivers: [
          SliverList(
            delegate: SliverChildListDelegate(getList(model)),
          )
        ]);
      }),
    );
  }
}

List<Widget> getList(ExpandedCategoryNotifier expandedCategoryNotifier) {
  List<Widget> allMightyList = [];
  for (int index = 0; index < Categories.categoryIds.length; index++) {
    if (index != 0 && index % 2 == 1) {
      if (expandedCategoryNotifier.getExpandedIndex == index ||
          expandedCategoryNotifier.getExpandedIndex == index - 1) {
        allMightyList.add(ExpandedWidget(
          expanded: true,
          categoryId: Categories.categoryIds[index],
        ));
      } else {
        allMightyList.add(ExpandedWidget(
          expanded: false,
          categoryId: Categories.categoryIds[index],
        ));
      }
    } else {
      allMightyList.add(Row(
        children: [
          Flexible(
              child: getCategoryGridItem(
                  index: index + 1,
                  currentExpandedIndex:
                      expandedCategoryNotifier.getExpandedIndex)),
          Flexible(
              child: getCategoryGridItem(
                  index: index,
                  currentExpandedIndex:
                      expandedCategoryNotifier.getExpandedIndex))
        ],
      ));
    }
  }
  return allMightyList;
}
