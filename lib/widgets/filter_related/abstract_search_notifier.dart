import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:othia/widgets/filter_related/sort_filter.dart';
import 'package:othia/widgets/filter_related/type_filter.dart';

import '../../constants/app_constants.dart';

abstract class AbstractSearchNotifier extends ChangeNotifier {
  // Pagecontroller related
  bool isControllerSet = false;
  final PageController _pageController;

  AbstractSearchNotifier(
      {priceRange = const RangeValues(
          NavigatorConstants.PriceRangeStart, NavigatorConstants.PriceRangeEnd),
      startDate,
      endDate,
      this.sortCriteria = null,
      this.eAType = EAType.eventsActivites,
      selectedCategoryIds,
      required PageController pageController})
      : _pageController = pageController {
    this.priceRange = defaultPriceRange = priceRange;
    this.startDate = defaultStartDate = startDate ?? DateTime.now();
    this.endDate =
        defaultEndDate = endDate ?? DateTime(DateTime.now().year + 2);
  }

  ////////////////

  void switchSelectedSubcategory(String subcategoryId) {
    isSubcategorySelected(subcategoryId)
        ? selectedSubcategoryIds.remove(subcategoryId)
        : selectedSubcategoryIds.add(subcategoryId);
    notifyListeners();
  }

  bool isSubcategorySelected(String subcategoryId) {
    return selectedSubcategoryIds.contains(subcategoryId);
  }

  static const int numberOfCategoriesPerRow = 2;
  int? _expandedListItemIndex;

  void setExpanded({
    required int? index,
  }) {
    _expandedListItemIndex = index;
    notifyListeners();
  }

  int? get getExpandedIndex => _expandedListItemIndex;

  ////////////

  int currentIndex = 0;

  // Search query related
  bool priceFilterActivated = false;
  bool timeFilterActivated = false;
  bool sortFilterActivated = false;
  bool typeFilterActivated = false;
  bool categoryFilterActivated = false;

  // keep below like it is!
  late String? timeCaption = null;
  late RangeValues defaultPriceRange;
  late RangeValues priceRange;

  late DateTime startDate;
  late DateTime defaultStartDate;
  late DateTime endDate;
  late DateTime defaultEndDate;

  late SortCriteria? sortCriteria;
  late EAType? eAType;

  late List<String> selectedSubcategoryIds = [];

  // late List<String> defaultSelectedCategoryIds = [];

  // show more page related
  late String showMoreCaption;
  late List<String?> showMoreIds;
  late String showMoreCategoryTitle;
  bool priceReset = false;
  bool dateReset = false;

  PageController getPageController() {
    return _pageController;
  }

  set setIndex(int newPage) {
    currentIndex = newPage;
    _pageController.jumpToPage(currentIndex);
    notifyListeners();
  }

  void goToResultPage() {
    notifyListeners();
    currentIndex = NavigatorConstants.ResultPageIndex;
    _pageController.jumpToPage(currentIndex);
  }

  void goToSearchPage() {
    currentIndex = NavigatorConstants.SearchPageIndex;
    _pageController.jumpToPage(currentIndex);
  }

  void goToShowMorePage(
      {required String showMoreCaption,
      required List<String?> showMoreIds,
      required String showMoreCategoryTitle}) {
    currentIndex = NavigatorConstants.ShowMorePageIndex;
    _pageController.jumpToPage(currentIndex);
    this.showMoreCaption = showMoreCaption;
    this.showMoreIds = showMoreIds;
    this.showMoreCategoryTitle = showMoreCategoryTitle;
    notifyListeners();
  }

  void backToDefault() {
    priceRange = defaultPriceRange;
    eAType = EAType.eventsActivites;
    startDate = defaultStartDate;
    endDate = defaultEndDate;
    priceRange = defaultPriceRange;
    sortCriteria = null;
    selectedSubcategoryIds = [];
    timeCaption = null;
    priceFilterActivated = false;
    timeFilterActivated = false;
    sortFilterActivated = false;
    typeFilterActivated = false;
    categoryFilterActivated = false;
    notifyListeners();
  }

