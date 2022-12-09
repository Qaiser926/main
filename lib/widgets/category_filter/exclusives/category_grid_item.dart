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
              Container(
                height: 50,padding: EdgeInsets.symmetric(horizontal: 10),
                // margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.zero,
                            topLeft: Radius.zero,
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                    color: lessListItemColor.withOpacity(.7)),
                child: Row(
                  children: [
                    // SizedBox(
                    //   width: 10,
                    // ),
                    Flexible(
                      child: Text(categoryId.substring(0, 28)),
                    ),
                    // ExpansionPanel(headerBuilder: (context, isExpanded) => Text("yes yes"), body: Text("")),
                    SizedBox(
                      width: 20.h,
                      // height: 35.h,
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
              ),
            ],
          )
        ],
      ),
    );
  }
}
