// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eA_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummaryEventOrActivity _$SummaryEventOrActivityFromJson(
        Map<String, dynamic> json) =>
    SummaryEventOrActivity(
      time: Time.fromJson(json['time'] as Map<String, dynamic>),
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      title: json['title'] as String,
      id: json['id'] as String,
      categoryId: json['categoryId'] as String,
      prices: (json['prices'] as List<dynamic>?)
          ?.map((e) => Price.fromJson(e as Map<String, dynamic>))
          .toList(),
      photo: json['photo'] as String?,
      isOnline: json['isOnline'] as bool,
    );

Map<String, dynamic> _$SummaryEventOrActivityToJson(
        SummaryEventOrActivity instance) =>
    <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'categoryId': instance.categoryId,
      'photo': instance.photo,
      'prices': instance.prices,
      'isOnline': instance.isOnline,
      'time': instance.time,
      'location': instance.location,
    };
