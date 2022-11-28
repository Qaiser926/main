import 'package:uuid/uuid.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'detailed_event.freezed.dart';

@freezed
class DetailedEvent with _$DetailedEvent {
  const factory DetailedEvent({
    required final Uuid id,
    required final String title,
    required final String locationTitle,
    required final Uuid locationId,
    required final double price,
  }) = _DetailedEvent;
}
