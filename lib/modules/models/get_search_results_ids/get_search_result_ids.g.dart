// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_search_result_ids.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResultIds _$SearchResultIdsFromJson(Map<String, dynamic> json) =>
    SearchResultIds(
      searchResultIds: (json['searchResultIds'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String?).toList()),
      ),
    );

Map<String, dynamic> _$SearchResultIdsToJson(SearchResultIds instance) =>
    <String, dynamic>{
      'searchResultIds': instance.searchResultIds,
    };
