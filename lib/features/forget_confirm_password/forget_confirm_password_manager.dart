import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/forget_confirm_password/forget_confirm_password_repo.dart';
import 'package:tasawaaq/features/forget_confirm_password/forget_confirm_password_request.dart';

class ForgetPasswordConfirmManager extends Manager {
  bool? acceptTerms = false;
  final ValueNotifier<bool> isSignIn = ValueNotifier(true);
  final prefs = locator<PrefsService>();

  final ForgetPasswordConfirmationRepo _forgetPasswordConfirmationRepo =
  ForgetPasswordConfirmationRepo();
  String? errorDescription;

  final PublishSubject<ManagerState> _stateSubject = PublishSubject();
  Stream<ManagerState> get state$ => _stateSubject.stream;
  Sink<ManagerState> get inState => _stateSubject.sink;
  final toast = locator<ToastTemplate>();

  Future<ManagerState> forgetPasswordConfirmation(
      {required ForgetPasswordConfirmationRequest request}) async {
    var managerState = ManagerState.LOADING;
    inState.add(ManagerState.LOADING);
    await _forgetPasswordConfirmationRepo
        .forgetPasswordConfirmation(request)
        .then((result) {
      if (result.status == true) {
        // inState.add(ManagerState.SUCCESS);
        // toast.show('${result.message}');
        // locator<NavigationService>()
        //     .pushNamedAndRemoveUntil(AppRouts.SignInPage);

        // Navigator.of(context).pushNamedAndRemoveUntil(
        //     AppRouts.SignInPage, (Route<dynamic> route) => false);

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
  void clearSubject() {
    // TODO: implement clearSubject
  }

  @override
  void dispose() {
    _stateSubject.close();
    // TODO: implement dispose
  }
}