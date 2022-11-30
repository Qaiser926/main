
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'favourite_event_and_activity.freezed.dart';
part 'favourite_event_and_activity.g.dart';

@freezed
class FavouriteEventAndActivity with _$FavouriteEventAndActivity {
  @JsonSerializable(explicitToJson: true)
  const factory FavouriteEventAndActivity({
    required final List<dynamic> futureEvents,
    required final List<dynamic> pastEvents,
    required final List<dynamic> openActivities,
    required final List<dynamic> closedActivities,


  }) = _FavouriteEventAndActivity;

  factory FavouriteEventAndActivity.fromJson(Map<String, dynamic> json)
  => _$FavouriteEventAndActivityFromJson(json);
}
