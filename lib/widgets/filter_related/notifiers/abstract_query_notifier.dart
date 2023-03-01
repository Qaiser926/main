import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/modules/models/search_query/search_query.dart';
import 'package:othia/widgets/filter_related/sort_filter.dart';
import 'package:othia/widgets/filter_related/type_filter.dart';

import '../../../constants/categories.dart';

abstract class AbstractQueryNotifier extends ChangeNotifier {
  // Pagecontroller related
  bool isControllerSet = false;
  final PageController pageController;

  AbstractQueryNotifier(
      {priceRange = const RangeValues(
          DataConstants.PriceRangeStart, DataConstants.PriceRangeEnd),
      startDate,
      endDate,
      this.sortCriteria = null,
      this.eAType = EAType.eventsActivities,
      selectedCategoryIds,
      required PageController pageController})
      : pageController = pageController {
    this.priceRange = defaultPriceRange = priceRange;
    this.startDate = defaultStartDate = startDate ?? DateTime.now();
    this.endDate =
        defaultEndDate = endDate ?? DateTime(DateTime.now().year + 2);
  }

  ////////////////

  // request handling
  late Future<Object> searchQueryResult;

  void sendRequest();

  Future<Object> getSearchQueryResult() {
    return searchQueryResult;
  }

  //////////////////////////////

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

  // show more page related
  late String showMoreCaption;
  late List<String?> showMoreIds;
  late String showMoreCategoryTitle;
  bool priceReset = false;
  bool dateReset = false;

  PageController getPageController() {
    return pageController;
  }

  set setIndex(int newPage) {
    currentIndex = newPage;
    pageController.jumpToPage(currentIndex);
    notifyListeners();
  }

  void goToResultPage() {
    notifyListeners();
    currentIndex = NavigatorConstants.ResultPageIndex;
    pageController.jumpToPage(currentIndex);
  }

  void goToFirstPage();

  void goToShowMorePage(
      {required String showMoreCaption,
      required List<String?> showMoreIds,
      required String showMoreCategoryTitle}) {
    currentIndex = NavigatorConstants.ShowMorePageIndex;
    pageController.jumpToPage(currentIndex);
    this.showMoreCaption = showMoreCaption;
    this.showMoreIds = showMoreIds;
    this.showMoreCategoryTitle = showMoreCategoryTitle;
    notifyListeners();
  }

  void backToDefault() {
    priceRange = defaultPriceRange;
    eAType = EAType.eventsActivities;
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
    sendRequest();
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
    sendRequest();
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
    sendRequest();
    goToResultPage();
  }

  void resetSort() {
    sortCriteria = null;
    notifyListeners();
  }

  void resetEAType() {
    eAType = EAType.eventsActivities;
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
    sendRequest();
    goToResultPage();
  }

  void resetSelectedSubcategories(
      {required BuildContext context, required List<String> subcategoryIds}) {
    for (var i = 0; i < subcategoryIds.length; i++) {
      selectedSubcategoryIds.remove(subcategoryIds[i]);
    }

    notifyListeners();
  }

  void resetSubcategoryList({required BuildContext context}) {
    categoryFilterActivated = false;
    selectedSubcategoryIds = [];
    // if (!anyFilterActivated()) {
    //   if (currentIndex != NavigatorConstants.SearchPageIndex) Get.back();
    //   goToFirstPage();
    // }
    notifyListeners();
  }

  bool isCategorySelected({required categoryId}) {
    for (var i = 0; i < selectedSubcategoryIds.length; i++) {
      if (categoryId ==
          mapSubcategoryToCategory(subCategoryId: selectedSubcategoryIds[i])) {
        return true;
      }
    }
    return false;
  }

  void changeForFullCategorySearch(
      {required List<String> selectedCategoryIds}) {
    selectedSubcategoryIds.addAll(selectedCategoryIds);
    showCategoryFilterResults();
  }

  void showCategoryFilterResults() {
    setExpanded(index: null);
    categoryFilterActivated = true;
    sendRequest();
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
        startDateUtc: DateTime(startDate.year, startDate.month, startDate.day,
                startDate.hour, startDate.minute)
            .subtract(DateTime.now().timeZoneOffset),
        endDateUtc: DateTime(endDate.year, endDate.month, endDate.day,
                endDate.hour, endDate.minute)
            .subtract(DateTime.now().timeZoneOffset),
        minPrice: priceRange.start,
        maxPrice: priceRange.end,
        sortCriteria: sortCriteria,
        selectedCategoryIds: selectedSubcategoryIds,
        eAType: eAType);
  }
}
