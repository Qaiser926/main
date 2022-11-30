import 'package:uuid/uuid.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'detailed_event.freezed.dart';
part 'detailed_event.g.dart';
@freezed
class DetailedEvent with _$DetailedEvent {
  @JsonSerializable(explicitToJson: true)
  const factory DetailedEvent({
    required final String id,
    required final String title,
    required final String description,
    required final String locationTitle,
    required final String locationId,
    required final double price,
    required final double latitude,
    required final double longitude
  }) = _DetailedEvent;

  factory DetailedEvent.fromJson(Map<String, dynamic> json)
  => _$DetailedEventFromJson(json);
}
