import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  final String profileName;
  final String profileEMail;
  final String? profilePhoto;
  final String gender;
  final String birthdate;

  final List<String?> upcomingEventIds;
  final List<String?> pastEventIds;
  final List<String?> activityIds;

  UserInfo(
      {required this.profileName,
      required this.profileEMail,
      required this.gender,
      required this.birthdate,
      this.profilePhoto,
      required this.activityIds,
      required this.pastEventIds,
      required this.upcomingEventIds});

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
}
