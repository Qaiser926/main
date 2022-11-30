// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detailed_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DetailedEvent _$$_DetailedEventFromJson(Map<String, dynamic> json) =>
    _$_DetailedEvent(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      locationTitle: json['locationTitle'] as String,
      locationId: json['locationId'] as String,
      price: (json['price'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$$_DetailedEventToJson(_$_DetailedEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'locationTitle': instance.locationTitle,
      'locationId': instance.locationId,
      'price': instance.price,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
