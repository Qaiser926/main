import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/constants/categories.dart';
import 'package:othia/constants/colors.dart';
import 'package:othia/widgets/filter_related/get_reset_apply_filter.dart';
import 'package:othia/widgets/filter_related/notifiers/abstract_query_notifier.dart';
import 'package:provider/provider.dart';

class ExpandedWidget<AbstractSearchNotifier> extends StatefulWidget {
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
  }) : subcategoryIds = categoryIdToSubcategoryIds
                .containsKey(Categories.categoryIds[categoryIndex])
            ? categoryIdToSubcategoryIds[Categories.categoryIds[categoryIndex]]!
            : [];

  @override
  State<ExpandedWidget> createState() =>
      _ExpandedWidgetState(categoryIndex: categoryIndex);
}

class _ExpandedWidgetState extends State<ExpandedWidget> {
  final List<String> subcategoryIds;
  static const double singleExpandedHeight = 50;
  static const double singleExpandedWidth = 100;
  static const double containerMarginTop = 10;
  static const double containerMarginBottom = 10;
  static const double bottomRowHeight = 20;
  static const int animationTime = 200;
  static const double borderRadius = 23;
  final int categoryIndex;

  _ExpandedWidgetState({
    required this.categoryIndex,
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

    return Consumer<AbstractQueryNotifier>(builder: (context, model, child) {
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
            child: Consumer<AbstractQueryNotifier>(
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
                      child: Column(
                        children: getSubcategoryExpandableContent(
                            context, widget.dynamicNotifier, closeDialog),
                      ),
                    );
                  }),
                )
              : const SizedBox.shrink(),
        );
      } else {
        //TODO (extern) Error handling
        return const Text("An error occured");
      
      }
    });
  
  }

  List<Widget> getSubcategoryExpandableContent(BuildContext context,
      AbstractQueryNotifier dynamicNotifier, bool closeDialog) {
    List<Widget> result = [];
    result.add(getSubcategoryTextButtons(
        context: context, dynamicNotifier: dynamicNotifier));
    result.add(const SizedBox(
      height: 12,
    ));
    result.add(
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: getShowResultsButton(
            closeDialog: closeDialog,
            context: context,
            functionAccept: dynamicNotifier.showCategoryFilterResults,
            functionArgumentsAccept: {},
            functionReset: dynamicNotifier.resetSelectedSubcategories,
            functionArgumentsReset: {
              #context: context,
              #subcategoryIds: subcategoryIds
            }),
      ),
      // ),
    );

    return result;
  }

  Widget getSubcategoryTextButtons(
      {required BuildContext context,
      required AbstractQueryNotifier dynamicNotifier}) {
    return Consumer<AbstractQueryNotifier>(builder: (context, model, child) {
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
