import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/features/cart/cart_count/cart_count_manager.dart';
import 'package:tasawaaq/features/checkout/checkout_repo.dart';
import 'package:tasawaaq/features/checkout/payment_web_page.dart';
import 'package:tasawaaq/features/checkout/requests/checkout_request.dart';
import 'package:tasawaaq/features/payment_status/payment_status_page.dart';

class PaymentManager extends Manager {
  String? errorDescription;

  final PublishSubject<ManagerState> _stateSubject = PublishSubject();
  final prefs = locator<PrefsService>();
  final navigationService = locator<NavigationService>();
  final cartCountManager = locator<CartCountManager>();

  Stream<ManagerState> get state$ => _stateSubject.stream;
  Sink<ManagerState> get inState => _stateSubject.sink;
  var managerState = ManagerState.IDLE;
  Future<ManagerState> payment(
      {required PaymentRequest request, required bool isCash}) async {
    managerState = ManagerState.LOADING;
    inState.add(ManagerState.LOADING);
    await CheckoutRepo.payment(request).then((result) {
      if (result.status == true) {
        inState.add(ManagerState.SUCCESS);
        cartCountManager.execute();
        if (isCash) {
          navigationService.pushReplacementNamedTo(AppRouts.PaymentStatusPage,
              arguments: PaymentStatusPageArgs(
                  isSuccess: true,
                  orderId: '${result.data?.orderId}',
                  itemCount: '${result.data?.items}',
                  total: '${result.data?.total} ${result.data?.currency}'));
        } else {
          // PaymentWebPage
          navigationService.pushNamedTo(AppRouts.PaymentWebPage,
              arguments: PaymentPageArgs(response: result));
        }

        managerState = ManagerState.SUCCESS;
      } else if (result.status == false) {
        inState.add(ManagerState.ERROR);
        errorDescription = result.message;
        managerState = ManagerState.ERROR;
      } else if (result.error.error is SocketException) {
        inState.add(ManagerState.SOCKET_ERROR);
        errorDescription = prefs.appLanguage == 'en'
            ? 'No Internet Connection'
            : 'لا يوجد إتصال بالشبكة';
        managerState = ManagerState.SOCKET_ERROR;
      } else {
        inState.add(ManagerState.UNKNOWN_ERROR);
        errorDescription = prefs.appLanguage == 'en'
            ? "Unexpected error occurred"
            : 'حدث خظأ غير متوقع';
        managerState = ManagerState.UNKNOWN_ERROR;
      }
    });

    return managerState;
  }

  @override
  void dispose() {
    _stateSubject.close();
  }

  @override
  void clearSubject() {}
}
