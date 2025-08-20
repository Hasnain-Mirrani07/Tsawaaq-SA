import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/featured_products/featured_products_response.dart';
import 'package:tasawaaq/features/filter/filter_manager.dart';
import 'package:tasawaaq/features/product_list/product_list_manager.dart';
import 'package:tasawaaq/features/product_list/product_list_response.dart';

class ProductListRepo {
  static Future<ProductListResponse> getProductList(
      {int page = 1}) async {

    FilterManager filterManager =  locator<FilterManager>();
    ProductListManager productListManager =  locator<ProductListManager>();

    String sort = filterManager.sortIndexNotifier().value;
    String typeId = filterManager.typeIndexSubject.value
        .toString()
        .replaceAll("[", "")
        .replaceAll("]", "").replaceAll(" ","");
    String brandId = filterManager.brandIndexSubject.value
        .toString()
        .replaceAll("[", "")
        .replaceAll("]", "").replaceAll(" ","");
    // locator<ProductListManager>().cateId.value
    String singleCate = locator<ProductListManager>().cateId.value.toString().replaceAll("[", "").replaceAll("]", "").replaceAll(" ","");;
    String cateId = filterManager.cateIndexSubject.value.toString().replaceAll("[", "").replaceAll("]", "").replaceAll(" ","");
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
    String storeId = productListManager.storeId.hasValue
        ? productListManager.storeId.value.toString()
        .replaceAll("[", "")
        .replaceAll("]", "").replaceAll(" ","")
        : "";

    try {
      final Response response = await locator<ApiService>().dioClient.get(
        '${locator<ApiService>().dioClient.options.baseUrl}products?size_id=$sizeId&store_id=$storeId&color_id=$colorId&type_id=$typeId&price_from=$priceFrom&price_to=$priceTo&featured=0&sort=$sort&page=$page&brand_id=$brandId&category_id=${cateId.isNotEmpty?cateId:singleCate}',
      );

      return ProductListResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return ProductListResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        print('xXx xc ${error.error}');
        return ProductListResponse.makeError(
            error: error, errorMsg: locator<PrefsService>().appLanguage == 'en'
            ? 'No Internet Connection'
            : 'لا يوجد إتصال بالشبكة');
      } else {
        print('xXx xc ${error.error}');
        String errorDescription = locator<PrefsService>().appLanguage == 'en'
            ? 'Something Went Wrong Try Again Later'
            : 'حدث خطأ ما حاول مرة أخرى لاحقاً';

        return ProductListResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }
}
