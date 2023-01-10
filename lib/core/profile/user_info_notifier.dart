import 'package:flutter/cupertino.dart';
import 'package:othia/core/profile/settings/edit_profile.dart';
import 'package:othia/modules/models/shared_data_models.dart';

import '../../modules/models/user_info/user_info.dart';
import '../../utils/services/rest-api/rest_api_service.dart';

class UserInfoNotifier extends ChangeNotifier {
  late UserInfo _userInfo;
  late UserInfo _newUserInfo;

  set userInfo(UserInfo userInfo) {
    _userInfo = userInfo;
    _newUserInfo = userInfo;
  }

  UserInfo get userInfo => _userInfo;

  UserInfo get newUserInfo => _newUserInfo;

  void updateUserInfo({String? image, FieldType? profileField, dynamic value}) {
    String? profileName = null;
    String? profileEMail = null;
    Gender? gender = null;
    String? birthdate = null;

    switch (profileField) {
      case FieldType.birthdate:
        {
          birthdate = value;
        }
        break;
      case FieldType.gender:
        {
          gender = value;
        }
        break;
      case FieldType.name:
        {
          profileName = value;
        }
        break;
      case null:
        break;
    }

    _newUserInfo = UserInfo(
        userId: _newUserInfo.userId,
        profileName: profileName ?? _newUserInfo.profileName,
        profileEMail: profileEMail ?? _newUserInfo.profileEMail,
        profilePhoto: image ?? _newUserInfo.profilePhoto,
        activityIds: _newUserInfo.activityIds,
        pastEventIds: _newUserInfo.pastEventIds,
        upcomingEventIds: _newUserInfo.upcomingEventIds,
        gender: gender ?? _newUserInfo.gender,
        birthdate: birthdate ?? _newUserInfo.birthdate);
    _saveToBackend();
    notifyListeners();
  }

  void _saveToBackend() {
    //TODO
    RestService().savePrivateUserInfo(userInfo: _newUserInfo);
    return;
  }
}
