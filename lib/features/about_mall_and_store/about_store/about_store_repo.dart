import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/about_mall_and_store/about_store/about_store_response.dart';

class AboutStoreRepo {
  static Future<AboutStoreResponse> getAboutStore(int? id) async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
            '${locator<ApiService>().dioClient.options.baseUrl}stores/$id',
          );

      return AboutStoreResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return AboutStoreResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        print('xXx xc ${error.error}');
        return AboutStoreResponse.makeError(
            error: error, errorMsg: locator<PrefsService>().appLanguage == 'en'
            ? 'No Internet Connection'
            : 'لا يوجد إتصال بالشبكة');
      } else {
        print('xXx xc ${error.error}');
        String errorDescription = locator<PrefsService>().appLanguage == 'en'
            ? 'Something Went Wrong Try Again Later'
            : 'حدث خطأ ما حاول مرة أخرى لاحقاً';

        return AboutStoreResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }
}
