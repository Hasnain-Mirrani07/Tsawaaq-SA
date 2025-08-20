import 'package:flutter/cupertino.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/features/my_orders/my_orders_repo.dart';
import 'package:tasawaaq/features/my_orders/my_orders_response.dart';

class MyOrderManager extends Manager {
  final ValueNotifier<int> _switchNotifire = ValueNotifier(0);
  int get switchIndex => _switchNotifire.value;
  set switchIndex(int value) => _switchNotifire.value = value;
  ValueNotifier<int> switchIndexNotifier() => _switchNotifire;


  final BehaviorSubject<List<Pending>> ordersSubject = BehaviorSubject<List<Pending>>();



  final BehaviorSubject<MyOrdersResponse> _subject = BehaviorSubject<MyOrdersResponse>();

  Stream<MyOrdersResponse> get myOrders$  => _subject.stream;





  execute() async{
    await MyOrdersRepo.getMyOrders().then((result) {
      if (result.error == null) {
        _subject.add(result);
        ordersSubject.sink.add(result.data!.pending!);
      } else {
        _subject.addError(result.error);
      }
    });
  }


  @override
  void dispose() {
    ordersSubject.close();
    _subject.close();
  }

  @override
  void clearSubject() {}
}
