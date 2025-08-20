import 'dart:io';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:dio/dio.dart';
import 'package:tasawaaq/features/addresses/AddressesResponse.dart';
import 'package:tasawaaq/features/addresses/add_address/add_address_request.dart';
import 'package:tasawaaq/features/addresses/add_address/add_address_response.dart';




class AddAddressRepo {
  Future<AddAddressResponse> addAddress(AddressesRequest request) async {
    FormData formData = FormData.fromMap(request.toJson());
    print(formData.fields);
    try {
      final Response response = await locator<ApiService>().dioClient.post(
            '${locator<ApiService>().dioClient.options.baseUrl}addresses',
            data: formData,
          );
      return AddAddressResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return AddAddressResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        print('xXx xc ${error.error}');
        return AddAddressResponse.makeError(
            error: error, errorMsg: locator<PrefsService>().appLanguage == 'en'
            ? 'No Internet Connection'
            : 'لا يوجد إتصال بالشبكة');
      } else {
        print('xXx xc ${error.error}');
        String errorDescription = locator<PrefsService>().appLanguage == 'en'
            ? 'Something Went Wrong Try Again Later'
            : 'حدث خطأ ما حاول مرة أخرى لاحقاً';

        return AddAddressResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }
}
