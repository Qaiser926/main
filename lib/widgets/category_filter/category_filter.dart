import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/catgories.dart';
import 'exclusives/category_grid_item.dart';
import 'exclusives/expanded_widget.dart';
import 'exclusives/notifier.dart';

class CategoryFilter extends StatefulWidget {
  List<Widget> niceList = getList();

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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
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

List<Widget> getList() {
  List<Widget> allMightyList = [];
  for (int index = 0; index < Categories.categoryIds.length; index += 2) {
    allMightyList.add(Row(
      children: [
        Flexible(
          child: getCategoryGridItem(index: index),
        ),
        SizedBox(
          width: 15,
        ),
        Flexible(
          child: getCategoryGridItem(
            index: index + 1,
          ),
        ),
      ],
    ));
    allMightyList.add(ExpandedWidget(index: index));
    allMightyList.add(ExpandedWidget(index: index + 1));
    allMightyList.add(SizedBox(
      height: 15,
    ));
  }
  // }
  return allMightyList;
}
