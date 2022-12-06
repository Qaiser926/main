import 'dart:async';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:othia/utils/services/rest-api/rest_base.dart';

class RestService {
  static final RestService _singleton = RestService._internal();

  factory RestService() {
    return _singleton;
  }

  RestService._internal();

  Future<Object> fetchTenEvents() async {
    RestOptions restOptions = const RestOptions(path: 'tenevnets');
    final result = await get(restOptions);
    return result;
  }

  Future<Object> fetchEventOrActivityDetails({required String eventOrActivityId}) async {
    print('fetching event details with id $eventOrActivityId');

    RestOptions restOptions =
        RestOptions(path: '/events/$eventOrActivityId', headers: {'auth': ''});
    final result = await get(restOptions);
    return result;
  }

  Future<Object> fetchFavouriteEventsAndActivities() async {
    print('fetching event details with id');

    RestOptions restOptions = RestOptions(
        path: '/favouriteeventsandactivities/', headers: {'auth': ''});
    final result = await get(restOptions);
    return result;
  }

  Future<Object> removeFavouriteEventOrActivity({required id}) async {
    print('removing favourite event or activity with id: $id');

    RestOptions restOptions =
        RestOptions(path: '/removeFavourite-dev/$id', headers: {'auth': ''});
    final result = await get(restOptions);
    return result;
  }

  Future<Object> getEAIdsForCategory({required categoryId}) async {
    print('requesting ids for: $categoryId');

    RestOptions restOptions =
    RestOptions(path: '/getEAIdsForCategory-dev/$categoryId', headers: {'auth': ''});
    final result = await get(restOptions);
    return result;
  }
}
