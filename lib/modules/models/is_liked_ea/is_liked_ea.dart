import 'package:json_annotation/json_annotation.dart';

part 'is_liked_ea.g.dart';

@JsonSerializable()
class LikedEA {
  final bool isLikedByUser;

  LikedEA({required this.isLikedByUser});

  factory LikedEA.fromJson(Map<String, dynamic> json) =>
      _$LikedEAFromJson(json);
}
