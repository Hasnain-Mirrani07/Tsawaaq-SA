import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/addresses/add_address/add_address_repo.dart';
import 'package:tasawaaq/features/addresses/add_address/add_address_request.dart';
import 'package:tasawaaq/features/addresses/add_address/add_address_response.dart'
    hide Area;
import 'package:tasawaaq/features/addresses/add_address/add_address_response.dart';
import 'package:tasawaaq/features/addresses/my_addresses/my_addresses_response.dart';
import 'package:tasawaaq/features/checkout/managers/checkout_info_manager.dart';

class AddAddressManager extends Manager<AddAddressResponse> {
  final ValueNotifier<Area> selectAreaSubject = ValueNotifier(Area(
      id: 0,
      name: locator<PrefsService>().appLanguage == 'en' ? "Area" : "المنطقة"));

  final AddAddressRepo _addAddressRepo = AddAddressRepo();
  String? errorDescription;

  final PublishSubject<ManagerState> _stateSubject = PublishSubject();

  Stream<ManagerState> get state$ => _stateSubject.stream;
  Sink<ManagerState> get inState => _stateSubject.sink;

  final checkoutInfoManager = locator<CheckoutInfoManager>();
  final prefs = locator<PrefsService>();

  Future<ManagerState> addAddress({
    required AddressesRequest request,
  }) async {
    // final addressesGetManager = locator<AddressesGetManager>();

    var managerState = ManagerState.LOADING;
    inState.add(ManagerState.LOADING);
    await _addAddressRepo.addAddress(request).then((result) {
      if (result.status == true) {
        inState.add(ManagerState.SUCCESS);
        if (prefs.userObj == null) {
          checkoutInfoManager.selectAddressSubject.value = result.data;
        }

        // // locator<PrefsService>().userObj = result.data?.user;
        //
        // locator<AddressesGetManager>().subject.sink.add(result);
        managerState = ManagerState.SUCCESS;
        // locator<NavigationService>().goBack();
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
