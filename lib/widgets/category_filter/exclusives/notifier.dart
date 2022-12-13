import 'package:flutter/cupertino.dart';

class ExpandedCategoryNotifier extends ChangeNotifier {
  static const int numberOfCategoriesPerRow = 2;
  int? _expandedListItemIndex;
  String? _expandedCategory;
  int? _expandedExpandableIndex;
  bool isModalBottomMode;

  ExpandedCategoryNotifier({required this.isModalBottomMode});

  void setExpanded({
    required int? index,
    required String? categoryId,
  }) {
    _expandedListItemIndex = index;

    _expandedExpandableIndex =
        index != null ? index ~/ numberOfCategoriesPerRow : null;

    _expandedCategory = categoryId;
    notifyListeners();
  }

  int? get getExpandedExpandableIndex => _expandedExpandableIndex;

  int? get getExpandedIndex => _expandedListItemIndex;

  String? get getExpandedCategory => _expandedCategory;

  bool get getIsModalBottomMode => isModalBottomMode;
}
