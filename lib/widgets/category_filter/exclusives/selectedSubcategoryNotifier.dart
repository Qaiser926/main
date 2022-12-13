import 'package:flutter/cupertino.dart';

class SelectedSubcategoryNotifier extends ChangeNotifier {
  List<bool> _selectedSubcategories = [];

  SelectedSubcategoryNotifier({required int numberOfCategories}) {
    _selectedSubcategories =
        List.generate(numberOfCategories, (index) => false);
  }

  void switchSelectedSubcategory(int index) {
    _selectedSubcategories[index] = !_selectedSubcategories[index];
    notifyListeners();
  }

  bool isSelected(int index) {
    return _selectedSubcategories[index];
  }
}
