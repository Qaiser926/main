import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/categories.dart';
import '../../../constants/colors.dart';
import 'notifier.dart';

Widget getCategoryGridItem(
    {required int index,
    required ScrollController scrollController,
    required Key key}) {
  final String categoryId = Categories.categoryIds[index];

  return CategoryGridItem(
    index: index,
    categoryId: categoryId,
    scrollController: scrollController,
    key: key,
  );
}

class CategoryGridItem extends StatelessWidget {
  final int index;
  final String categoryId;

  Icon expandIcon = const Icon(Icons.expand_more_outlined);

  //cannot be shorter. Category names that need two lines will be cut out if shorter.
  static const double bottomPartHeight = 55;
  static const double gradientHeight = 10;

  final ScrollController scrollController;

  var key;

  CategoryGridItem({
    required this.key,
    required this.index,
    required this.categoryId,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //TODO forward to result for category
      },
      child: SizedBox(
        height: WidgetConstants.categoryGridItemHeight,
        width: WidgetConstants.categoryGridItemWidth,
        child: Stack(
          children: [
            Categories.categoryRoundedImagesMap[categoryId]!,
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: gradientHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          lessListItemColor.withOpacity(.7),
                          lessListItemColor.withOpacity(0),
                        ],
                        begin: Alignment.bottomCenter,
                        tileMode: TileMode.mirror,
                        end: Alignment.topCenter),
                  ),
                ),
                GestureDetector(
                  onTap: () => onLowerAreaTapped(context),
                  child: Container(
                    height: bottomPartHeight,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: ShapeDecoration(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.zero,
                          topLeft: Radius.zero,
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      color: lessListItemColor.withOpacity(.7),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: WidgetConstants.categoryGridItemTextWidth,
                          child: Flexible(
                              child: Text(CategoryIdToI18nMapper.fckMethod(
                                  context, categoryId))),
                        ),
                        const Spacer(),
                        Consumer<ExpandedCategoryNotifier>(
                            builder: (context, model, child) {
                          return model.getExpandedIndex == index
                              ? const Icon(Icons.expand_less_outlined)
                              : const Icon(Icons.expand_more_outlined);
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            IgnorePointer(
              child: Consumer<ExpandedCategoryNotifier>(
                  builder: (context, model, child) {
                return model.getExpandedIndex == index
                    ? Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: primaryColor, width: 3)),
                      )
                    : const SizedBox.shrink();
              }),
            ),
          ],
        ),
      ),
    );
  }

  void onLowerAreaTapped(BuildContext context) {
    ExpandedCategoryNotifier categoryProvider =
        Provider.of<ExpandedCategoryNotifier>(context, listen: false);
    if (categoryProvider.getExpandedIndex == index) {
      categoryProvider.setExpanded(index: null, categoryId: null);
    } else {
      categoryProvider.setExpanded(index: index, categoryId: categoryId);
    }
    // scrollController.animateTo(offset, duration: duration, curve: curve)
  }
}
