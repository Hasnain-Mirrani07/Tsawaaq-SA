import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/features/forget_password/forget_password_repo.dart';
import 'package:tasawaaq/features/forget_password/forget_password_request.dart';
import 'package:tasawaaq/features/forget_password/verification_forget_password/forget_password_verification_page.dart';

class ForgetPasswordManager extends Manager {
  bool? acceptTerms = false;
  final ValueNotifier<bool> isSignIn = ValueNotifier(true);

  final ForgetPasswordRepo _forgetPasswordRepo = ForgetPasswordRepo();
  String? errorDescription;
  final prefs = locator<PrefsService>();

  final PublishSubject<ManagerState> _stateSubject = PublishSubject();
  Stream<ManagerState> get state$ => _stateSubject.stream;
  Sink<ManagerState> get inState => _stateSubject.sink;

  Future<ManagerState> forgetPassword(
      {required ForgetPasswordRequest request}) async {
    var managerState = ManagerState.LOADING;
    inState.add(ManagerState.LOADING);
    await _forgetPasswordRepo.forgetPassword(request).then((result) {
      if (result.status == true) {
        inState.add(ManagerState.SUCCESS);

        locator<NavigationService>().pushNamedTo(
            AppRouts.ForgetPasswordVerificationPage,
            arguments:
                ForgetPasswordVerificationArgs(phone: result.data!.phone));

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
