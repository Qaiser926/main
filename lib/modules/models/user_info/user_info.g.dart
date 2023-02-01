// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      profileName: json['profileName'] as String,
      profileEmail: json['profileEmail'] as String,
      gender: json['gender'],
      birthdate: json['birthdate'],
      userId: json['userId'] as String?,
      profilePhoto: json['profilePhoto'] as String?,
      activityIds: (json['activityIds'] as List<dynamic>)
          .map((e) => e as String?)
          .toList(),
      pastEventIds: (json['pastEventIds'] as List<dynamic>)
          .map((e) => e as String?)
          .toList(),
      upcomingEventIds: (json['upcomingEventIds'] as List<dynamic>)
          .map((e) => e as String?)
          .toList(),
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'profileName': instance.profileName,
      'profileEmail': instance.profileEmail,
      'profilePhoto': instance.profilePhoto,
      'gender': _$GenderEnumMap[instance.gender],
      'birthdate': instance.birthdate?.toIso8601String(),
      'userId': instance.userId,
      'upcomingEventIds': instance.upcomingEventIds,
      'pastEventIds': instance.pastEventIds,
      'activityIds': instance.activityIds,
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.diverse: 'diverse',
};