  RangeValues get getPriceRange => priceRange;

  DateTime get getStartDate => startDate;

  DateTime get getEndDate => endDate;

  String? get getTimeCaption => timeCaption;

  SortCriteria? get getSortCriteria => sortCriteria;

  EAType? get getEAType => eAType;

  List<String> get getSelectedSubcategoryIds => selectedSubcategoryIds;

  void changePriceRange({required RangeValues priceRange}) {
    this.priceRange = priceRange;
    priceFilterActivated = true;

    goToResultPage();
  }

  void setPriceResetFalse() {
    priceReset = false;
  }

  void resetPriceRange() {
    priceRange = defaultPriceRange;
    priceReset = true;
    priceFilterActivated = false;

    notifyListeners();
  }

  void setDateResetFalse() {
    dateReset = false;
  }

  void resetStartEndDate() {
    startDate = defaultStartDate;
    endDate = defaultEndDate;
    dateReset = true;
    timeFilterActivated = false;
    timeCaption = null;
    notifyListeners();
  }

  void setTimeCaption({required String? caption}) {
    this.timeCaption = caption;
    notifyListeners();
  }

  void changeStartEndDate(
      {required DateTime startDate,
      required DateTime endDate,
      String? caption}) {
    this.startDate = startDate;
    this.endDate = endDate;
    timeFilterActivated = true;
    if (caption != null) {
      this.timeCaption = caption;
    }

    goToResultPage();
  }

  void setSortCriteria({required SortCriteria? sortCriteria}) {
    this.sortCriteria = sortCriteria;
  }

  void changeSortCriteria({required SortCriteria? sortCriteria}) {
    if (sortCriteria != null) {
      this.sortFilterActivated = true;
    }
    this.sortCriteria = sortCriteria;

    goToResultPage();
  }

  void resetSort() {
    sortCriteria = null;
    notifyListeners();
  }

  void resetEAType() {
    eAType = EAType.eventsActivites;
    notifyListeners();
  }

  void setEAType({required EAType? eAType}) {
    this.eAType = eAType;
  }

  void changeEAType({required EAType? eAType}) {
    if (eAType != null) {
      this.typeFilterActivated = true;
    }
    this.eAType = eAType;
    goToResultPage();
  }

  void resetSubcategoryList({required BuildContext context}) {
    categoryFilterActivated = false;
    selectedSubcategoryIds = [];
    if (!anyFilterActivated()) {
      if (currentIndex != NavigatorConstants.SearchPageIndex) Get.back();
      goToSearchPage();
    }
    notifyListeners();
  }

  void changeForFullCategorySearch(
      {required List<String> selectedCategoryIds}) {
    selectedSubcategoryIds.addAll(selectedCategoryIds);
    showCategoryFilterResults();
  }

  void showCategoryFilterResults() {
    setExpanded(index: null);
    categoryFilterActivated = true;
    goToResultPage();
  }

  bool anyFilterActivated() {
    return priceFilterActivated |
        timeFilterActivated |
        sortFilterActivated |
        typeFilterActivated |
        categoryFilterActivated;
  }

  SearchQuery getSearchQuery() {
    return SearchQuery(
        startDate: startDate,
        endDate: endDate,
        minPrice: priceRange.start,
        maxPrice: priceRange.end,
        sortCriteria: sortCriteria,
        selectedCategoryIds: selectedSubcategoryIds,
        eAType: eAType);
  }
}

class SearchQuery {
  final DateTime startDate;
  final DateTime endDate;
  final double minPrice;
  final double maxPrice;
  final SortCriteria? sortCriteria;
  final EAType? eAType;
  final List<String> selectedCategoryIds;

  SearchQuery(
      {required this.startDate,
      required this.endDate,
      required this.minPrice,
      required this.maxPrice,
      required this.sortCriteria,
      required this.selectedCategoryIds,
      required this.eAType});
}
