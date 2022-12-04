// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detailed_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailedEventOrActivity _$DetailedEventOrActivityFromJson(
        Map<String, dynamic> json) =>
    DetailedEventOrActivity(
      title: json['title'] as String,
      id: json['id'] as String,
      categoryId: json['categoryId'] as String,
      ownerId: json['ownerId'] as String,
      eventSeriesId: json['eventSeriesId'] as String?,
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      moreInformationUrl: json['moreInformationUrl'] as String?,
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']),
      startTimeUtc: json['startTimeUtc'] as String?,
      openingTimeCode: $enumDecodeNullable(
          _$OpeningTimeCodeEnumMap, json['openingTimeCode']),
      openingTime: json['openingTime'] as Map<String, dynamic>?,
      isOnline: json['isOnline'] as bool,
      locationTitle: json['locationTitle'] as String?,
      locationId: json['locationId'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DetailedEventOrActivityToJson(
        DetailedEventOrActivity instance) =>
    <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'categoryId': instance.categoryId,
      'longitude': instance.longitude,
      'ownerId': instance.ownerId,
      'photos': instance.photos,
      'description': instance.description,
      'eventSeriesId': instance.eventSeriesId,
      'price': instance.price,
      'moreInformationUrl': instance.moreInformationUrl,
      'startTimeUtc': instance.startTimeUtc,
      'status': _$StatusEnumMap[instance.status],
      'openingTimeCode': _$OpeningTimeCodeEnumMap[instance.openingTimeCode],
      'openingTime': instance.openingTime,
      'latitude': instance.latitude,
      'isOnline': instance.isOnline,
      'locationTitle': instance.locationTitle,
      'locationId': instance.locationId,
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

const _$OpeningTimeCodeEnumMap = {
  OpeningTimeCode.open: 'open',
  OpeningTimeCode.closed: 'closed',
  OpeningTimeCode.openSoon: 'openSoon',
  OpeningTimeCode.closedSoon: 'closedSoon',
};
