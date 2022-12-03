import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../shared_data_models.dart';

part 'favourite_event_or_activity.freezed.dart';

part 'favourite_event_or_activity.g.dart';



@unfreezed
class FavouriteEventOrActivity with _$FavouriteEventOrActivity {
  // @JsonSerializable(explicitToJson: true)
  factory FavouriteEventOrActivity({
    final String? photo,
    required final String title,
    required final String id,
    final String? startTimeUtc,
    final OpeningTimeCode? openingTimeCode,
    required final String categoryId,
    @Default(true) bool? visible,
  }) = _FavouriteEventOrActivity;

  factory FavouriteEventOrActivity.fromJson(Map<String, dynamic> json) =>
      _$FavouriteEventOrActivityFromJson(json);
}
