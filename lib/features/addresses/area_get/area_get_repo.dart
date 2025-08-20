import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/addresses/area_get/area_get_response.dart';

//test
class AreaGetRepo {
  static Future<AreaResponse> getArea() async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
            '${locator<ApiService>().dioClient.options.baseUrl}areas',
          );

      return AreaResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 || error.response?.statusCode == 422) {
        return AreaResponse.fromJsonError(json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        print('xXx xc ${error.error}');
        return AreaResponse.makeError(error: error, errorMsg: locator<PrefsService>().appLanguage == 'en' ? 'No Internet Connection' : 'لا يوجد إتصال بالشبكة');
      } else {
        print('xXx xc ${error.error}');
        String errorDescription = locator<PrefsService>().appLanguage == 'en' ? 'Something Went Wrong Try Again Later' : 'حدث خطأ ما حاول مرة أخرى لاحقاً';

        return AreaResponse.makeError(error: error, errorMsg: errorDescription);
      }
    }
  }
}
