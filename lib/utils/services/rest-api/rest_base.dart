import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:othia/utils/services/rest-api/amplify/amp.dart';
import 'package:othia/utils/services/rest-api/custom_rest_options.dart';

Future<Object> get(CustomRestOptions restOptions) async {
  final response = amplifyGet(restOptions as RestOptions);
  return response;
}

Future<Object> put(CustomRestOptions restOptions) async {
  final response = await amplifyPut(restOptions as RestOptions);
  return response;
}

Future<Object> post(CustomRestOptions restOptions) async {
  final response = amplifyPost(restOptions as RestOptions);
  return response;
}

Future<Object> delete(CustomRestOptions restOptions) async {
  final response = amplifyDelete(restOptions as RestOptions);
  return response;
}

Future<Object> signIn(String username, String password) async {
  try {
    final result = amplifySignIn(username, password);
    return result;
  } on AuthException catch (e) {
    safePrint(e.message);
    throw Exception("TODO");
  }
}
