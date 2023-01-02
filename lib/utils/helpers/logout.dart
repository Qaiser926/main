import '../services/rest-api/rest_api_service.dart';

Future<Object?> logout() async {
  RestService().logout();
  return null;
}
