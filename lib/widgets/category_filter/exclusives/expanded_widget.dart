import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/widgets/filter_related/abstract_search_notifier.dart';
import 'package:provider/provider.dart';

import '../../../constants/categories.dart';
import '../../../constants/colors.dart';
import '../../filter_related/get_reset_apply_filter.dart';

class ExpandedWidget<T> extends StatefulWidget {
  BuildContext context;
  final List<String> subcategoryIds;
  static const double singleExpandedHeight = 50;
  static const double singleExpandedWidth = 100;
  static const double containerMarginTop = 10;
  static const double containerMarginBottom = 10;
  static const double bottomRowHeight = 20;
  static const int animationTime = 200;
  static const double borderRadius = 23;
  final int categoryIndex;
  AbstractSearchNotifier dynamicNotifier;

  ExpandedWidget({
    required this.categoryIndex,
    required this.dynamicNotifier,
    required this.context,
  }) : subcategoryIds = categoryIdToSubcategoryIds
                .containsKey(Categories.categoryIds[categoryIndex])
            ? categoryIdToSubcategoryIds[Categories.categoryIds[categoryIndex]]!
            : [];

  @override
  State<ExpandedWidget> createState() => _ExpandedWidgetState(
      categoryIndex: categoryIndex,
      context: this.context,
      dynamicNotifier: this.dynamicNotifier);
}

class _ExpandedWidgetState<T> extends State<ExpandedWidget> {
  BuildContext context;
  final List<String> subcategoryIds;
  static const double singleExpandedHeight = 50;
  static const double singleExpandedWidth = 100;
  static const double containerMarginTop = 10;
  static const double containerMarginBottom = 10;
  static const double bottomRowHeight = 20;
  static const int animationTime = 200;
  static const double borderRadius = 23;
  final int categoryIndex;
  AbstractSearchNotifier dynamicNotifier;

  _ExpandedWidgetState({
    required this.categoryIndex,
    required this.dynamicNotifier,
    required this.context,
  }) : subcategoryIds = categoryIdToSubcategoryIds
                .containsKey(Categories.categoryIds[categoryIndex])
            ? categoryIdToSubcategoryIds[Categories.categoryIds[categoryIndex]]!
            : [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var secHei = (subcategoryIds.length * singleExpandedHeight) +
        containerMarginBottom +
        containerMarginTop +
        bottomRowHeight;

    return Consumer<AbstractSearchNotifier>(builder: (context, model, child) {
      bool expanded = model.getExpandedIndex == categoryIndex;
      if (subcategoryIds.isNotEmpty) {
        return AnimatedContainer(
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
            child: Consumer<AbstractSearchNotifier>(
                      builder: (context, model, child) {
                    bool closeDialog = true;
                    if (model.currentIndex ==
                        NavigatorConstants.SearchPageIndex) closeDialog = false;
                    return Container(
                        margin: EdgeInsets.only(
                          bottom: containerMarginBottom,
                          top: containerMarginTop,
                          left: 10.h,
                          right: 10.h,
                        ),
                        child: Text("123")

                        // Column(
                        //
                        //   children: getSubcategoryExpandableContent(
                        //       context, model as AbstractSearchNotifier, closeDialog),
                        // ),
                        );
                }),
          )
              : const SizedBox.shrink(),
        );
      } else {
        //TODO
        return const Text("Es ist ein unerwarteter Fehler aufgetreten");
      }
    });
  }

  List<Widget> getSubcategoryExpandableContent(BuildContext context,
      AbstractSearchNotifier dynamicNotifier, bool closeDialog) {
    List<Widget> result = [];
    result.add(getSubcategoryTextButtons(context));
    result.add(const SizedBox(
      height: 12,
    ));
    var selectedSubcategoryIds = dynamicNotifier.getSelectedSubcategoryIds;
    result.add(
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: getShowResultsButton(
            context: context,
            functionAccept: dynamicNotifier.showCategoryFilterResults,
            functionArgumentsAccept: {},
            functionReset: dynamicNotifier.resetSubcategoryList,
            functionArgumentsReset: {#context: context}),
      ),
      // ),
    );

    return result;
  }

  Widget getSubcategoryTextButtons(BuildContext context) {
    return Consumer<T>(builder: (context, model, child) {
      model as AbstractSearchNotifier;
      return Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        alignment: WrapAlignment.start,
        children: List<Widget>.generate(
          subcategoryIds.length,
          (subcategoryIndex) => SizedBox(
            height: singleExpandedHeight,
            // width: singleExpandedWidth,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                    dynamicNotifier.switchSelectedSubcategory(
                        subcategoryIds[subcategoryIndex]);
                  },
                  child: Container(
                    height: singleExpandedHeight - 8,
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: model.isSubcategorySelected(
                          subcategoryIds[subcategoryIndex])
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
                              CategoryIdToI18nMapper.getCategorySubcategoryName(
                                  context, subcategoryIds[subcategoryIndex]),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
        ),
      );
    });
  }
}

void test() {
  print("got called0");
}
