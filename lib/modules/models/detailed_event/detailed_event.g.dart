// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detailed_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailedEventOrActivity _$DetailedEventOrActivityFromJson(
        Map<String, dynamic> json) =>
    DetailedEventOrActivity(
      time: Time.fromJson(json['time'] as Map<String, dynamic>),
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      showOrganizer: json['showOrganizer'] as bool?,
      title: json['title'] as String?,
      id: json['id'] as String?,
      isPublic: json['isPublic'] as bool?,
      categoryId: json['categoryId'] as String?,
      ownerId: json['ownerId'] as String?,
      searchEnhancement: json['searchEnhancement'] == null
          ? null
          : SearchEnhancement.fromJson(
              json['searchEnhancement'] as Map<String, dynamic>),
      eventSeriesId: json['eventSeriesId'] as String?,
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      description: json['description'] as String?,
      prices: (json['prices'] as List<dynamic>?)
          ?.map((e) => Price.fromJson(e as Map<String, dynamic>))
          .toList(),
      ticketUrl: json['ticketUrl'] as String?,
      websiteUrl: json['websiteUrl'] as String?,
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']),
      isOnline: json['isOnline'] as bool?,
      htmlAttributions: json['htmlAttributions'] as String?,
    );

Map<String, dynamic> _$DetailedEventOrActivityToJson(
        DetailedEventOrActivity instance) =>
    <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'categoryId': instance.categoryId,
      'ownerId': instance.ownerId,
      'photos': instance.photos,
      'description': instance.description,
      'eventSeriesId': instance.eventSeriesId,
      'prices': instance.prices,
      'ticketUrl': instance.ticketUrl,
      'websiteUrl': instance.websiteUrl,
      'status': _$StatusEnumMap[instance.status],
      'isOnline': instance.isOnline,
      'time': instance.time,
      'location': instance.location,
      'searchEnhancement': instance.searchEnhancement,
      'isPublic': instance.isPublic,
      'showOrganizer': instance.showOrganizer,
      'htmlAttributions': instance.htmlAttributions,
    };

const _$StatusEnumMap = {
  Status.PUBLIC: 'PUBLIC',
  Status.PRIVATE: 'PRIVATE',
  Status.DELETED: 'DELETED',
  Status.DRAFT: 'DRAFT',
  Status.LIVE: 'LIVE',
  Status.STARTED: 'STARTED',
  Status.ENDED: 'ENDED',
  Status.COMPLETED: 'COMPLETED',
  Status.CANCELED: 'CANCELED',
  Status.SOLDOUT: 'SOLDOUT',
};
