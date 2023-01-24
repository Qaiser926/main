// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchQuery _$SearchQueryFromJson(Map<String, dynamic> json) => SearchQuery(
      startDateUtc: DateTime.parse(json['startDate'] as String),
      endDateUtc: DateTime.parse(json['endDate'] as String),
      minPrice: (json['minPrice'] as num).toDouble(),
      maxPrice: json['maxPrice'],
      sortCriteria:
          $enumDecodeNullable(_$SortCriteriaEnumMap, json['sortCriteria']),
      selectedCategoryIds: (json['selectedCategoryIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      eAType: $enumDecodeNullable(_$EATypeEnumMap, json['eAType']),
    );

Map<String, dynamic> _$SearchQueryToJson(SearchQuery instance) =>
    <String, dynamic>{
      'startDate': instance.startDateUtc.toIso8601String(),
      'endDate': instance.endDateUtc.toIso8601String(),
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
      'sortCriteria': _$SortCriteriaEnumMap[instance.sortCriteria],
      'eAType': _$EATypeEnumMap[instance.eAType],
      'selectedCategoryIds': instance.selectedCategoryIds,
    };

const _$SortCriteriaEnumMap = {
  SortCriteria.price: 'price',
  SortCriteria.date: 'date',
  SortCriteria.popularity: 'popularity',
};

const _$EATypeEnumMap = {
  EAType.events: 'events',
  EAType.activities: 'activities',
  EAType.eventsActivites: 'eventsActivites',
};
