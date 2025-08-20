import 'dart:io';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:dio/dio.dart';
import 'package:tasawaaq/features/addresses/delete_address/delete_address_response.dart';

class DeleteAddressRepo {
  Future<DeleteAddressesResponse> deleteAddress(id) async {
    try {
      final Response response = await locator<ApiService>().dioClient.delete(
            '${locator<ApiService>().dioClient.options.baseUrl}addresses/$id'
          );
      return DeleteAddressesResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return DeleteAddressesResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        print('xXx xc ${error.error}');
        return DeleteAddressesResponse.makeError(
            error: error, errorMsg: locator<PrefsService>().appLanguage == 'en'
            ? 'No Internet Connection'
            : 'لا يوجد إتصال بالشبكة');
      } else {
        print('xXx xc ${error.error}');
        String errorDescription = locator<PrefsService>().appLanguage == 'en'
            ? 'Something Went Wrong Try Again Later'
            : 'حدث خطأ ما حاول مرة أخرى لاحقاً';

        return DeleteAddressesResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }
}
