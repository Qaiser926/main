// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_data_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      isOnline: json['isOnline'] as bool,
      locationId: json['locationId'] as String?,
      streetNumber: json['streetNumber'] as String?,
      street: json['street'] as String?,
      city: json['city'] as String?,
      locationTitle: json['locationTitle'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'isOnline': instance.isOnline,
      'streetNumber': instance.streetNumber,
      'street': instance.street,
      'city': instance.city,
      'locationTitle': instance.locationTitle,
      'locationId': instance.locationId,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };

Time _$TimeFromJson(Map<String, dynamic> json) => Time(
      startTimeUtc: json['startTimeUtc'] as String?,
      openingTimeCode: $enumDecodeNullable(
          _$OpeningTimeCodeEnumMap, json['openingTimeCode']),
      endTimeUtc: json['endTimeUtc'] as String?,
      openingTime: json['openingTime'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$TimeToJson(Time instance) => <String, dynamic>{
      'startTimeUtc': instance.startTimeUtc,
      'endTimeUtc': instance.endTimeUtc,
      'openingTimeCode': _$OpeningTimeCodeEnumMap[instance.openingTimeCode],
      'openingTime': instance.openingTime,
    };

const _$OpeningTimeCodeEnumMap = {
  OpeningTimeCode.open: 'open',
  OpeningTimeCode.closed: 'closed',
  OpeningTimeCode.openSoon: 'openSoon',
  OpeningTimeCode.closedSoon: 'closedSoon',
};

Coordinates _$CoordinatesFromJson(Map<String, dynamic> json) => Coordinates(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$CoordinatesToJson(Coordinates instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
