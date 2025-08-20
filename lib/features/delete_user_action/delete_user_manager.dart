import 'dart:io';

import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/features/delete_user_action/delete_user_repo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/features/sign_in_sign_up/sign_up_response.dart';

class DeleteUserManager extends Manager<SignUpResponse> {
  final DeleteUserRepo _deleteUserRepo = DeleteUserRepo();
  final _prefs = locator<PrefsService>();
  String? errorDescription;

  final PublishSubject<ManagerState> _stateSubject = PublishSubject();

  Stream<ManagerState> get state$ => _stateSubject.stream;
  Sink<ManagerState> get inState => _stateSubject.sink;

  Future<void> deleteUser() async {
    // var managerState = ManagerState.loading;
    // inState.add(ManagerState.loading);
    await _deleteUserRepo.deleteUser().then((result) {
      if (result.status == true) {
        // inState.add(ManagerState.success);

        // locator<NavigationService>()
        //     .pushReplacementNamedTo(AppRoutesNames.MainPageWithDrawer);
        _prefs.removeUserObj();

        locator<NavigationService>()
            .pushNamedAndRemoveUntil(AppRouts.SignInPage);

        // managerState = ManagerState.success;
      } else if (result.status == false) {
        // inState.add(ManagerState.error);
        errorDescription = result.message;
        // managerState = ManagerState.error;
      } else if (result.error.error is SocketException) {
        // inState.add(ManagerState.socketError);
        errorDescription = _prefs.appLanguage == 'en'
            ? 'No Internet Connection'
            : 'لا يوجد إتصال بالشبكة';
        // managerState = ManagerState.socketError;
      } else {
        // inState.add(ManagerState.unknownError);
        errorDescription = _prefs.appLanguage == 'en'
            ? "Unexpected error occurred"
            : 'حدث خظأ غير متوقع';
        // managerState = ManagerState.unknownError;
      }

      // locator<NavigationService>()
      //     .pushNamedAndRemoveUntil(AppRoutesNames.loginPage);
    });
    return ;
    // return managerState;
  }

  @override
  void dispose() {
    _stateSubject.close();
  }

  @override
  void clearSubject() {
    // TODO: implement clearSubject
  }
}
