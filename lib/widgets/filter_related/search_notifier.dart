import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchNotifier extends ChangeNotifier {
  late RangeValues defaultPriceRange;
  late RangeValues priceRange;

  bool priceFilterActivated = false;
  bool showCategoryFilter = false;
  bool timeFilterActivated = false;

  late DateTime startDate;
  late DateTime defaultStartDate;
  late DateTime endDate;
  late DateTime defaultEndDate;

  SearchNotifier({required priceRange, startDate, required endDate}) {
    this.priceRange = this.defaultPriceRange = priceRange;
    this.startDate = this.defaultStartDate = startDate ?? DateTime.now();
    this.endDate = this.defaultEndDate = endDate;
  }

  RangeValues get getPriceRange => priceRange;

  DateTime get getStartDate => startDate;

  DateTime get getEndDate => endDate;

  void changePriceRange({required RangeValues priceRange}) {
    this.priceRange = priceRange;
    priceFilterActivated = true;
    showCategoryFilter = true;

    notifyListeners();
  }

  void changeStartEndDate(
      {required DateTime startDate, required DateTime endDate}) {
    this.startDate = startDate;
    this.endDate = endDate;
    timeFilterActivated = true;
    showCategoryFilter = true;
    notifyListeners();
  }

  bool isShowResults() {
    return priceFilterActivated | timeFilterActivated;
  }

  void backToDefault({showCategoryFilterReset = true}) {
    priceRange = defaultPriceRange;
    priceFilterActivated = false;
    startDate = defaultStartDate;
    endDate = defaultEndDate;
    timeFilterActivated = false;
    if (showCategoryFilterReset) {
      showCategoryFilter = false;
    }
    notifyListeners();
  }
}
