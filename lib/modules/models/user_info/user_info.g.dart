// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      profileName: json['profileName'] as String,
      profileEMail: json['profileEMail'] as String,
      gender: json['gender'] as String?,
      birthdate: json['birthdate'] as String?,
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
      'profileEMail': instance.profileEMail,
      'profilePhoto': instance.profilePhoto,
      'gender': instance.gender,
      'birthdate': instance.birthdate,
      'userId': instance.userId,
      'upcomingEventIds': instance.upcomingEventIds,
      'pastEventIds': instance.pastEventIds,
      'activityIds': instance.activityIds,
    };
