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

Future<Object> amplifyDelete(RestOptions restOptions) async {
  final restOperation = Amplify.API.delete(restOptions: restOptions);
  final response = await restOperation.response;
  return response;
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

// Future<String> amplifyGetIdToken() async {
//   final CognitoAuthSession user = await Amplify.Auth.fetchAuthSession(
//           options: CognitoSessionOptions(getAWSCredentials: true))
//       as CognitoAuthSession;
//   String token = user.userPoolTokens!.idToken;
//   return token;
// }
