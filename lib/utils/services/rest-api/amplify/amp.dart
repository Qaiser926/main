import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

Future<Object> amplifyGet(RestOptions restOptions) async {
  final restOperation = Amplify.API.get(restOptions: restOptions);
  final response = await restOperation.response;
  return response;
}

Future<Object> amplifyPut(RestOptions restOptions) async {
  final restOperation = Amplify.API.put(restOptions: restOptions);
  final response = await restOperation.response;
  return response;
}

Future<Object> amplifyPost(RestOptions restOptions) async {
  final restOperation = Amplify.API.post(restOptions: restOptions);
  final response = await restOperation.response;
  return response;
}

Future<void> deleteUser() async {
  await Amplify.Auth.deleteUser();
  print('Delete user succeeded');
}

Future<Object> amplifyDelete(RestOptions passedRestOptions) async {
  final restOperation = Amplify.API.delete(restOptions: passedRestOptions);
  final response = await restOperation.response;
  return response;
}

Future<void> signOutCurrentUser() async {
  try {
    await Amplify.Auth.signOut();
  } on AuthException catch (e) {
    print(e.message);
  }
}

Future<bool> amplifyIsUserSignedIn() async {
  final result = await Amplify.Auth.fetchAuthSession();
  return result.isSignedIn;
}

Future<AuthUser> getCurrentUser() async {
  final user = await Amplify.Auth.getCurrentUser();
  return user;
}

// Future<Object> amplifySignIn(String username, String password) async {
//   try {
//     final result = await Amplify.Auth.signIn(
//       username: username,
//       password: password,
//     );
//     return result;
//   } on AuthException catch (e) {
//     safePrint(e.message);
//     throw Exception();
//   }
// }

Future<void> amplifyUpdatePassword(
    {required String oldPassword, required String newPassword}) async {
  try {
    await Amplify.Auth.updatePassword(
        newPassword: newPassword, oldPassword: oldPassword);
  } on AmplifyException catch (e) {
    //TODO (intern)
    throw Exception(e);
  }
}

Future<void> amplifySignIn(
    {required String email, required String password}) async {
  //username is a phone number based on amplify requirements

  await Amplify.Auth.signIn(
    username: email,
    password: password,
  );
}

Future<void> amplifySignUp(
    {required String password, required String email}) async {
  //username is a phone number based on amplify requirements
  await Amplify.Auth.signUp(
    username: email,
    password: password,
  );
}

Future<void> amplifyConfirmSignUp(
    {required String phoneNumber, required String confirmationCode}) async {
  //username is a phone number based on amplify requirements
  await Amplify.Auth.confirmSignUp(
      username: phoneNumber, confirmationCode: confirmationCode);
}

Future<void> amplifyResendConfirmationCode({required String email}) async {
  try {
    //username is a phone number based on amplify requirements
    await Amplify.Auth.resendSignUpCode(username: email);
  } on AmplifyException catch (e) {
    //TODO (intern)
    throw Exception(e);
  }
}

Future<void> amplifyResetPassword({required String email}) async {
  //username is a phone number based on amplify requirements
  await Amplify.Auth.resetPassword(username: email);
}

Future<void> amplifyConfirmResetPassword(
    {required String email,
    required String newPassword,
    required String confirmationCode}) async {
  try {
    //username is a phone number based on amplify requirements
    await Amplify.Auth.confirmResetPassword(
        username: email,
        confirmationCode: confirmationCode,
        newPassword: newPassword);
  } on AmplifyException catch (e) {
    //TODO (intern)
    throw Exception(e);
  }
}

Future<String> getIdToken() async {
  final CognitoAuthSession user = await Amplify.Auth.fetchAuthSession(
          options: CognitoSessionOptions(getAWSCredentials: true))
      as CognitoAuthSession;
  String token = user.userPoolTokens!.idToken;
  return token;
}

Future<String> getUserId() async {
  try {
    final AuthUser user = await Amplify.Auth.getCurrentUser();
    return user.userId;
  } on AuthException catch (e) {
    //user should reinstall application
    throw e;
  }
}
