import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/checkout/managers/checkout_info_manager.dart';
import 'package:tasawaaq/features/checkout/promo_code/CouponRequest.dart';
import 'package:tasawaaq/features/checkout/promo_code/coupon_repo.dart';

class CouponManager extends Manager {
  String? errorDescription;

  final PublishSubject<ManagerState> _stateSubject = PublishSubject();
  final BehaviorSubject<PromoObject> promoCodeMsg = BehaviorSubject();
  final prefs = locator<PrefsService>();
  final navigationService = locator<NavigationService>();

  String validPromoCodeMsg = locator<PrefsService>().appLanguage == 'en'
      ? "valid promo code"
      : "كوبون خصم صالح";
  String inValidPromoCodeMsg = locator<PrefsService>().appLanguage == 'en'
      ? "invalid promo code!"
      : "كوبون خصم غير صالح!";

  Stream<ManagerState> get state$ => _stateSubject.stream;
  Sink<ManagerState> get inState => _stateSubject.sink;

  final checkoutInfoManager = locator<CheckoutInfoManager>();
  final toast = locator<ToastTemplate>();

  Future<ManagerState> coupon({required CouponRequest request}) async {
    var managerState = ManagerState.LOADING;
    inState.add(ManagerState.LOADING);
    await CouponRepo.coupon(request).then((result) {
      if (result.status == true) {
        inState.add(ManagerState.SUCCESS);
        promoCodeMsg.sink.add(PromoObject(
            title: validPromoCodeMsg, id: '${result.data?.coponId ?? ''}'));
        checkoutInfoManager.couponData = result.data;
        checkoutInfoManager.execute(coponId: '${result.data?.coponId ?? ''}');
        // promoCodeMsg.sink.add(validPromoCodeMsg);
        // toast.show('${result.message}');
        managerState = ManagerState.SUCCESS;
      } else if (result.status == false) {
        inState.add(ManagerState.ERROR);
        toast.show('${result.message}');
        errorDescription = result.message;
        managerState = ManagerState.ERROR;
        // promoCodeMsg.sink.add(inValidPromoCodeMsg);
        promoCodeMsg.sink.add(PromoObject(title: inValidPromoCodeMsg, id: ''));
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
    promoCodeMsg.close();
  }

  @override
  void clearSubject() {}
}

class PromoObject {
  String? title;
  String? id;
  PromoObject({this.id, this.title});
}
