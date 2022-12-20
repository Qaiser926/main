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

Future<bool> isUserSignedIn() async {
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
//     throw Exception("TODO");
//   }
// }

Future<String> getIdToken() async {
  final CognitoAuthSession user = await Amplify.Auth.fetchAuthSession(
          options: CognitoSessionOptions(getAWSCredentials: true))
      as CognitoAuthSession;
  String token = user.userPoolTokens!.idToken;
  return token;
}

Future<String> getUserId() async {
  final AuthUser user = await Amplify.Auth.getCurrentUser();
  return user.userId;
}
