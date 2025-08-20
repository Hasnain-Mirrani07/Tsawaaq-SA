import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/search/search_post/search_post_manager.dart';
import 'package:tasawaaq/features/search/search_post/search_post_response.dart';

class SearchPostRepo {
  static Future<SearchPostResponse> getSearchResults({int page = 1,
    // String? type = "",String? keyword = "",}
  }) async {

    try {
      final Response response = await locator<ApiService>().dioClient.post(
        '${locator<ApiService>().dioClient.options.baseUrl}search?page=$page',
          data: {'type': "${locator<SearchManager>().typeSubject.toString().replaceAll("[", "").replaceAll("]", "")}", 'keyword': "${locator<SearchManager>().keyWordSubject}"}
          // data: {'type': "$type", 'keyword': "$keyword"}
      );

      return SearchPostResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return SearchPostResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        print('xXx xc ${error.error}');
        return SearchPostResponse.makeError(
            error: error, errorMsg: locator<PrefsService>().appLanguage == 'en'
            ? 'No Internet Connection'
            : 'لا يوجد إتصال بالشبكة');
      } else {
        print('xXx xc ${error.error}');
        String errorDescription = locator<PrefsService>().appLanguage == 'en'
            ? 'Something Went Wrong Try Again Later'
            : 'حدث خطأ ما حاول مرة أخرى لاحقاً';

        return SearchPostResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }
}
