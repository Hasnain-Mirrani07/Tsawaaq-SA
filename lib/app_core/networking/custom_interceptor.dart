import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_core/fcm/FcmTokenManager.dart';

class CustomInterceptor implements Interceptor {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers = {
      'FbToken': locator<FcmTokenManager>().currentFcmToken,
      'Platform': Platform.isAndroid ? 'android' : 'ios',
      'Lang': locator<PrefsService>().appLanguage,
      'Authorization': locator<PrefsService>().userObj?.accessToken ?? '',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    return handler.next(options);
  }

  @override
  Future onResponse(Response response, handler) async {
    switch (response.statusCode) {
      case 200:
        // print(response);
        return handler.next(response);
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
      case 403:
        throw UnauthorizedException(response.data.toString());
      case 500:
      default:
        throw FetchDataException(
            '''Error occurred while Communication with Server with StatusCode :
             ${response.statusCode}''');
    }
  }

  @override
  Future onError(DioError e, handler) async {
    return handler.next(e);
  }
}

////////////////////////////////////////////////////////////////////////////////
// @override
// void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//   options.headers = {
//     // 'Auth': '\$2y\$10\$0HkTz09Oaj1Cyoy0F15vfeiPAf6LUhhOHpGEFBA0PEZBsGDj1WBVy',
//     'Auth': locator<PrefsService>().userObj?.authorization ?? '',
//     'Lang': locator<PrefsService>().appLanguage ?? 'en',
//     'Platform': Platform.isAndroid ? 'android' : 'ios',
//     'FirebaseToken': locator<FcmTokenManager>().currentFcmToken ?? '',
//     // 'Content-Type': 'application/json',
//   };
// }
///////////////////////////////////////////////////////////////////////////////
// @override
// void onResponse(Response response, ResponseInterceptorHandler handler) {
//   // TODO: implement onResponse
// }
///////////////////////////////////////////////////////////////////////////////
// @override
// void onError(DioError err, ErrorInterceptorHandler handler) {
//   // TODO: implement onError
// }
///////////////////////////////////////////////////////////////////////////////
