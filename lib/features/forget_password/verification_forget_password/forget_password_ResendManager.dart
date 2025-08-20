import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/forget_password/verification_forget_password/forget_password_ResendRepo.dart';

class ForgetPasswordResendManager extends Manager {
  final ForgetPasswordResendRepo _forgetPasswordResendRepo =
      ForgetPasswordResendRepo();
  String? errorDescription;

  final ValueNotifier<bool> _resendClicked = ValueNotifier(false);
  bool get isResendClicked => _resendClicked.value;
  set isResendClicked(bool isClicked) => _resendClicked.value = isClicked;
  ValueNotifier<bool> get resendNotifier => _resendClicked;

  final PublishSubject<ManagerState> _stateSubject = PublishSubject();

  Stream<ManagerState> get state$ => _stateSubject.stream;
  Sink<ManagerState> get inState => _stateSubject.sink;

  final toast = locator<ToastTemplate>();

  Future<ManagerState> forgetResend({required String phone}) async {
    var managerState = ManagerState.LOADING;
    inState.add(ManagerState.LOADING);
    await _forgetPasswordResendRepo.forgetResend(phone).then((result) {
      if (result.status == true) {
        inState.add(ManagerState.SUCCESS);
        // locator<NavigationService>().pushReplacementNamedTo(
        //     AppRouts.VerificationPage,
        //     arguments: VerificationArgs(phone: result.data?.phone));
        // isResendClicked = false;
        toast.show('${result.message}');

        managerState = ManagerState.SUCCESS;
      } else if (result.status == false) {
        inState.add(ManagerState.ERROR);
        errorDescription = result.message;
        managerState = ManagerState.ERROR;
      } else if (result.error.error is SocketException) {
        inState.add(ManagerState.SOCKET_ERROR);
        errorDescription = locator<PrefsService>().appLanguage == 'en'
            ? 'No Internet Connection'
            : 'لا يوجد إتصال بالشبكة';
        managerState = ManagerState.SOCKET_ERROR;
      } else {
        inState.add(ManagerState.UNKNOWN_ERROR);
        errorDescription = locator<PrefsService>().appLanguage == 'en'
            ? 'Something Went Wrong Try Again Later'
            : 'حدث خطأ ما حاول مرة أخرى لاحقاً';
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
