import 'package:json_annotation/json_annotation.dart';

part 'get_search_result_ids.g.dart';

@JsonSerializable()
class SearchResultIds {
  Map<String, List<String?>> searchResultIds;

  SearchResultIds({
    required this.searchResultIds,
  });

  factory SearchResultIds.fromJson(Map<String, dynamic> json) =>
      _$SearchResultIdsFromJson(json);
}
