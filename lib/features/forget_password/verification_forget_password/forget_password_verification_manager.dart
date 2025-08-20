import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/features/forget_confirm_password/forget_confirm_password_page.dart';
import 'package:tasawaaq/features/forget_password/verification_forget_password/forget_password_verification_repo.dart';
import 'package:tasawaaq/features/forget_password/verification_forget_password/forget_password_verification_request.dart';

class ForgetPasswordVerificationManager extends Manager {
  final ForgetPasswordVerificationRepo _forgetPasswordVerificationRepo =
      ForgetPasswordVerificationRepo();
  String? errorDescription;
  final prefs = locator<PrefsService>();

  final PublishSubject<ManagerState> _stateSubject = PublishSubject();

  Stream<ManagerState> get state$ => _stateSubject.stream;
  Sink<ManagerState> get inState => _stateSubject.sink;

  Future<ManagerState> forgetActivate(
      {required ForgetPasswordVerificationRequest request}) async {
    var managerState = ManagerState.LOADING;
    inState.add(ManagerState.LOADING);
    await _forgetPasswordVerificationRepo
        .forgetActivate(request)
        .then((result) {
      if (result.status == true) {
        inState.add(ManagerState.SUCCESS);

        locator<ToastTemplate>().show('${result.message}');
        // locator<PrefsService>().userObj = result.user;
        locator<NavigationService>().pushReplacementNamedTo(
            AppRouts.ForgetPasswordConfirmPage,
            arguments: ForgetPasswordConfirmArgs(userId: result.data!.userId!));

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
