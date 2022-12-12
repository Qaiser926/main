import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/categories.dart';
import 'exclusives/category_grid_item.dart';
import 'exclusives/expanded_widget.dart';
import 'exclusives/notifier.dart';

class CategoryFilter extends StatefulWidget {
  List<Widget> niceList = getCategoryGrid();
  static const double gridItemDistance = 15;
  static const EdgeInsets gridItemPadding =
      EdgeInsets.symmetric(horizontal: 10);

  CategoryFilter({
    super.key,
  });

  @override
  State<CategoryFilter> createState() => CategoryFilterState();

  static List<Widget> getCategoryGrid() {
    List<Widget> categoryGrid = [];
    for (int index = 0; index < Categories.categoryIds.length; index += 2) {
      categoryGrid.add(Row(
        children: [
          Flexible(
            child: getCategoryGridItem(index: index),
          ),
          const SizedBox(
            width: gridItemDistance,
          ),
          Flexible(
            child: getCategoryGridItem(
              index: index + 1,
            ),
          ),
        ],
      ));
      categoryGrid.add(ExpandedWidget(index: index));
      categoryGrid.add(ExpandedWidget(index: index + 1));
      categoryGrid.add(const SizedBox(
        height: gridItemDistance,
      ));
    }
    return categoryGrid;
  }
}

class CategoryFilterState extends State<CategoryFilter>
    with AutomaticKeepAliveClientMixin<CategoryFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: CategoryFilter.gridItemPadding,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: ExpandedCategoryNotifier(),
          )
        ],
        child: CustomScrollView(cacheExtent: double.maxFinite, slivers: [
          SliverList(
            delegate: SliverChildListDelegate(widget.niceList,
                addAutomaticKeepAlives: true),
          )
        ]),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

