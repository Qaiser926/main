import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/widgets/category_filter/exclusives/selectedSubcategoryNotifier.dart';
import 'package:provider/provider.dart';

import '../../../constants/catgories.dart';
import '../../../constants/colors.dart';
import '../../../constants/colors.dart';
import '../../filter_related/get_reset_apply_filter.dart';
import 'notifier.dart';

class ExpandedWidget extends StatelessWidget {
  final List<String> subcategoryIds;
  static const double singleExpandedHeight = 40;
  static const double containerMarginTop = 10;
  static const double containerMarginBottom = 10;
  static const double bottomRowHeight = 20;
  static const int animationTime = 200;
  static const double borderRadius = 23;

  final int index;

  ExpandedWidget({
    super.key,
    required this.index,
  }) : subcategoryIds = categoryIdToSubcategoryIds
                .containsKey(Categories.categoryIds[index])
            ? categoryIdToSubcategoryIds[Categories.categoryIds[index]]!
            : [];

  @override
  Widget build(BuildContext context) {
    var secHei = (subcategoryIds.length * singleExpandedHeight) +
        containerMarginBottom +
        containerMarginTop +
        bottomRowHeight;

    return Consumer<ExpandedCategoryNotifier>(builder: (context, model, child) {
      bool expanded = model.getExpandedIndex == index;
      if (!subcategoryIds.isEmpty) {
        return MultiProvider(
            providers: [
              ChangeNotifierProvider.value(
                value: SelectedSubcategoryNotifier(
                  numberOfCategories: subcategoryIds.length,
                ),
              )
            ],
            child: AnimatedContainer(
              duration: Duration(milliseconds: animationTime),
              // margin: const EdgeInsets.all(20.0),
              width: expanded ? 600 : 0,
              height: expanded ? secHei : 0,
              child: expanded
                  ? Container(
                      decoration: BoxDecoration(
                          color: listItemColor,
                          borderRadius: BorderRadius.circular(borderRadius)),
                      child: Consumer<SelectedSubcategoryNotifier>(
                          builder: (context, model, child) {
                        return Container(
                          margin: EdgeInsets.only(
                            bottom: containerMarginBottom,
                            top: containerMarginTop,
                            left: 10.h,
                            right: 10.h,
                          ),
                          child: Column(
                            children:
                                getSubcategoryExpandableContent(context, model),
                          ),
                        );
                      }),
                    )
                  : SizedBox.shrink(),
            ));
      } else {
        //TODO
        return Text("Es ist ein unerwartet Fehler aufgetreten");
      }
    });
  }

  List<Widget> getSubcategoryExpandableContent(
      BuildContext context, SelectedSubcategoryNotifier model) {
    List<Widget> result = [];
    result.addAll(getSubcategoryTextButtons(context, model));

    result.add(Container(
        height: bottomRowHeight,
        child: getShowResultsButton(
            context: context, function: test, functionArguments: {})));

    return result;
  }

  List<Widget> getSubcategoryTextButtons(
      BuildContext context, SelectedSubcategoryNotifier model) {
    return List<Widget>.generate(
      subcategoryIds.length,
      (index) => SizedBox(
        height: singleExpandedHeight,
        child: Row(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                var categoryProvider = Provider.of<SelectedSubcategoryNotifier>(
                    context,
                    listen: false);
                categoryProvider.switchSelectedSubcategory(index);
              },
              child: SizedBox(
                height: singleExpandedHeight,
                child: Container(
                  height: singleExpandedHeight - 8,
                  padding: EdgeInsets.all(4),
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      border: model.isSelected(index)
                          ? Border.all(color: primaryColor, width: 2.5)
                          : Border.all(color: Colors.transparent, width: 2.5),
                      borderRadius: BorderRadius.circular(23)),
                  transformAlignment: Alignment.center,
                  child: Center(
                    child: Text(subcategoryIds[index]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void test() {
  print("got called0");
}
