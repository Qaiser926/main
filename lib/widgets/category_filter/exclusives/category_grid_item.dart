import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constants/catgories.dart';
import '../../../constants/colors.dart';
import '../../../utils/ui/ui_utils.dart';
import 'notifier.dart';

Widget getCategoryGridItem({required int index}) {
  final String categoryId = Categories.categoryIds[index];
  // Image image = getAssetImage(categoryId + ".jpg");

  return CategoryGridItem(
    index: index,
    categoryId: categoryId,
  );
}

class CategoryGridItem extends StatelessWidget {
  final int index;
  final String categoryId;

  Icon expandIcon = const Icon(Icons.expand_more_outlined);

  CategoryGridItem({
    super.key,
    required this.index,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          Categories.categoryRoundedImagesMap[categoryId]!,
          Consumer<ExpandedCategoryNotifier>(builder: (context, model, child) {
            return model.getExpandedIndex == index
                ? Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: primaryColor, width: 3)),
                  )
                : SizedBox.shrink();
          }),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(),
              Row(
                children: [
                  Text(categoryId.substring(0, 18)),
                  // ExpansionPanel(headerBuilder: (context, isExpanded) => Text("yes yes"), body: Text("")),
                  SizedBox(
                    width: 40.h,
                    height: 40.h,
                    child: IconButton(
                      style: ButtonStyle(
                          animationDuration: Duration(seconds: 1),
                          splashFactory: NoSplash.splashFactory),
                      splashColor: Colors.transparent,
                      onPressed: () {
                        var categoryProvider =
                            Provider.of<ExpandedCategoryNotifier>(context,
                                listen: false);
                        if (categoryProvider.getExpandedIndex == index) {
                          categoryProvider.setExpanded(
                              index: null, categoryId: null);
                        } else {
                          categoryProvider.setExpanded(
                              index: index, categoryId: categoryId);
                        }
                      },
                      icon: Consumer<ExpandedCategoryNotifier>(
                          builder: (context, model, child) {
                        return model.getExpandedIndex == index
                            ? Icon(Icons.expand_more_outlined)
                            : Icon(Icons.expand_less_outlined);
                      }),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
