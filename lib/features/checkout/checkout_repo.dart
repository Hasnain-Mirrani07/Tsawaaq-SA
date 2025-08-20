import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/checkout/managers/checkout_info_manager.dart';
import 'package:tasawaaq/features/checkout/promo_code/coupon_manager.dart';
import 'package:tasawaaq/features/checkout/requests/checkout_request.dart';
import 'package:tasawaaq/features/checkout/responses/checkout_info_response.dart';
import 'package:tasawaaq/features/checkout/responses/payment_response.dart';

class CheckoutRepo {
  static final prefs = locator<PrefsService>();
  static final checkoutInfoManager = locator<CheckoutInfoManager>();
  static final couponManager = locator<CouponManager>();

  /// getCheckoutInfo
  static Future<CheckoutInfoResponse> getCheckoutInfo({coponId=""}) async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
            '${locator<ApiService>().dioClient.options.baseUrl}checkout?address_id=${checkoutInfoManager.selectAddressSubject.value?.id}&copon_id=${couponManager.promoCodeMsg.value.id}',
            // '${locator<ApiService>().dioClient.options.baseUrl}checkout?address_id=${checkoutInfoManager.selectAddressSubject.value?.id}&copon_id=$coponId',
          );

      return CheckoutInfoResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return CheckoutInfoResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        print('xXx xc ${error.error}');
        return CheckoutInfoResponse.makeError(
            error: error,
            errorMsg: prefs.appLanguage == 'en'
                ? 'No Internet Connection'
                : 'لا يوجد إتصال بالشبكة');
      } else {
        print('xXx xc ${error.error}');
        String errorDescription = prefs.appLanguage == 'en'
            ? "Unexpected error occurred"
            : 'حدث خظأ غير متوقع';

        return CheckoutInfoResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }

  /// payment
  static Future<PaymentResponse> payment(PaymentRequest request) async {
    FormData formData = FormData.fromMap(request.toJson());
    print(formData.fields);
    try {
      final Response response = await locator<ApiService>().dioClient.post(
            '${locator<ApiService>().dioClient.options.baseUrl}checkout',
            data: formData,
          );
      return PaymentResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return PaymentResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        print('xXx xc ${error.error}');
        return PaymentResponse.makeError(
            error: error,
            errorMsg: prefs.appLanguage == 'en'
                ? 'No Internet Connection'
                : 'لا يوجد إتصال بالشبكة');
      } else {
        print('xXx xc ${error.error}');
        String errorDescription = prefs.appLanguage == 'en'
            ? "Unexpected error occurred"
            : 'حدث خظأ غير متوقع';

        return PaymentResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }
}
