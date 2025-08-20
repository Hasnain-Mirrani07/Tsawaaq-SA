import 'dart:io';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/features/contact_us/contact_us_repo.dart';
import 'package:tasawaaq/features/contact_us/contact_us_request.dart';
import 'package:tasawaaq/features/contact_us/contact_us_response.dart';


class ContactUsManager extends Manager<ContactUsPostResponse> {
  final ContactUsPostRepo _contactUsPostRepo = ContactUsPostRepo();
  String? errorDescription;

  final PublishSubject<ManagerState> _stateSubject = PublishSubject();

  Stream<ManagerState> get state$ => _stateSubject.stream;
  Sink<ManagerState> get inState => _stateSubject.sink;

  Future<ManagerState>  contactUsPost({required ContactUsPostRequest request,thenDo}) async {
    var managerState = ManagerState.LOADING;
    inState.add(ManagerState.LOADING);
    await _contactUsPostRepo.contactUsPost(request).then((result) {
      if (result.status == true) {
        inState.add(ManagerState.SUCCESS);
        thenDo();
        // locator<NavigationService>().pushReplacementNamedTo(AppRouts.TABS_WIDGET);
        // locator<NavigationService>().goBack();
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
