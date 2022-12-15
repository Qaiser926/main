import 'package:json_annotation/json_annotation.dart';

part 'get_search_result_ids.g.dart';

@JsonSerializable()
class SearchResultsIds {
  Map<String, List<String?>> searchResultIds;

  SearchResultsIds({
    required this.searchResultIds,
  });

  factory SearchResultsIds.fromJson(Map<String, dynamic> json) =>
      _$SearchResultsIdsFromJson(json);
}
