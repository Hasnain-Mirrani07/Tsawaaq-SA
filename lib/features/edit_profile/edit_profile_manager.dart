import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/features/Profile/profile_manager.dart';
import 'package:tasawaaq/features/addresses/delete_address/delete_address_response.dart';
import 'package:tasawaaq/features/edit_profile/edit_profile_repo.dart';
import 'package:tasawaaq/features/edit_profile/edit_profile_request.dart';
import 'package:tasawaaq/features/edit_profile/widgets/gender_widget.dart';

class EditProfileManager extends Manager<DeleteAddressesResponse> {

   String? changedPhoneNumber ;

  final ValueNotifier<Gender> selectGenderSubject = ValueNotifier(Gender(
      id: 0,
      title: locator<PrefsService>().appLanguage == 'en'
          ? "Prefer not to say"
          : "افضل عدم القول",
      value: ''));


  resetGenderSubject() {
    selectGenderSubject.value = Gender(
        id: 0,
        title: locator<PrefsService>().appLanguage == 'en'
            ? "Prefer not to say"
            : "افضل عدم القول",
        value: '');
  }

  final ValueNotifier selectDateSubject = ValueNotifier(
      "${locator<PrefsService>().appLanguage == 'en' ? "Date of Birth" : "تاريخ الميلاد"}");

  String? errorDescription;
  final prefs = locator<PrefsService>();
  final toast = locator<ToastTemplate>();

  final PublishSubject<ManagerState> _stateSubject = PublishSubject();
  Stream<ManagerState> get state$ => _stateSubject.stream;
  Sink<ManagerState> get inState => _stateSubject.sink;

  final _profileManager = locator<ProfileManager>();

  Future<ManagerState> editProfile(
      {required EditProfileRequest request,thenDo}) async {
    var managerState = ManagerState.LOADING;
    inState.add(ManagerState.LOADING);
    await EditProfileRepo.editProfile(request).then((result) {

      if (result.status == true) {

        if(result.phoneStatus == 3){
          locator<PrefsService>().userObj = result.data;
          _profileManager.execute();
          thenDo();
          // locator<NavigationService>().goBack();
        }else{
          locator<NavigationService>().pushNamedTo(AppRouts.PhoneVerificationPage);
          toast.show('${result.message}');
        }
        inState.add(ManagerState.SUCCESS);
        managerState = ManagerState.SUCCESS;


      } else if (result.status == false) {


        inState.add(ManagerState.ERROR);
        errorDescription = result.message;
        managerState = ManagerState.ERROR;

        // if(result.phoneStatus == 2){
        //   inState.add(ManagerState.SUCCESS);
        //   // inState.add(ManagerState.ERROR);
        //   errorDescription = result.message;
        //   toast.show('$errorDescription');
        //   managerState = ManagerState.SUCCESS;
        //   // managerState = ManagerState.ERROR;
        //   locator<NavigationService>().pushNamedTo(AppRouts.ChangePasswordPage);
        // }else{
        //   inState.add(ManagerState.ERROR);
        //   errorDescription = result.message;
        //   managerState = ManagerState.ERROR;
        // }





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
