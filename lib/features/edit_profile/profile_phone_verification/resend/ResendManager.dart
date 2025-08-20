import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/verification/ResendRepo.dart';

class ResendManager extends Manager {
  final ResendRepo _resendRepo = ResendRepo();
  String? errorDescription;

  final ValueNotifier<bool> _resendClicked = ValueNotifier(false);
  bool get isResendClicked => _resendClicked.value;
  set isResendClicked(bool isClicked) => _resendClicked.value = isClicked;
  ValueNotifier<bool> get resendNotifier => _resendClicked;

  final PublishSubject<ManagerState> _stateSubject = PublishSubject();

  Stream<ManagerState> get state$ => _stateSubject.stream;
  Sink<ManagerState> get inState => _stateSubject.sink;
  final toast = locator<ToastTemplate>();
  final prefs = locator<PrefsService>();

  Future<ManagerState> resend({required String phone}) async {
    var managerState = ManagerState.LOADING;
    inState.add(ManagerState.LOADING);
    await _resendRepo.resend(phone).then((result) {
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
