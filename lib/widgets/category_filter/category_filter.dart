import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:provider/provider.dart';

import '../../constants/catgories.dart';
import 'exclusives/notifier.dart';

const itemCount = 8;

class CategoryFilter extends StatelessWidget {
  Image image = getAssetImage(categoryIds[1] + ".jpg");
  Image image2 = getAssetImage(categoryIds[2] + ".jpg");

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ExpandedCategoryNotifier(),
        )
      ],
      child:
          Consumer<ExpandedCategoryNotifier>(builder: (context, model, child) {
        return CustomScrollView(slivers: [
          SliverList(
            delegate: SliverChildListDelegate(getList(model)),
          )
        ]);
      }),
    );
  }
}

List<Widget> getList(ExpandedCategoryNotifier expandedCategoryNotifier) {
  List<Widget> allMightyList = [];
  for (int index = 0; index < itemCount; index++) {
    if (index != 0 && index % 2 == 1) {
      if (expandedCategoryNotifier.getExpandedIndex == index ||
          expandedCategoryNotifier.getExpandedIndex == index - 1) {
        allMightyList.add(getExpandedWidget(
            expandedCategoryNotifier.getExpandedCategory!, true));
      } else {
        allMightyList.add(getExpandedWidget("", false));
      }
    } else {
      allMightyList.add(Row(
        children: [
          Flexible(
              child: getCategoryGridItem(
                  index: index + 1,
                  currentExpandedIndex:
                      expandedCategoryNotifier.getExpandedIndex)),
          Flexible(
              child: getCategoryGridItem(
                  index: index,
                  currentExpandedIndex:
                      expandedCategoryNotifier.getExpandedIndex))
        ],
      ));
    }
  }

  return allMightyList;
}

Widget getCategoryGridItem(
    {required int index, required int? currentExpandedIndex}) {
  final String categoryId = categoryIds[index];
  Image image = getAssetImage(categoryId + ".jpg");

  return CategoryGridItem(
    image: image,
    index: index,
    categoryId: categoryId,
    currentExpandedIndex: currentExpandedIndex,
  );
}

Widget getExpandedWidget(String expandedCategoryId, bool expanded) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 200),
    // margin: const EdgeInsets.all(20.0),
    width: !expanded ? 0 : 600,
    height: !expanded ? 0 : 100,
    color: Colors.red,
    child: Text(expandedCategoryId),
  );
}

//
//   return categoryWidgets;
// }

//list of each bloc expandable state, that is changed to trigger the animation of the AnimatedContainer
List<bool> expandableState = List.generate(itemCount, (index) => false);

class CategoryGridItem extends StatelessWidget {
  final int index;
  final Image image;
  final String categoryId;
  final int? currentExpandedIndex;

  Icon expandIcon = Icon(Icons.expand_more_outlined);

  CategoryGridItem({
    super.key,
    required this.index,
    required this.image,
    required this.categoryId,
    required this.currentExpandedIndex,
  });

  @override
  Widget build(BuildContext context) {
    Image fittedImage = Image(
      image: image.image,
      fit: BoxFit.cover,
      width: 610.h,
      height: 800.h,
    );

    return SizedBox(
      height: 250,
      width: 400,
      child: Stack(
        children: [
          fittedImage,
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(),
              Row(
                children: [
                  Text("Ich bin eine Kategorie"),
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
                      icon: currentExpandedIndex == index
                          ? Icon(Icons.expand_more_outlined)
                          : Icon(Icons.expand_less_outlined),
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
