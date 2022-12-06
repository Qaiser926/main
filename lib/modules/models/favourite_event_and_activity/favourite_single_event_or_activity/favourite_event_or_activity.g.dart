// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_event_or_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavouriteEventOrActivity _$FavouriteEventOrActivityFromJson(
        Map<String, dynamic> json) =>
    FavouriteEventOrActivity(
      photo: json['photo'] as String?,
      title: json['title'] as String,
      id: json['id'] as String,
      startTimeUtc: json['startTimeUtc'] as String?,
      openingTimeCode: $enumDecodeNullable(
          _$OpeningTimeCodeEnumMap, json['openingTimeCode']),
      categoryId: json['categoryId'] as String,
      visible: json['visible'] as bool?,
    );

Map<String, dynamic> _$FavouriteEventOrActivityToJson(
        FavouriteEventOrActivity instance) =>
    <String, dynamic>{
      'photo': instance.photo,
      'title': instance.title,
      'id': instance.id,
      'startTimeUtc': instance.startTimeUtc,
      'openingTimeCode': _$OpeningTimeCodeEnumMap[instance.openingTimeCode],
      'categoryId': instance.categoryId,
      'visible': instance.visible,
    };

const _$OpeningTimeCodeEnumMap = {
  OpeningTimeCode.open: 'open',
  OpeningTimeCode.closed: 'closed',
  OpeningTimeCode.openSoon: 'openSoon',
  OpeningTimeCode.closedSoon: 'closedSoon',
};
