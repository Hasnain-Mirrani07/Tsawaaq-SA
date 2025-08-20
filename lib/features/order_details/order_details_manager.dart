import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/order_details/order_details_repo.dart';
import 'package:tasawaaq/features/order_details/order_details_response.dart';

class OrderDetailsManager extends Manager<OrderDetailsResponse> {
  final PublishSubject<OrderDetailsResponse> _subject = PublishSubject<OrderDetailsResponse>();
  Stream<OrderDetailsResponse> get orderDetails$  => _subject.stream;




  execute({required int orderId}) async{
    await OrderDetailsRepo.getOrderDetails(orderId: orderId).then((result) {
      if (result.error == null) {
        _subject.add(result);
      } else {
        _subject.addError(result.error);
      }
    });
  }



  // execute({required int id}) async{
  //   await OrderDetailsRepo.getOrderDetails(orderId: id).then((result) {
  //     Stream.fromFuture(OrderDetailsRepo.getOrderDetails(orderId: id)).listen((result) {
  //       if (result.error == null) {
  //         _subject.add(result);
  //       } else {
  //         _subject.addError(result.error);
  //       }
  //     });
  //     return _subject.stream;
  //   });
  // }

  @override
  void dispose() {}

  @override
  void clearSubject() {}
}
