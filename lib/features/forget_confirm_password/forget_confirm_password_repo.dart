import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/forget_confirm_password/forget_confirm_password_request.dart';
import 'package:tasawaaq/features/forget_confirm_password/forget_confirm_password_response.dart';



class ForgetPasswordConfirmationRepo {
  Future<ForgetPasswordConfirmationResponse> forgetPasswordConfirmation(ForgetPasswordConfirmationRequest request) async {
    FormData formData = FormData.fromMap(request.toJson());
    print(formData.fields);
    try {
      final Response response = await locator<ApiService>().dioClient.post(
        '${locator<ApiService>().dioClient.options.baseUrl}reset_password',
        data: formData,
      );
      return ForgetPasswordConfirmationResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return ForgetPasswordConfirmationResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        print('xXx xc ${error.error}');
        return ForgetPasswordConfirmationResponse.makeError(
            error: error, errorMsg: locator<PrefsService>().appLanguage == 'en'
            ? 'No Internet Connection'
            : 'لا يوجد إتصال بالشبكة');
      } else {
        print('xXx xc ${error.error}');
        String errorDescription = locator<PrefsService>().appLanguage == 'en'
            ? 'Something Went Wrong Try Again Later'
            : 'حدث خطأ ما حاول مرة أخرى لاحقاً';


        return ForgetPasswordConfirmationResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }

}
