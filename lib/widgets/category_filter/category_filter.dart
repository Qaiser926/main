import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../constants/categories.dart';
import '../filter_related/search_notifier.dart';
import 'exclusives/category_grid_item.dart';
import 'exclusives/expanded_widget.dart';
import 'exclusives/notifier.dart';

Future<dynamic> CategoryFilterDialog({required BuildContext context}) {
  var test = Provider.of<SearchNotifier>(context, listen: false);
  return showModalBottomSheet(
      isScrollControlled: true,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      context: context,
      builder: (_) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: test,
            )
          ],
          child: Wrap(children: [
            CategoryFilter(
              context: context,
            )
          ]),
        );
      });
}

class CategoryFilter extends StatefulWidget {
  late final List<Widget> niceList = getCategoryGrid();
  BuildContext context;

  static const double gridItemDistance = 15;
  static const EdgeInsets gridItemPadding =
      EdgeInsets.symmetric(horizontal: 10);

  CategoryFilter({super.key, required this.context});

  @override
  State<CategoryFilter> createState() => CategoryFilterState(context: context);
}

class CategoryFilterState extends State<CategoryFilter>
    with AutomaticKeepAliveClientMixin<CategoryFilter> {
  late List<String> selectedCategoryIds;

  CategoryFilterState({required BuildContext context}) {
    selectedCategoryIds = Provider.of<SearchNotifier>(context, listen: false)
        .getSelectedCategoryIds;
  }

  @override
  Widget build(BuildContext context) {
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
          // controller: widget._scrollController,
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

List<Widget> getCategoryGrid() {
  List<Widget> categoryGrid = [];
  for (int index = 0; index < Categories.categoryIds.length; index += 2) {
    categoryGrid.add(Row(
      children: [
        Flexible(
          child: getCategoryGridItem(
            index: index,
          ),
        ),
        const SizedBox(
          width: CategoryFilter.gridItemDistance,
        ),
        Flexible(
          child: getCategoryGridItem(
            index: index + 1,
          ),
        ),
      ],
    ));
    categoryGrid.add(ExpandedWidget(
      index: index,
    ));
    categoryGrid.add(ExpandedWidget(
      index: index + 1,
    ));
    categoryGrid.add(const SizedBox(
      height: CategoryFilter.gridItemDistance,
    ));
  }
  return categoryGrid;
}

String getCategoryCaption({required BuildContext context}) {
  List<String> sortCriteria =
      Provider.of<SearchNotifier>(context, listen: false)
          .getSelectedCategoryIds;
  if (sortCriteria.length == 0) {
    return AppLocalizations.of(context)!.category;
  } else if (sortCriteria.length == 1) {
    // TODO translate to actual name instead of id + limit to characters-
    return CategoryIdToI18nMapper.fckMethod(context, sortCriteria[0]);
  } else {
    // TODO either state that several subcategories or find main category
    return AppLocalizations.of(context)!.category;
  }
}