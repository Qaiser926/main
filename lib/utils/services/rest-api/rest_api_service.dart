import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:intl/intl.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/core/add/add_exclusives/help_functions.dart';
import 'package:othia/modules/models/detailed_event/detailed_event.dart';
import 'package:othia/modules/models/search_query/search_query.dart';
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
        path: '/${APIConstants.eventDetailPath}/$eventOrActivityId');
    final result = await get(restOptions);
    return result;
  }

  Future<Object> getEASummary({required id}) async {
    print('requesting summary for: $id');
    if (id == 1) {
      print(1);
    }
    RestOptions restOptions =
        RestOptions(path: '/${APIConstants.getEASummary}/$id');
    final result = await get(restOptions);
    return result;
  }

  Future<Object> fetchFavouriteEventsAndActivities() async {
    print('fetching event details with id');
    //TODO (intern) make user specific
    RestOptions restOptions = RestOptions(
        path: '/${APIConstants.fetchFavouriteEventsAndActivities}/');
    final result = await get(restOptions);
    return result;
  }

  Future<Object> removeFavouriteEventOrActivity({required eAId}) async {
    print('removing favourite event or activity with id: $eAId');
    String token = await getIdToken();
    RestOptions restOptions = RestOptions(
        path: '/${APIConstants.removeFavouriteEventOrActivity}/$eAId',
        headers: {'token': '${token}'});
    final result = await delete(restOptions);
    return result;
  }

  Future<Object> addFavouriteEventOrActivity(
      {required String eAId, required String userId}) async {
    print('add favourite event or activity with id: $eAId');
    String token = await getIdToken();
    RestOptions restOptions = RestOptions(
        path: '/${APIConstants.addFavouriteEA}/$eAId',
        headers: {'token': '${token}'},
        body: transformMapToBody(
            {"userId": userId, DataConstants.EventActivityId: eAId}));
    final result = await put(restOptions);
    return result;
  }

  Future<Object> isEALikedByUser(
      {required String eAId, required String userId}) async {
    print('requesting whether eA is liked by user with id: $eAId');
    String token = await getIdToken();
    RestOptions restOptions = RestOptions(
        path: '/${APIConstants.isEALikedByUser}/$eAId',
        headers: {'token': '${token}'});
    final result = await get(restOptions);
    return result;
  }

  Future<Object> getEAIdsForCategory({required categoryId}) async {
    print('requesting ids for category id: $categoryId');
    RestOptions restOptions =
        RestOptions(path: '/${APIConstants.getEAIdsForCategory}/$categoryId');
    final result = await get(restOptions);
    return result;
  }

  Future<Object> getEAIdsForEventSeries({required eventSeriesId}) async {
    print('requesting ids for eventseries id: $eventSeriesId');

    RestOptions restOptions = RestOptions(
        path: '/${APIConstants.getEAIdsForEventSeries}/$eventSeriesId');
    final result = await get(restOptions);
    return result;
  }

  Future<Object> getEAIdsForLocation({required locationId}) async {
    print('requesting ids for location id: $locationId');

    RestOptions restOptions =
        RestOptions(path: '/${APIConstants.getEAIdsForLocation}/$locationId');
    final result = await get(restOptions);
    return result;
  }



  Future<Object> getSearchResultIds({required SearchQuery searchQuery}) async {
    RestOptions restOptions = RestOptions(
        path: '/${APIConstants.getSearchResultIds}/',
        body: transformClassToBody(searchQuery));
    final result = await put(restOptions);
    return result;
  }

  Future<Object> getMapResultIds({required searchQuery}) async {
    print('requesting Map result ids');
    RestOptions restOptions = RestOptions(
        path: '/${APIConstants.getMapResultIds}/',
        body: transformClassToBody(searchQuery));
    final result = await put(restOptions);
    return result;
  }

  Future<Object> getPrivateUserInfo({required userId}) async {
    print('requesting private user info for for: $userId');
    RestOptions restOptions =
        RestOptions(path: '/${APIConstants.getPrivateUserInfo}/');
    final result = await get(restOptions);
    return result;
  }

  Future<Object> getPublicUserInfo({required organizerId}) async {
    print('requesting public user info for for: $organizerId');
    RestOptions restOptions =
        RestOptions(path: '/${APIConstants.getPublicUserInfo}/');
    final result = await get(restOptions);
    return result;
  }

  Future<Object> savePrivateUserInfo({required UserInfo userInfo}) async {
    String token = await getIdToken();
    RestOptions restOptions = RestOptions(
        path: '/${APIConstants.savePrivateUserInfo}/',
        headers: {'token': '${token}'},
        body: transformClassToBody(userInfo));
    final result = await post(restOptions);
    return result;
  }

  Future<Object> getHomePageIds() async {
    print('requesting home page ids');
    String time = DateFormat('yyyy-MM-ddThh:mm:ss').format(DateTime.now());
    RestOptions restOptions = RestOptions(
      path: '/${APIConstants.getHomePageIds}/$time',
    );
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
    // TODO: run amazon functions
    String token = await getIdToken();
    RestOptions restOptions = RestOptions(
        path: '/${APIConstants.deleteAccount}/$userId',
        headers: {'token': '${token}'});
    final result = await delete(restOptions);
    return result;
  }

  Future<Object> deleteEA({required DeleteEA deleteEA}) async {
    String token = await getIdToken();
    RestOptions restOptions = RestOptions(
        path: '/${APIConstants.deleteEA}/',
        headers: {'token': '${token}'},
        body: transformClassToBody(deleteEA));
    final result = await post(restOptions);
    return result;
  }

  Future<Object> crateEA(
      {required DetailedEventOrActivity detailedEventOrActivity}) async {
    String token = await getIdToken();
    RestOptions restOptions = RestOptions(
        path: '/${APIConstants.createEA}/',
        headers: {'token': '${token}'},
        body: transformClassToBody(detailedEventOrActivity));
    final result = await post(restOptions);
    return result;
  }

  void logout() async {
    await signOutCurrentUser();
    return;
  }

  Future<void> signIn({required String email, required String password}) async {
    final result = await amplifySignIn(password: password, email: email);
  }

  Future<void> signUp({required String password, required String email}) async {
    final result = await amplifySignUp(password: password, email: email);
  }

  Future<void> confirmSignUp(
      {required String confirmationCode, required String email}) async {
    final result = await amplifyConfirmSignUp(
        phoneNumber: email, confirmationCode: confirmationCode);
  }

  Future<void> resendConfirmationCode({required String email}) async {
    final result = await amplifyResendConfirmationCode(email: email);
  }

  Future<void> resetPassword({required String email}) async {
    final result = await amplifyResetPassword(email: email);
  }

  Future<void> confirmResetPassword(
      {required String email,
      required String newPassword,
      required String confirmationCode}) async {
    final result = await amplifyConfirmResetPassword(
        email: email,
        confirmationCode: confirmationCode,
        newPassword: newPassword);
  }

  Future<bool> isSignedIn() async {
    final result = await amplifyIsUserSignedIn();
    return result;
  }
}
