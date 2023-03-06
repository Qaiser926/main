import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/constants/categories.dart';
import 'package:othia/constants/colors.dart';
import 'package:othia/widgets/filter_related/notifiers/abstract_query_notifier.dart';
import 'package:provider/provider.dart';

Widget getCategoryGridItem(
    {required int index,
    required bool isModalBottomSheetMode,
    required AbstractQueryNotifier dynamicNotifier}) {
  final String categoryId = Categories.categoryIds[index];

  return CategoryGridItem(
    dynamicNotifier: dynamicNotifier,
    index: index,
    categoryId: categoryId,
    isModalBottomSheetMode: isModalBottomSheetMode,
  );
}

class CategoryGridItem extends StatelessWidget {
  AbstractQueryNotifier dynamicNotifier;
  final int index;
  final String categoryId;
  final bool isModalBottomSheetMode;

  Icon expandIcon = const Icon(Icons.expand_more_outlined);

  //cannot be shorter. Category names that need two lines will be cut out if shorter.
  static const double bottomPartHeight = 55;
  static const double gradientHeight = 10;

  CategoryGridItem({
    super.key,
    required this.index,
    required this.categoryId,
    required this.isModalBottomSheetMode,
    required this.dynamicNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        dynamicNotifier.changeForFullCategorySearch(
            selectedCategoryIds: categoryIdToSubcategoryIds[categoryId]!);
        if (isModalBottomSheetMode) {
          Get.back();
        }
      },
      child: FittedBox(
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 4,
          width: MediaQuery.of(context).size.width / 2,
          child: Stack(
            children: [
              Categories.categoryRoundedImagesMap[categoryId]!,
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    // height: MediaQuery.of(context).size.height,
                    // width: MediaQuery.of(context).size.width,
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
                      // height: MediaQuery.of(context).size.height,
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
                            child: Text(
                              CategoryIdToI18nMapper.getCategorySubcategoryName(
                                  context, categoryId),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Spacer(),
                          Consumer<AbstractQueryNotifier>(
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
                child: Consumer<AbstractQueryNotifier>(
                    builder: (context, model, child) {
                  return ((model.getExpandedIndex == index) |
                          model.isCategorySelected(categoryId: categoryId))
                      ? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border:
                                  Border.all(color: primaryColor, width: 3)),
                        )
                      : const SizedBox.shrink();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  

  }

  void onLowerAreaTapped(BuildContext context) {
    if (dynamicNotifier.getExpandedIndex == index) {
      dynamicNotifier.setExpanded(index: null);
    } else {
      dynamicNotifier.setExpanded(index: index);
    }
  }
}
