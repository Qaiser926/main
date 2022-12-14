import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:othia/widgets/filter_related/sort_filter.dart';
import 'package:othia/widgets/filter_related/type_filter.dart';

class SearchNotifier extends ChangeNotifier {
  bool priceFilterActivated = false;
  bool showCategoryFilter = false;
  bool timeFilterActivated = false;
  bool sortFilterActivated = false;
  bool typeFilterActivated = false;
  bool categoryFilterActivated = false;

  // keep below like it!
  late String? timeCaption = null;
  late RangeValues defaultPriceRange;
  late RangeValues priceRange;

  late DateTime startDate;
  late DateTime defaultStartDate;
  late DateTime endDate;
  late DateTime defaultEndDate;

  late SortCriteria? sortCriteria;
  late EAType? eAType;

  late List<String> selectedCategoryIds;
  late List<String> defalutSelectedCategoryIds;

  SearchNotifier(
      {required priceRange,
      startDate,
      required endDate,
      required this.sortCriteria,
      required this.eAType,
      required selectedCategoryIds}) {
    this.priceRange = this.defaultPriceRange = priceRange;
    this.startDate = this.defaultStartDate = startDate ?? DateTime.now();
    this.endDate = this.defaultEndDate = endDate;
    this.selectedCategoryIds =
        this.defalutSelectedCategoryIds = selectedCategoryIds;
  }

  RangeValues get getPriceRange => priceRange;

  DateTime get getStartDate => startDate;

  DateTime get getEndDate => endDate;

  String? get getTimeCaption => timeCaption;

  SortCriteria? get getSortCriteria => sortCriteria;

  EAType? get getEAType => eAType;

  List<String> get getSelectedCategoryIds => selectedCategoryIds;

  void changeCategoryIdList({required List<String> selectedCategoryIds}) {
    showCategoryFilter = true;
    categoryFilterActivated = true;
    this.selectedCategoryIds = selectedCategoryIds;
    notifyListeners();
  }

  void changePriceRange({required RangeValues priceRange}) {
    this.priceRange = priceRange;
    priceFilterActivated = true;
    showCategoryFilter = true;
    notifyListeners();
  }

  void changeStartEndDate(
      {required DateTime startDate,
      required DateTime endDate,
      String? caption}) {
    this.startDate = startDate;
    this.endDate = endDate;
    timeFilterActivated = true;
    showCategoryFilter = true;
    if (caption != null) {
      this.timeCaption = caption;
    }
    notifyListeners();
  }

  void changeSortCriteria({required SortCriteria? sortCriteria}) {
    if (sortCriteria != null) {
      this.sortFilterActivated = true;
      showCategoryFilter = true;
    } else {
      showCategoryFilter = false;
    }
    this.sortCriteria = sortCriteria;
    notifyListeners();
  }

  void changeEAType({required EAType? eAType}) {
    if (eAType != null) {
      this.typeFilterActivated = true;
      showCategoryFilter = true;
    } else {
      showCategoryFilter = false;
    }
    this.eAType = eAType;
    notifyListeners();
  }

  void setTimeCaption({required String? caption}) {
    this.timeCaption = caption;
    notifyListeners();
  }

  bool isShowResults() {
    return priceFilterActivated |
        timeFilterActivated |
        sortFilterActivated |
        typeFilterActivated |
        categoryFilterActivated;
  }

  void backToDefault({showCategoryFilterReset = true}) {
    priceRange = defaultPriceRange;
    priceFilterActivated = false;
    startDate = defaultStartDate;
    endDate = defaultEndDate;
    timeFilterActivated = false;
    sortCriteria = null;
    eAType = null;
    sortFilterActivated = false;
    typeFilterActivated = false;
    categoryFilterActivated = false;
    selectedCategoryIds = defalutSelectedCategoryIds;
    if (showCategoryFilterReset) {
      showCategoryFilter = false;
    }
    notifyListeners();
  }

  SearchQuery getSearchQuery() {
    return SearchQuery(
        startDate: startDate,
        endDate: endDate,
        minPrice: priceRange.start,
        maxPrice: priceRange.end,
        sortCriteria: sortCriteria,
        selectedCategoryIds: selectedCategoryIds,
        eAType: eAType);
  }
}

class SearchQuery {
  final DateTime? startDate;
  final DateTime? endDate;
  final double? minPrice;
  final double? maxPrice;
  final SortCriteria? sortCriteria;
  final EAType? eAType;
  final List<String>? selectedCategoryIds;

  SearchQuery(
      {required this.startDate,
      required this.endDate,
      required this.minPrice,
      required this.maxPrice,
      required this.sortCriteria,
      required this.selectedCategoryIds,
      required this.eAType});
}
