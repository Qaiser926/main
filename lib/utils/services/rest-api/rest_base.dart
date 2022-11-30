import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:othia/utils/services/rest-api/amplify/amp.dart';

Future<Object> get(RestOptions restOptions) async {
  final response = amplifyGet(restOptions);
  return response;
}

Future<Object> put(RestOptions restOptions) async {
  final response = await amplifyPut(restOptions);
  return response;
}

Future<Object> post(RestOptions restOptions) async {
  final response = amplifyPost(restOptions);
  return response;
}

Future<Object> delete(RestOptions restOptions) async {
  final response = amplifyDelete(restOptions);
  return response;
}

// Future<Object> signIn(String username, String password) async {
//   try {
//     final result = amplifySignIn(username, password);
//     return result;
//   } on AuthException catch (e) {
//     safePrint(e.message);
//     throw Exception("TODO");
//   }
// }
