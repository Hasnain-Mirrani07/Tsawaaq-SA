import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/checkout/checkout_repo.dart';
import 'package:tasawaaq/features/checkout/promo_code/CouponResponse.dart';
import 'package:tasawaaq/features/checkout/responses/checkout_info_response.dart';
import 'package:tasawaaq/features/checkout/widgets/payment_method.dart';

class CheckoutInfoManager extends Manager<CheckoutInfoResponse> {
  String addressId = "";

  final ValueNotifier<bool?> _returnNotifier = ValueNotifier(false);
  ValueNotifier<bool?> get returnNotifier => _returnNotifier;
  bool? get returnData => _returnNotifier.value;

  final ValueNotifier<bool?> _switchReturnNotifier = ValueNotifier(false);
  ValueNotifier<bool?> get switchReturnNotifier => _switchReturnNotifier;
  bool? get switchReturnData => _switchReturnNotifier.value;

  // void switchBool(){}
  // set returnData(String? returnStatus) =>
  //     _returnNotifier.value = String;

  final ValueNotifier<CouponData?> _couponDataNotifier = ValueNotifier(null);
  ValueNotifier<CouponData?> get couponNotifier => _couponDataNotifier;
  CouponData? get couponData => _couponDataNotifier.value;
  set couponData(CouponData? couponData) =>
      _couponDataNotifier.value = couponData;

  final ValueNotifier<Address?> selectAddressSubject = ValueNotifier(null);
  final BehaviorSubject<PaymentMethod> _paymentMethodSubject =
      BehaviorSubject.seeded(PaymentMethod());
  Stream<PaymentMethod> get paymentMethod$ => _paymentMethodSubject.stream;
  set inPaymentMethod(paymentMethod) =>
      _paymentMethodSubject.sink.add(paymentMethod);
  PaymentMethod getSelectedPaymentMethod() => _paymentMethodSubject.value;

  final PublishSubject<CheckoutInfoResponse> _subject =
      PublishSubject<CheckoutInfoResponse>();

  set inCartList(CheckoutInfoResponse response) => _subject.sink.add(response);

  Stream<CheckoutInfoResponse> get checkoutInfo$ => _subject.stream;

  execute({coponId = ""}) async {
    await CheckoutRepo.getCheckoutInfo(coponId: coponId).then(
      (result) {
        if (result.error == null) {
          _subject.add(result);
        } else {
          _subject.addError(result.error);
        }
      },
    );
  }


  @override
  void dispose() {
    _paymentMethodSubject.close();
  }

  @override
  void clearSubject() {}
}
