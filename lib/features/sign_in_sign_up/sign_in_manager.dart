import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/features/sign_in_sign_up/auth_repo.dart';
import 'package:tasawaaq/features/sign_in_sign_up/sign_in_request.dart';
import 'package:tasawaaq/features/verification/verification_page.dart';

class SignInManager extends Manager {
  bool? acceptTerms = false;
  final ValueNotifier<bool> isSignIn = ValueNotifier(true);

  final prefs = locator<PrefsService>();
  final toast = locator<ToastTemplate>();

  final AuthRepo _loginRepo = AuthRepo();
  String? errorDescription;

  final PublishSubject<ManagerState> _stateSubject = PublishSubject();

  Stream<ManagerState> get state$ => _stateSubject.stream;
  Sink<ManagerState> get inState => _stateSubject.sink;

  Future<ManagerState> login({required SignInRequest request}) async {
    var managerState = ManagerState.LOADING;
    inState.add(ManagerState.LOADING);
    await _loginRepo.signIn(request).then((result) {
      if (result.status == true) {
        inState.add(ManagerState.SUCCESS);
        locator<PrefsService>().userObj = result.user;
        // if (result.user?.status == 0 || result.user?.phoneVerified == false) {
        if (result.user?.status == 0) {
          locator<NavigationService>().pushNamedTo(AppRouts.VerificationPage,
              arguments: VerificationArgs(phone: result.user?.phone));
        } else if (result.user?.status == 1) {
          locator<NavigationService>()
              .pushReplacementNamedTo(AppRouts.TABS_WIDGET);
        } else if (result.user?.status == 2) {
          //TODO: Go to edit profile page
        }else if (result.user?.status == -1){
          toast.show(prefs.appLanguage == 'en' ? 'your account has been disabled' : 'تم تعطيل حسابك');
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
