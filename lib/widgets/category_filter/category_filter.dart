import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/categories.dart';
import 'exclusives/category_grid_item.dart';
import 'exclusives/expanded_widget.dart';
import 'exclusives/notifier.dart';

class CategoryFilter extends StatefulWidget {
  final ScrollController _scrollController = ScrollController();
  late final List<Widget> niceList;

  static const double gridItemDistance = 15;
  static const EdgeInsets gridItemPadding =
      EdgeInsets.symmetric(horizontal: 10);

  CategoryFilter({
    super.key,
  });

  @override
  State<CategoryFilter> createState() => CategoryFilterState();
}

class CategoryFilterState extends State<CategoryFilter>
    with AutomaticKeepAliveClientMixin<CategoryFilter> {
  @override
  Widget build(BuildContext context) {
    widget.niceList =
        getCategoryGrid(scrollController: widget._scrollController);

    super.build(context);
    return Container(
      padding: CategoryFilter.gridItemPadding,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: ExpandedCategoryNotifier(),
          )
        ],
        child: CustomScrollView(
            controller: widget._scrollController,
            scrollDirection: Axis.vertical,
            cacheExtent: double.maxFinite,
            slivers: [
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

List<Widget> getCategoryGrid({required ScrollController scrollController}) {
  List<Widget> categoryGrid = [];
  for (int index = 0; index < Categories.categoryIds.length; index += 2) {
    categoryGrid.add(Row(
      children: [
        Flexible(
          child: getCategoryGridItem(
            index: index,
            scrollController: scrollController,
          ),
        ),
        const SizedBox(
          width: CategoryFilter.gridItemDistance,
        ),
        Flexible(
          child: getCategoryGridItem(
            index: index + 1,
            scrollController: scrollController,
          ),
        ),
      ],
    ));
    categoryGrid.add(ExpandedWidget(
      index: index,
      scrollController: scrollController,
    ));
    categoryGrid.add(ExpandedWidget(
      index: index + 1,
      scrollController: scrollController,
    ));
    categoryGrid.add(const SizedBox(
      height: CategoryFilter.gridItemDistance,
    ));
  }
  return categoryGrid;
}
