import 'package:othia/constants/app_constants.dart';

bool checkMinPasswordLength(String password) {
  if (password.length < OtherConstants.minPasswordLength) {
    return false;
  } else {
    return true;
  }
}

bool checkMaxPasswordLength(String password) {
  if (password.length > OtherConstants.maxPasswordLength) {
    return false;
  } else {
    return true;
  }
}
