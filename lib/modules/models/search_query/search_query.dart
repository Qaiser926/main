import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/widgets/filter_related/sort_filter.dart';
import 'package:othia/widgets/filter_related/type_filter.dart';

part 'search_query.g.dart';

@JsonSerializable()
class SearchQuery {
  final DateTime startDate;
  final DateTime endDate;
  final double minPrice;
  late double maxPrice;
  final SortCriteria? sortCriteria;
  final EAType? eAType;
  final List<String> selectedCategoryIds;

  SearchQuery(
      {required this.startDate,
      required this.endDate,
      required this.minPrice,
      required maxPrice,
      required this.sortCriteria,
      required this.selectedCategoryIds,
      required this.eAType}) {
    if (maxPrice == DataConstants.PriceRangeEnd) {
      this.maxPrice = 1000000;
    } else {
      this.maxPrice = maxPrice;
    }
  }

  factory SearchQuery.fromJson(Map<String, dynamic> json) =>
      _$SearchQueryFromJson(json);

  Map<String, dynamic> toJson() => _$SearchQueryToJson(this);
}
