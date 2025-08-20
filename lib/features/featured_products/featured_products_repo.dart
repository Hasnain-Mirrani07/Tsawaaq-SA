import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/featured_products/featured_products_response.dart';
import 'package:tasawaaq/features/filter/filter_manager.dart';




class FeaturedProductRepo {

  static Future<FeaturedProductsResponse> getFeaturedProducts(
      {int page = 1}) async {
    FilterManager filterManager =  locator<FilterManager>();


    String sort = filterManager.sortIndexNotifier().value;
    String typeId = filterManager.typeIndexSubject.value
        .toString()
        .replaceAll("[", "")
        .replaceAll("]", "").replaceAll(" ","");
    String brandId = filterManager.brandIndexSubject.value
        .toString()
        .replaceAll("[", "")
        .replaceAll("]", "").replaceAll(" ","");
    String cateId = filterManager.cateIndexSubject.value
        .toString()
        .replaceAll("[", "")
        .replaceAll("]", "").replaceAll(" ","");
    String sizeId = filterManager.sizeIndexSubject.value
        .toString()
        .replaceAll("[", "")
        .replaceAll("]", "").replaceAll(" ","");
    String colorId = filterManager.colorIndexSubject.value
        .toString()
        .replaceAll("[", "")
        .replaceAll("]", "").replaceAll(" ","");
    String priceFrom = "${filterManager.startPriceSubject.value}";
    String priceTo = "${filterManager.endPriceSubject.value}";
    // String priceFrom = filterManager.priceRangeSubject.hasValue
    //     ? filterManager.priceRangeSubject.value.start.round().toString()
    //     : "";
    // String priceTo = filterManager.priceRangeSubject.hasValue
    //     ? filterManager.priceRangeSubject.value.end.round().toString()
    //     : "";

    try {
      final Response response = await locator<ApiService>().dioClient.get(
        '${locator<ApiService>().dioClient.options.baseUrl}products?size_id=$sizeId&color_id=$colorId&type_id=$typeId&price_from=$priceFrom&price_to=$priceTo&featured=1&sort=$sort&page=$page&brand_id=$brandId&category_id=$cateId',
      );

      return FeaturedProductsResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return FeaturedProductsResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        print('xXx xc ${error.error}');
        return FeaturedProductsResponse.makeError(
            error: error, errorMsg: locator<PrefsService>().appLanguage == 'en'
            ? 'No Internet Connection'
            : 'لا يوجد إتصال بالشبكة');
      } else {
        print('xXx xc ${error.error}');
        String errorDescription = locator<PrefsService>().appLanguage == 'en'
            ? 'Something Went Wrong Try Again Later'
            : 'حدث خطأ ما حاول مرة أخرى لاحقاً';

        return FeaturedProductsResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }
}
