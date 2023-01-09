import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/utils/services/rest-api/rest_api_utils.dart';
import 'package:othia/utils/services/rest-api/rest_base.dart';

import '../../../modules/models/user_info/user_info.dart';
import 'amplify/amp.dart';

class RestService {
  static final RestService _singleton = RestService._internal();

  factory RestService() {
    return _singleton;
  }

  RestService._internal();

  Future<Object> fetchEventOrActivityDetails(
      {required String eventOrActivityId}) async {
    print('fetching event details with id $eventOrActivityId');

    RestOptions restOptions = RestOptions(
        path: '/${OthiaConstants.eventDetailPath}/$eventOrActivityId');
    final result = await get(restOptions);
    return result;
  }

  Future<Object> fetchFavouriteEventsAndActivities() async {
    print('fetching event details with id');
    //TODO make user specific
    RestOptions restOptions =
        RestOptions(path: '/favouriteeventsandactivities/');
    final result = await get(restOptions);
    return result;
  }

  Future<Object> removeFavouriteEventOrActivity({required eAId}) async {
    print('removing favourite event or activity with id: $eAId');
    String token = await getIdToken();
    RestOptions restOptions = RestOptions(
        path: '/removeFavourite-dev/$eAId', headers: {'token': '${token}'});
    final result = await delete(restOptions);
    return result;
  }

  Future<Object> addFavouriteEventOrActivity({required eAId}) async {
    print('removing favourite event or activity with id: $eAId');
    String token = await getIdToken();

    // TODO login
    RestOptions restOptions = RestOptions(
        path: '/addLikedEA-dev/$eAId', headers: {'token': '${token}'});
    final result = await put(restOptions);
    return result;
  }

  Future<Object> isEALikedByUser({required eAId}) async {
    print('removing favourite event or activity with id: $eAId');
    String token = await getIdToken();

    String userId = await getUserId();
    // TODO login
    RestOptions restOptions = RestOptions(
        path: '/isEALikedByUser-dev/$eAId', headers: {'token': '${token}'});
    final result = await get(restOptions);
    return result;
  }

  Future<Object> getEAIdsForCategory({required categoryId}) async {
    print('requesting ids for category id: $categoryId');

    RestOptions restOptions =
        RestOptions(path: '/getEAIdsForCategory-dev/$categoryId');
    final result = await get(restOptions);
    return result;
  }

  Future<Object> getEAIdsForEventSeries({required eventSeriesId}) async {
    print('requesting ids for eventseries id: $eventSeriesId');

    RestOptions restOptions =
        RestOptions(path: '/getEAIdsForEventSeries-dev/$eventSeriesId');
    final result = await get(restOptions);
    return result;
  }

  Future<Object> getEAIdsForLocation({required locationId}) async {
    print('requesting ids for location id: $locationId');

    RestOptions restOptions =
        RestOptions(path: '/getEAIdsForLocation-dev/$locationId');
    final result = await get(restOptions);
    return result;
  }

  Future<Object> getEASummary({required id}) async {
    print('requesting summary for: $id');

    RestOptions restOptions = RestOptions(path: '/getEASummary-dev/$id');
    final result = await get(restOptions);
    return result;
  }

  Future<Object> getSearchResultIds({required searchQuery}) async {
    print('requesting ids for: ');
    //
    //TODO define API call for several query parameters
    RestOptions restOptions = RestOptions(path: '/getSearchResultIds-dev/');
    final result = await get(restOptions);
    return result;
  }

  Future<Object> getMapResultIds({required searchQuery}) async {
    print('requesting Map result ids');
    //TODO define API call for several query parameters
    RestOptions restOptions = RestOptions(path: '/getMapResultIds-dev/');
    final result = await get(restOptions);
    return result;
  }

  Future<Object> getPrivateUserInfo({required userId}) async {
    print('requesting user info for for: $userId');
    RestOptions restOptions = RestOptions(path: '/getUserInfo-dev/');
    final result = await get(restOptions);
    return result;
  }

  Future<Object> savePrivateUserInfo({required UserInfo userInfo}) async {
    String token = await getIdToken();
    RestOptions restOptions = RestOptions(
        path: '/saveprivateuserinformation',
        headers: {'token': '${token}'},
        body: transformClassToBody(userInfo));
    final result = await post(restOptions);
    return result;
  }

  Future<Object> getHomePageIds() async {
    print('requesting home page ids');
    RestOptions restOptions = RestOptions(path: '/getHomePageIds-dev/');
    final result = await get(restOptions);
    return result;
  }

  // Future<Object> resetPassword() async {
  //   RestOptions restOptions = RestOptions(path: '/getHomePageIds-dev/');
  //   final result = await get(restOptions);
  //   return result;
  // }

  Future<void> updatePassword(
      {required String oldPassword, required String newPassword}) async {
    final result = await amplifyUpdatePassword(
        newPassword: newPassword, oldPassword: oldPassword);
  }

  Future<Object> deleteAccount(String userId) async {
    String token = await getIdToken();
    RestOptions restOptions = RestOptions(
        path: '/deleteaccount/$userId', headers: {'token': '${token}'});
    final result = await delete(restOptions);
    return result;
  }

  void logout() async {
    await signOutCurrentUser();
    return;
  }

  Future<void> signIn(
      {required String username, required String password}) async {
    final result = await amplifySignIn(password: password, username: username);
  }

  Future<bool> isSignedIn() async {
    final result = await amplifyIsUserSignedIn();
    return result;
  }
}
