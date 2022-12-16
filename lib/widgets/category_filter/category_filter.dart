import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:provider/provider.dart';

import '../../constants/categories.dart';
import '../filter_related/search_notifier.dart';
import 'exclusives/category_grid_item.dart';
import 'exclusives/expanded_widget.dart';

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
            child:
                // TODO make container height dynamic
                Container(
              height: 675,
              child: CategoryFilter(
                context: context,
                isModalBottomSheetMode: true,
              ),
            ));
      });
}

class CategoryFilter extends StatefulWidget {
  late final List<Widget> niceList =
      getCategoryGrid(isModalBottomSheetMode: isModalBottomSheetMode);
  BuildContext context;
  bool isModalBottomSheetMode;

  static const double gridItemDistance = 15;
  static const EdgeInsets gridItemPadding =
      EdgeInsets.symmetric(horizontal: 10);

  CategoryFilter(
      {super.key, required this.context, required this.isModalBottomSheetMode});

  @override
  State<CategoryFilter> createState() => CategoryFilterState(context: context);
}

class CategoryFilterState extends State<CategoryFilter>
    with AutomaticKeepAliveClientMixin<CategoryFilter> {
  late List<String> selectedCategoryIds;

  CategoryFilterState({required BuildContext context}) {
    selectedCategoryIds = Provider.of<SearchNotifier>(context, listen: false)
        .getSelectedSubcategoryIds;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    List<Widget> sliverList = [
      SliverList(
        delegate: SliverChildListDelegate(widget.niceList,
            addAutomaticKeepAlives: true),
      )
    ];
    if (widget.isModalBottomSheetMode) {
      sliverList.insert(
        0,
        SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverToBoxAdapter(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [CloseButton()]),
            )),
      );
    }
    return Container(
      padding: CategoryFilter.gridItemPadding,
      child: CustomScrollView(
          // controller: widget._scrollController,
          cacheExtent: double.maxFinite,
          slivers: sliverList),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

List<Widget> getCategoryGrid({required bool isModalBottomSheetMode}) {
  List<Widget> categoryGrid = [];
  for (int index = 0; index < Categories.categoryIds.length; index += 2) {
    categoryGrid.add(Row(
      children: [
        Flexible(
          child: getCategoryGridItem(
            index: index,
            isModalBottomSheetMode: isModalBottomSheetMode,
          ),
        ),
        const SizedBox(
          width: CategoryFilter.gridItemDistance,
        ),
        Flexible(
          child: getCategoryGridItem(
            index: index + 1,
            isModalBottomSheetMode: isModalBottomSheetMode,
          ),
        ),
      ],
    ));
    categoryGrid.add(ExpandedWidget(
      categoryIndex: index,
    ));
    categoryGrid.add(ExpandedWidget(
      categoryIndex: index + 1,
    ));
    categoryGrid.add(const SizedBox(
      height: CategoryFilter.gridItemDistance,
    ));
  }
  return categoryGrid;
}

String getCategoryCaption(
    {required BuildContext context, required SearchNotifier searchNotifier}) {
  // special case if one page "Show More"
  if (searchNotifier.currentIndex == NavigatorConstants.ShowMorePageIndex) {
    return getShortCaption(
        caption: searchNotifier.showMoreCategoryTitle,
        cutOff: NavigatorConstants.CategoryNameCutOff);
  }
  List<String> subcategoryIds = searchNotifier.getSelectedSubcategoryIds;
  if (subcategoryIds.length == 0) {
    return AppLocalizations.of(context)!.category;
  } else if (subcategoryIds.length == 1) {
    String tempCategory = CategoryIdToI18nMapper.getCategorySubcategoryName(
        context, subcategoryIds[0]);
    return getShortCaption(
        caption: tempCategory, cutOff: NavigatorConstants.CategoryNameCutOff);
  } else {
    Map<String, List<String>> categorySubcategoryMap =
        categoryIdToSubcategoryIds;
    String caption = "";
    for (MapEntry<String, List<String>> item
        in categorySubcategoryMap.entries) {
      if (item.value.contains(subcategoryIds[0])) {
        String tempCategory = CategoryIdToI18nMapper.getCategorySubcategoryName(
            context, item.key);
        return getShortCaption(
            cutOff: NavigatorConstants.CategoryNameCutOff,
            caption: tempCategory);
      }
    }
    return AppLocalizations.of(context)!.category;
  }
}

String getShortCaption({required int cutOff, required String caption}) {
  if (caption.length > cutOff) {
    return "${caption.substring(0, cutOff - 3)}...";
  } else {
    return caption;
  }
}
