 import 'package:dio/dio.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_core/locator.dart';
import 'package:tasawaaq/features/payment_status/payment_call_url/PaymentStatusModel.dart';


 class PaymentResponseMethod {
   static Future paymentResponseMethod(String url) async {
     try {
       final Response response =
           await locator<ApiService>().dioClient.get('$url');
       print('xXx: $response');
       return response;
     } on DioError {
       print('xXx: DioError');
       throw FetchDataException();
     }
   }
 }
