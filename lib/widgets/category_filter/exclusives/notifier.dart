import 'package:flutter/cupertino.dart';

class ExpandedCategoryNotifier extends ChangeNotifier {
  int? _expandedIndex;
  String? _expandedCategory;

  ExpandedCategoryNotifier() {}

  void setExpanded({required int? index, required String? categoryId}) {
    _expandedIndex = index;
    _expandedCategory = categoryId;
    notifyListeners();
  }

  int? get getExpandedIndex => _expandedIndex;

  String? get getExpandedCategory => _expandedCategory;
}
