import 'dart:io';
import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/features/edit_profile/profile_phone_verification/verification_repo.dart';
import 'package:tasawaaq/features/edit_profile/profile_phone_verification/verification_request.dart';


class PhoneVerificationManager extends Manager {
  final PhoneVerificationRepo _phoneVerificationRepo = PhoneVerificationRepo();
  String? errorDescription;


  final PublishSubject<ManagerState> _stateSubject = PublishSubject();
  final prefs = locator<PrefsService>();

  Stream<ManagerState> get state$ => _stateSubject.stream;
  Sink<ManagerState> get inState => _stateSubject.sink;

  Future<ManagerState> activate({required PhoneVerificationRequest request}) async {
    var managerState = ManagerState.LOADING;
    inState.add(ManagerState.LOADING);
    await _phoneVerificationRepo.activate(request).then((result) {
      if (result.status == true) {
        inState.add(ManagerState.SUCCESS);

        locator<ToastTemplate>().show(prefs.appLanguage=="en"?"phone number has been changed successfully":"تم تغيير رقم الهاتف بنجاح");

        locator<PrefsService>().userObj = result.data;



        // locator<NavigationService>().pushReplacementNamedTo(AppRouts.PROFILE_PAGE);

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
