// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_data_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      label: json['label'] as String?,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'label': instance.label,
      'price': instance.price,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      isOnline: json['isOnline'] as bool?,
      locationId: json['locationId'] as String?,
      streetNumber: json['streetNumber'] as String?,
      street: json['street'] as String?,
      city: json['city'] as String?,
      locationTitle: json['locationTitle'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      postalCode: json['postalCode'] as String?,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'isOnline': instance.isOnline,
      'streetNumber': instance.streetNumber,
      'street': instance.street,
      'city': instance.city,
      'locationTitle': instance.locationTitle,
      'locationId': instance.locationId,
      'postalCode': instance.postalCode,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };

Time _$TimeFromJson(Map<String, dynamic> json) => Time(
      startTimeUtc: json['startTimeUtc'] as String?,
      openingTimeCode: $enumDecodeNullable(
          _$OpeningTimeCodeEnumMap, json['openingTimeCode']),
      endTimeUtc: json['endTimeUtc'] as String?,
      openingTime: (json['openingTime'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>?)
                ?.map((e) => (e as List<dynamic>?)
                    ?.map((e) => (e as num?)?.toDouble())
                    .toList())
                .toList()),
      ),
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
  OpeningTimeCode.unknown: 'unknown',
};

SearchEnhancement _$SearchEnhancementFromJson(Map<String, dynamic> json) =>
    SearchEnhancement(
      cognitiveLevel: json['cognitiveLevel'] as int?,
      physicalLevel: json['physicalLevel'] as int?,
      socialLevel: json['socialLevel'] as int?,
      singlePersonEligibility: json['singlePersonEligibility'] as int?,
      coupleEligibility: json['coupleEligibility'] as int?,
      friendGroupEligibility: json['friendGroupEligibility'] as int?,
      professionalEligibility: json['professionalEligibility'] as int?,
    );

Map<String, dynamic> _$SearchEnhancementToJson(SearchEnhancement instance) =>
    <String, dynamic>{
      'cognitiveLevel': instance.cognitiveLevel,
      'physicalLevel': instance.physicalLevel,
      'socialLevel': instance.socialLevel,
      'singlePersonEligibility': instance.singlePersonEligibility,
      'coupleEligibility': instance.coupleEligibility,
      'friendGroupEligibility': instance.friendGroupEligibility,
      'professionalEligibility': instance.professionalEligibility,
    };
