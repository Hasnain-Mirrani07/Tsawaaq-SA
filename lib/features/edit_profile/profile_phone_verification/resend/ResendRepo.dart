import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/verification/ResendResponse.dart';

class ResendRepo {
  final prefs = locator<PrefsService>();

  Future<ResendResponse> resend(String phone) async {
    // FormData formData = FormData.fromMap(request.toJson());
    // print(formData.fields);
    try {
      final Response response = await locator<ApiService>().dioClient.post(
        '${locator<ApiService>().dioClient.options.baseUrl}resend_code',
        data: {"phone": phone},
      );
      return ResendResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return ResendResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        print('xXx xc ${error.error}');
        return ResendResponse.makeError(
            error: error,
            errorMsg: prefs.appLanguage == 'en'
                ? 'No Internet Connection'
                : 'لا يوجد إتصال بالشبكة');
      } else {
        print('xXx xc ${error.error}');
        String errorDescription = prefs.appLanguage == 'en'
            ? "Unexpected error occurred"
            : 'حدث خظأ غير متوقع';

        return ResendResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }
}
