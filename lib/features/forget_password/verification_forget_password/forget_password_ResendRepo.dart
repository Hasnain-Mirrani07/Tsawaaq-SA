import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/forget_password/verification_forget_password/forget_password_ResendResponse.dart';
import 'package:tasawaaq/features/verification/ResendResponse.dart';

class ForgetPasswordResendRepo {
  Future<ForgetPasswordResendResponse> forgetResend(String phone) async {
    // FormData formData = FormData.fromMap(request.toJson());
    // print(formData.fields);
    try {
      final Response response = await locator<ApiService>().dioClient.post(
        '${locator<ApiService>().dioClient.options.baseUrl}resend_code',
        data: {"phone": phone},
      );
      return ForgetPasswordResendResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return ForgetPasswordResendResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        print('xXx xc ${error.error}');
        return ForgetPasswordResendResponse.makeError(
            error: error, errorMsg: locator<PrefsService>().appLanguage == 'en'
            ? 'No Internet Connection'
            : 'لا يوجد إتصال بالشبكة');
      } else {
        print('xXx xc ${error.error}');
        String errorDescription = locator<PrefsService>().appLanguage == 'en'
            ? 'Something Went Wrong Try Again Later'
            : 'حدث خطأ ما حاول مرة أخرى لاحقاً';

        return ForgetPasswordResendResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }
}
