import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchNotifier extends ChangeNotifier {
  late RangeValues defaultPriceRange;
  late RangeValues priceRange;

  bool priceFilterActivated = false;
  bool showCategoryFilter = false;


  SearchNotifier(
      {required priceRange}){
    this.priceRange = this.defaultPriceRange = priceRange;
  }

  RangeValues get getPriceRange => priceRange;



  void changePriceRange({required RangeValues priceRange}) {
    this.priceRange = priceRange;
    priceFilterActivated = true;
    showCategoryFilter = true;

    notifyListeners();
  }

  bool isShowResults(){
    return priceFilterActivated;
  }


  void backToDefault({showCategoryFilterReset = true}){
    priceRange = defaultPriceRange;
    priceFilterActivated = false;
    if (showCategoryFilterReset){
      showCategoryFilter = false;
    }
    notifyListeners();
  }
}
