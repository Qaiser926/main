import 'package:json_annotation/json_annotation.dart';
import 'package:othia/modules/models/shared_data_models.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  final String profileName;
  final String profileEmail;
  final String? profilePhoto;
  late final Gender? gender;
  late final DateTime? birthdate;
  final String? userId;

  final List<String?> upcomingEventIds;
  final List<String?> pastEventIds;
  final List<String?> activityIds;

  UserInfo(
      {required this.profileName,
      required this.profileEmail,
      required gender,
      required birthdate,
      required this.userId,
      this.profilePhoto,
      required this.activityIds,
      required this.pastEventIds,
      required this.upcomingEventIds}) {
    // the cases are needed since user info can be initialized via an API call or by a notifier
    birthdate is String
        ? this.birthdate = DateTime.parse(birthdate)
        : this.birthdate = birthdate;
    gender is String
        ? this.gender =
            Gender.values.firstWhere((e) => e.toString() == 'Gender.' + gender)
        : this.gender = gender;
  }

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
