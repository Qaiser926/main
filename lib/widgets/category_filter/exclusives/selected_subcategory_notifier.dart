import 'package:flutter/cupertino.dart';
import 'package:othia/constants/categories.dart';

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

  void resetSelectedSubcategories() {
    _selectedSubcategories =
        List.filled(_selectedSubcategories.length, false, growable: true);
    notifyListeners();
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

  void alignNotifierStati({required List<String?> selectedCategoryIds}) {
    if (selectedCategoryIds.length == 1) {
      for (MapEntry<String, List<String>> item
          in categoryIdToSubcategoryIds.entries) {
        if (item.key == selectedCategoryIds[0]) {
          selectedCategoryIds = item.value;
          break;
        }
      }
    }
    for (var i = 0; i < selectedCategoryIds.length; i++) {
      int index = subcategoryIds.indexOf(selectedCategoryIds[i]!);
      if (index != -1) {
        _selectedSubcategories[index] = true;
      }
    }
  }
}
