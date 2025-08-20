import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/ads/ads_response.dart';
import 'package:tasawaaq/features/categories/categories_response.dart';

class CategoriesRepo {
  static Future<CategoriesResponse> getCategories() async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
            '${locator<ApiService>().dioClient.options.baseUrl}categories',
          );
      return CategoriesResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return CategoriesResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        print('xXx xc ${error.error}');
        return CategoriesResponse.makeError(
            error: error, errorMsg: locator<PrefsService>().appLanguage == 'en'
            ? 'No Internet Connection'
            : 'لا يوجد إتصال بالشبكة');
      } else {
        print('xXx xc ${error.error}');
        String errorDescription = locator<PrefsService>().appLanguage == 'en'
            ? 'Something Went Wrong Try Again Later'
            : 'حدث خطأ ما حاول مرة أخرى لاحقاً';

        return CategoriesResponse.makeError(error: error, errorMsg: errorDescription);
      }
    }
  }
}
