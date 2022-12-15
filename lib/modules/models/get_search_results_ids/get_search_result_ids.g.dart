// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_search_result_ids.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResultsIds _$SearchResultsIdsFromJson(Map<String, dynamic> json) =>
    SearchResultsIds(
      searchResultIds: (json['searchResultIds'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String?).toList()),
      ),
    );

Map<String, dynamic> _$SearchResultsIdsToJson(SearchResultsIds instance) =>
    <String, dynamic>{
      'searchResultIds': instance.searchResultIds,
    };
