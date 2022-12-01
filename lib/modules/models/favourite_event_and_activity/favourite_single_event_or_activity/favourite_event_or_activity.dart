
import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'favourite_event_or_activity.freezed.dart';
part 'favourite_event_or_activity.g.dart';

enum OpeningTimeCode {
  open,
  closed,
  openedSoon,
  closedSoon,
}

@freezed
class FavouriteEventOrActivity with _$FavouriteEventOrActivity {
  @JsonSerializable(explicitToJson: true)
  const factory FavouriteEventOrActivity({
    final String? photo,
    required final String title,
    required final String id,
    final String? startTimeUtc,
    final OpeningTimeCode? openingTimeCode,
    required final String categoryId,


  }) = _FavouriteEventOrActivity;

  factory FavouriteEventOrActivity.fromJson(Map<String, dynamic> json)
  => _$FavouriteEventOrActivityFromJson(json);
}
