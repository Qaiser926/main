import 'dart:async';
import 'package:othia/utils/services/rest-api/rest_base.dart';

import 'package:othia/utils/services/rest-api/custom_rest_options.dart';

class RestService {
  static final RestService _singleton = RestService._internal();

  factory RestService() {
    return _singleton;
  }

  RestService._internal();

  Future<Object> fetchTenEvents() async {
    CustomRestOptions restOptions = const CustomRestOptions(path: 'tenevnets');
    final result = await get(restOptions);
    return result;
  }

  Future<Object> fetchEventDetails(String eventId) async {
    print('fetching event details');
    CustomRestOptions restOptions = const CustomRestOptions(path: 'details');
    final result = await get(restOptions);
    return result;
  }
}
