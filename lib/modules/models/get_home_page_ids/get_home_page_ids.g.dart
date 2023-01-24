// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_home_page_ids.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomePageIds _$HomePageIdsFromJson(Map<String, dynamic> json) => HomePageIds(
      compingUpEvents: (json['compingUpEvents'] as List<dynamic>)
          .map((e) => e as String?)
          .toList(),
      popularEvents: (json['popularEvents'] as List<dynamic>)
          .map((e) => e as String?)
          .toList(),
      popularActivities: (json['popularActivities'] as List<dynamic>)
          .map((e) => e as String?)
          .toList(),
      openActivities: (json['openActivities'] as List<dynamic>)
          .map((e) => e as String?)
          .toList(),
      universityEvents: (json['universityEvents'] as List<dynamic>)
          .map((e) => e as String?)
          .toList(),
    );

Map<String, dynamic> _$HomePageIdsToJson(HomePageIds instance) =>
    <String, dynamic>{
      'compingUpEvents': instance.compingUpEvents,
      'popularEvents': instance.popularEvents,
      'popularActivities': instance.popularActivities,
      'openActivities': instance.openActivities,
      'universityEvents': instance.universityEvents,
    };
