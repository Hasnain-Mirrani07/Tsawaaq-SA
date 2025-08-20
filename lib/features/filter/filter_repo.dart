import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/filter/filter_response.dart';

class FilterRepo {
  static Future<FilterResponse> getFilter({storeId = "",categoryId = ""}) async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
        '${locator<ApiService>().dioClient.options.baseUrl}products_filter?store_id=$storeId&category_id=$categoryId',
      );

      return FilterResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return FilterResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        print('xXx xc ${error.error}');
        return FilterResponse.makeError(
            error: error, errorMsg: locator<PrefsService>().appLanguage == 'en'
            ? 'No Internet Connection'
            : 'لا يوجد إتصال بالشبكة');
      } else {
        print('xXx xc ${error.error}');
        String errorDescription = locator<PrefsService>().appLanguage == 'en'
            ? 'Something Went Wrong Try Again Later'
            : 'حدث خطأ ما حاول مرة أخرى لاحقاً';

        return FilterResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }
}
