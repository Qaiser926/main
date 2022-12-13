import 'package:flutter/cupertino.dart';
import 'package:othia/constants/categories.dart';

class ExpandedCategoryNotifier extends ChangeNotifier {
  static const int numberOfCategoriesPerRow = 2;
  int? _expandedListItemIndex;
  String? _expandedCategory;
  int? _expandedExpandableIndex;
  late final List<GlobalKey?> _expandedKeys;

  ExpandedCategoryNotifier() {
    _expandedKeys =
        List.generate(Categories.categoryIds.length, (index) => null);
  }

  void setExpanded({required int? index, required String? categoryId}) {
    _expandedListItemIndex = index;

    _expandedExpandableIndex =
        index != null ? index ~/ numberOfCategoriesPerRow : null;

    _expandedCategory = categoryId;
    notifyListeners();
  }

  int? get getExpandedExpandableIndex => _expandedExpandableIndex;

  int? get getExpandedIndex => _expandedListItemIndex;

  String? get getExpandedCategory => _expandedCategory;

  GlobalKey getKey(int index) {
    return _expandedKeys[index]!;
  }

  void addKey(int index, GlobalKey key) {
    _expandedKeys[index] = key;
  }
}
