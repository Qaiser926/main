import 'package:flutter/cupertino.dart';

import '../../modules/models/user_info/user_info.dart';

class UserInfoNotifier extends ChangeNotifier {
  late UserInfo _userInfo;
  late UserInfo _newUserInfo;

  set userInfo(UserInfo userInfo) {
    _userInfo = userInfo;
    _newUserInfo = userInfo;
  }

  UserInfo get userInfo => _userInfo;

  UserInfo get newUserInfo => _newUserInfo;

  void updateUserInfo(
      {String? image,
      String? profileName,
      String? profileEMail,
      String? gender,
      String? birthdate}) {
    _newUserInfo = UserInfo(
        profileName: profileName ?? _newUserInfo.profileName,
        profileEMail: profileEMail ?? _newUserInfo.profileEMail,
        profilePhoto: image ?? _newUserInfo.profilePhoto,
        activityIds: _newUserInfo.activityIds,
        pastEventIds: _newUserInfo.pastEventIds,
        upcomingEventIds: _newUserInfo.upcomingEventIds,
        gender: gender ?? _newUserInfo.gender,
        birthdate: birthdate ?? _newUserInfo.birthdate);
    notifyListeners();
  }

  void save() {
    _userInfo = _newUserInfo;
    notifyListeners();
  }

  void _updateUserInfo() {}
}
