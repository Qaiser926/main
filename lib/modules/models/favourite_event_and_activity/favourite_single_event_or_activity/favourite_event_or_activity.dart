import 'dart:ui';

// import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
// part 'favourite_event_or_activity.freezed.dart';

part 'favourite_event_or_activity.g.dart';

enum OpeningTimeCode {
  open,
  closed,
  openSoon,
  closedSoon,
}

@JsonSerializable()
class FavouriteEventOrActivity {
  String? photo;
  String title;
  String id;
  String? startTimeUtc;
  OpeningTimeCode? openingTimeCode;
  String categoryId;
  bool? visible;

  FavouriteEventOrActivity({
    final String? this.photo,
    required final String this.title,
    required final String this.id,
    final String? this.startTimeUtc,
    final OpeningTimeCode? this.openingTimeCode,
    required final String this.categoryId,
    bool? this.visible,
  });

  factory FavouriteEventOrActivity.fromJson(Map<String, dynamic> json) =>
      _$FavouriteEventOrActivityFromJson(json);
}
