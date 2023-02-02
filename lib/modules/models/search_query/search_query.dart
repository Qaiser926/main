import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/constants/categories.dart';
import 'package:othia/widgets/filter_related/sort_filter.dart';
import 'package:othia/widgets/filter_related/type_filter.dart';

part 'search_query.g.dart';

@JsonSerializable()
class SearchQuery {
  final DateTime startDateUtc;
  final DateTime endDateUtc;
  late DateTime userTime;
  final double minPrice;
  late double maxPrice;
  final SortCriteria? sortCriteria;
  final EAType? eAType;
  late List<String> selectedCategoryIds;

  SearchQuery(
      {required this.startDateUtc,
      required this.endDateUtc,
      required this.minPrice,
      required maxPrice,
      required this.sortCriteria,
      required List<String> selectedCategoryIds,
      required this.eAType}) {
    this.userTime = DateTime.now();
    if (maxPrice == DataConstants.PriceRangeEnd) {
      this.maxPrice = 1000000;
    } else {
      this.maxPrice = maxPrice;
    }
    if (selectedCategoryIds.isEmpty) {
      List<String> tempCategories = [];
      categoryIdToSubcategoryIds.forEach((k, v) => tempCategories.addAll(v));
      this.selectedCategoryIds = tempCategories;
    } else {
      this.selectedCategoryIds = selectedCategoryIds;
    }
  }

  factory SearchQuery.fromJson(Map<String, dynamic> json) =>
      _$SearchQueryFromJson(json);

  Map<String, dynamic> toJson() => _$SearchQueryToJson(this);
}
