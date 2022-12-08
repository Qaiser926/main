import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchNotifier extends ChangeNotifier {
  late RangeValues defaultpriceRange;
  late RangeValues priceRange;
  bool defaultSearchResults = false;
  bool showSearchResults = false;

  bool priceFilterActivated = false;
  bool showCategoryFilter = false;


  SearchNotifier(
      {required priceRange}){
    this.priceRange = this.defaultpriceRange = priceRange;
  }

  RangeValues get getPriceRange => priceRange;
  bool get getSearchResults => showSearchResults;


  void changePriceRange({required RangeValues priceRange}) {
    this.priceRange = priceRange;
    showSearchResults = true;
    priceFilterActivated = true;
    showCategoryFilter = true;

    notifyListeners();
  }

    // depreciated
  void activateShowSearchResults() {
    showSearchResults = true;
    notifyListeners();
  }

  void backToDefault({showCategoryFilterReset = true}){
    priceRange = defaultpriceRange;
    showSearchResults = defaultSearchResults;
    priceFilterActivated = false;
    if (showCategoryFilterReset){
      showCategoryFilter = false;
    }
    notifyListeners();
  }
}
