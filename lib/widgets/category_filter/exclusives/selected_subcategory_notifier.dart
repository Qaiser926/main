import 'package:flutter/cupertino.dart';

class SelectedSubcategoryNotifier extends ChangeNotifier {
  List<bool> _selectedSubcategories = [];

  List<String> subcategoryIds;

  SelectedSubcategoryNotifier({required this.subcategoryIds})
      : _selectedSubcategories =
            List.generate(subcategoryIds.length, (index) => false);

  void switchSelectedSubcategory(int index) {
    _selectedSubcategories[index] = !_selectedSubcategories[index];
    notifyListeners();
  }

  bool isSelected(int index) {
    return _selectedSubcategories[index];
  }

  List<String> get selectedSubcategoryIds {
    List<String> result = [];

    for (int i = 0; i < _selectedSubcategories.length; i++) {
      _selectedSubcategories.elementAt(i)
          ? result.add(subcategoryIds.elementAt(i))
          : null;
    }
    return result;
  }
}
