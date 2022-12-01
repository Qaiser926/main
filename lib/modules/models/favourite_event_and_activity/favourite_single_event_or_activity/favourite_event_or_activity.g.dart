// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_event_or_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FavouriteEventOrActivity _$$_FavouriteEventOrActivityFromJson(
        Map<String, dynamic> json) =>
    _$_FavouriteEventOrActivity(
      photo: json['photo'] as String?,
      title: json['title'] as String,
      id: json['id'] as String,
      startTimeUtc: json['startTimeUtc'] as String?,
      openingTimeCode: $enumDecodeNullable(
          _$OpeningTimeCodeEnumMap, json['openingTimeCode']),
      categoryId: json['categoryId'] as String,
    );

Map<String, dynamic> _$$_FavouriteEventOrActivityToJson(
        _$_FavouriteEventOrActivity instance) =>
    <String, dynamic>{
      'photo': instance.photo,
      'title': instance.title,
      'id': instance.id,
      'startTimeUtc': instance.startTimeUtc,
      'openingTimeCode': _$OpeningTimeCodeEnumMap[instance.openingTimeCode],
      'categoryId': instance.categoryId,
    };

const _$OpeningTimeCodeEnumMap = {
  OpeningTimeCode.open: 'open',
  OpeningTimeCode.closed: 'closed',
  OpeningTimeCode.openedSoon: 'openedSoon',
  OpeningTimeCode.closedSoon: 'closedSoon',
};
