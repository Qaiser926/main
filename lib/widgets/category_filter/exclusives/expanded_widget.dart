import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/widgets/category_filter/exclusives/selected_subcategory_notifier.dart';
import 'package:provider/provider.dart';

import '../../../constants/categories.dart';
import '../../../constants/colors.dart';
import '../../filter_related/get_reset_apply_filter.dart';
import '../../filter_related/search_notifier.dart';
import 'notifier.dart';

class ExpandedWidget extends StatelessWidget {
  final List<String> subcategoryIds;
  static const double singleExpandedHeight = 50;
  static const double singleExpandedWidth = 100;
  static const double containerMarginTop = 10;
  static const double containerMarginBottom = 10;
  static const double bottomRowHeight = 20;
  static const int animationTime = 200;
  static const double borderRadius = 23;
  final int index;

  ExpandedWidget({
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
      if (subcategoryIds.isNotEmpty) {
        return MultiProvider(
            // key: key,
            providers: [
              ChangeNotifierProvider.value(
                value:
                    SelectedSubcategoryNotifier(subcategoryIds: subcategoryIds),
              )
            ],
            child: AnimatedContainer(
              margin: expanded ? const EdgeInsets.only(top: 10) : null,
              duration: const Duration(milliseconds: animationTime),
              width: expanded ? 600 : 0,
              // height: expanded ? secHei : 0,
              child: expanded
                  ? Container(
                      decoration: BoxDecoration(
                        color: listItemColor,
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
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
                  : const SizedBox.shrink(),
            ));
      } else {
        //TODO
        return const Text("Es ist ein unerwartet Fehler aufgetreten");
      }
    });
  }

  List<Widget> getSubcategoryExpandableContent(
      BuildContext context, SelectedSubcategoryNotifier model) {
    List<Widget> result = [];
    result.add(getSubcategoryTextButtons(context, model));
    result.add(const SizedBox(
      height: 12,
    ));
    var searchNotifier = Provider.of<SearchNotifier>(context, listen: false);
    searchNotifier.setSelectedSubcategories = model.selectedSubcategoryIds;

    //TODO size of show results button
    result.add(
      SizedBox(
        height: bottomRowHeight,
        child: getShowResultsButton(
            context: context, function: test, functionArguments: {}),
      ),
    );
    return result;
  }

  Widget getSubcategoryTextButtons(
      BuildContext context, SelectedSubcategoryNotifier model) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      alignment: WrapAlignment.start,
      children: List<Widget>.generate(
        subcategoryIds.length,
        (index) => SizedBox(
          height: singleExpandedHeight,
          // width: singleExpandedWidth,
          child: GestureDetector(
            // behavior: HitTestBehavior.translucent,
            onTap: () {
              var categoryProvider = Provider.of<SelectedSubcategoryNotifier>(
                  context,
                  listen: false);
              categoryProvider.switchSelectedSubcategory(index);
            },
            child: Container(
              height: singleExpandedHeight - 8,
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: model.isSelected(index)
                    ? Border.all(color: primaryColor, width: 2.5)
                    : Border.all(color: bgColor, width: 2.5),
                borderRadius: BorderRadius.circular(18),
              ),
              transformAlignment: Alignment.center,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        textAlign: TextAlign.center,
                        CategoryIdToI18nMapper.fckMethod(
                            context, subcategoryIds[index]),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

void test() {
  print("got called0");
}
