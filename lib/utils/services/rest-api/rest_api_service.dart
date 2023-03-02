import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:intl/intl.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/modules/models/detailed_event/detailed_event.dart';
import 'package:othia/modules/models/search_query/search_query.dart';
import 'package:othia/utils/services/rest-api/rest_api_utils.dart';
import 'package:othia/utils/services/rest-api/rest_base.dart';

import '../../../modules/models/user_info/user_info.dart';
import '../events/example_event.dart';
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
    recordCustomEvent(
        eventName: "detailRequest", eventParams: {"eAId": eventOrActivityId});
    String time = DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now());
    RestOptions restOptions = RestOptions(
        path: '/${APIConstants.eADetailPath}/$eventOrActivityId',
        queryParameters: {'user_time': time});
    final result = await get(restOptions);
    return result;
  }

  Future<Object> getEASummary({required id}) async {
    String time = DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now());
    print('requesting summary for: $id');
    RestOptions restOptions = RestOptions(
        path: '/${APIConstants.getEASummary}/$id',
        queryParameters: {'user_time': time});
    final result = await get(restOptions);
    return result;
  }

  Future<Object> fetchFavouriteEventsAndActivities() async {
    String token = await getIdToken();
    String time = DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now());
    RestOptions restOptions = RestOptions(
        path: '/${APIConstants.fetchFavouriteEventsAndActivities}/',
        headers: {'token': '${token}'},
        queryParameters: {'user_time': time});
    final result = await get(restOptions);
    return result;
  }

  Future<Object> removeFavouriteEventOrActivity({required eAId}) async {
    print('removing favourite event or activity with id: $eAId');
    recordCustomEvent(eventName: "userDislikes", eventParams: {"eAId": eAId});
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
    recordCustomEvent(eventName: "userLikes", eventParams: {"eAId": eAId});
    String token = await getIdToken();
    RestOptions restOptions = RestOptions(
      path: '/${APIConstants.addFavouriteEA}/$eAId',
      headers: {'token': '${token}'},
    );
    final result = await get(restOptions);
    return result;
  }

  Future<Object> isEALikedByUser({required String eAId}) async {
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
    String time = DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now());
    RestOptions restOptions = RestOptions(
        path: '/${APIConstants.getEAIdsForCategory}/$categoryId',
        queryParameters: {'user_time': time});
    final result = await get(restOptions);
    return result;
  }

  Future<Object> getEAIdsForEventSeries({required eventSeriesId}) async {
    print('requesting ids for eventseries id: $eventSeriesId');
    String time = DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now());
    RestOptions restOptions = RestOptions(
        path: '/${APIConstants.getEAIdsForEventSeries}/$eventSeriesId',
        queryParameters: {'user_time': time});
    final result = await get(restOptions);
    return result;
  }

  Future<Object> getEAIdsForLocation({required locationId}) async {
    print('requesting ids for location id: $locationId');
    String time = DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now());
    RestOptions restOptions = RestOptions(
        path: '/${APIConstants.getEAIdsForLocation}/$locationId',
        queryParameters: {'user_time': time});
    final result = await get(restOptions);
    return result;
  }



  Future<Object> getSearchResultIds({required SearchQuery searchQuery}) async {
    recordCustomEvent(
        eventName: "searchRequest", eventParams: searchQuery.toJson());
    RestOptions restOptions = RestOptions(
        path: '/${APIConstants.getSearchResultIds}/',
        body: transformClassToBody(searchQuery));
    final result = await put(restOptions);
    return result;
  }

  Future<Object> getMapResultIds({required searchQuery}) async {
    print('requesting Map result ids');
    recordCustomEvent(
        eventName: "mapSearch", eventParams: searchQuery.toJson());
    RestOptions restOptions = RestOptions(
        path: '/${APIConstants.getMapResultIds}/',
        body: transformClassToBody(searchQuery));
    final result = await put(restOptions);
    return result;
  }

  Future<Object> getPrivateUserInfo() async {
    String token = await getIdToken();
    RestOptions restOptions = RestOptions(
      path: '/${APIConstants.getPrivateUserInfo}/',
      headers: {'token': '${token}'},
    );
    final result = await get(restOptions);
    return result;
  }

  Future<Object> getPublicUserInfo({required organizerId}) async {
    print('requesting public user info for for: $organizerId');
    recordCustomEvent(
        eventName: "publisherRequest",
        eventParams: {"publisherId": organizerId});
    RestOptions restOptions = RestOptions(
      path: '/${APIConstants.getPublicUserInfo}/$organizerId',
    );
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
    String time = DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now());
    RestOptions restOptions = RestOptions(
        path: '/${APIConstants.getHomePageIds}',
        queryParameters: {'user_time': time});
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

  Future<Object> deleteAccount() async {
    String token = await getIdToken();
    RestOptions restOptions = RestOptions(
        path: '/${APIConstants.deleteAccount}', headers: {'token': '${token}'});
    final result = await delete(restOptions);
    return result;
  }

  Future<Object> deleteEA({required String eAId}) async {
    String token = await getIdToken();
    RestOptions restOptions = RestOptions(
      path: '/${APIConstants.deleteEA}/$eAId',
      headers: {'token': '${token}'},
      body: transformMapToBody({}));
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
