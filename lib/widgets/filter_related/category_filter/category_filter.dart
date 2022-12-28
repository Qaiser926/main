import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/constants/categories.dart';
import 'package:othia/widgets/filter_related/notifiers/abstract_search_notifier.dart';
import 'package:provider/provider.dart';

import 'exclusives/category_grid_item.dart';
import 'exclusives/expanded_widget.dart';

Future<dynamic> getCategoryFilterDialog(
    {required BuildContext context,
    required AbstractSearchNotifier dynamicProvider}) {
  return showModalBottomSheet(
      isScrollControlled: true,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      context: context,
      builder: (_) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: dynamicProvider,
            )
          ],
          child:
              // TODO make container height dynamic
              Container(
                height: 675,
            child: CategoryFilter(
                isModalBottomSheetMode: true, dynamicProvider: dynamicProvider),
          ),
        );
      });
}

class CategoryFilter extends StatefulWidget {
  late final List<Widget> niceList = getCategoryGrid(
      isModalBottomSheetMode: isModalBottomSheetMode,
      dynamicProvider: dynamicProvider);

  bool isModalBottomSheetMode;
  AbstractSearchNotifier dynamicProvider;

  static const double gridItemDistance = 15;
  static const EdgeInsets gridItemPadding =
      EdgeInsets.symmetric(horizontal: 10);

  CategoryFilter(
      {super.key,
      required this.isModalBottomSheetMode,
      required this.dynamicProvider});

  @override
  State<CategoryFilter> createState() =>
      CategoryFilterState(dynamicProvider: dynamicProvider);
}

class CategoryFilterState extends State<CategoryFilter>
    with AutomaticKeepAliveClientMixin<CategoryFilter> {
  late List<String> selectedCategoryIds;
  AbstractSearchNotifier dynamicProvider;

  CategoryFilterState({required this.dynamicProvider}) {
    selectedCategoryIds = dynamicProvider.getSelectedSubcategoryIds;
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: dynamicProvider,
        )
      ],
      child: Container(
        padding: CategoryFilter.gridItemPadding,
        child: CustomScrollView(
            // controller: widget._scrollController,
            cacheExtent: double.maxFinite,
            slivers: sliverList),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

List<Widget> getCategoryGrid(
    {required bool isModalBottomSheetMode,
    required AbstractSearchNotifier dynamicProvider}) {
  List<Widget> categoryGrid = [];
  for (int index = 0; index < Categories.categoryIds.length; index += 2) {
    categoryGrid.add(Row(
      children: [
        Flexible(
          child: getCategoryGridItem(
            dynamicNotifier: dynamicProvider,
            index: index,
            isModalBottomSheetMode: isModalBottomSheetMode,
          ),
        ),
        const SizedBox(
          width: CategoryFilter.gridItemDistance,
        ),
        Flexible(
          child: getCategoryGridItem(
            dynamicNotifier: dynamicProvider,
            index: index + 1,
            isModalBottomSheetMode: isModalBottomSheetMode,
          ),
        ),
      ],
    ));
    categoryGrid.add(ExpandedWidget(
      categoryIndex: index,
      dynamicNotifier: dynamicProvider,
    ));
    categoryGrid.add(ExpandedWidget(
      categoryIndex: index + 1,
      dynamicNotifier: dynamicProvider,
    ));
    categoryGrid.add(const SizedBox(
      height: CategoryFilter.gridItemDistance,
    ));
  }
  return categoryGrid;
}

String getCategoryCaption(
    {required BuildContext context,
    required AbstractSearchNotifier dynamicNotifier}) {
  // special case if one page "Show More"
  if (dynamicNotifier.currentIndex == NavigatorConstants.ShowMorePageIndex) {
    return getShortCaption(
        caption: dynamicNotifier.showMoreCategoryTitle,
        cutOff: NavigatorConstants.CategoryNameCutOff);
  }
  List<String> subcategoryIds = dynamicNotifier.getSelectedSubcategoryIds;
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
    String caption = AppLocalizations.of(context)!.severalCategories;
    for (MapEntry<String, List<String>> item
        in categorySubcategoryMap.entries) {
      for (var i = 0; i < subcategoryIds.length; i++) {
        if (item.value.contains(subcategoryIds[i])) {
          String tempCaption =
              CategoryIdToI18nMapper.getCategorySubcategoryName(
                  context, item.key);

          if (tempCaption != caption) {
            if (caption != AppLocalizations.of(context)!.severalCategories) {
              return AppLocalizations.of(context)!.severalCategories;
            } else {
              caption = tempCaption;
            }
          }
        }
      }
    }
    return getShortCaption(
        cutOff: NavigatorConstants.CategoryNameCutOff, caption: caption);
  }
}

String getShortCaption({required int cutOff, required String caption}) {
  if (caption.length > cutOff) {
    return "${caption.substring(0, cutOff - 3)}...";
  } else {
    return caption;
  }
}