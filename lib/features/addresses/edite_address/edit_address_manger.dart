import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/addresses/add_address/add_address_request.dart';
import 'package:tasawaaq/features/addresses/add_address/add_address_response.dart'
    hide Area;
import 'package:tasawaaq/features/addresses/edite_address/edit_address_repo.dart';
import 'package:tasawaaq/features/checkout/managers/checkout_info_manager.dart';

class EditAddressManager extends Manager<AddAddressResponse> {
  final EditAddressRepo _editAddressRepo = EditAddressRepo();
  String? errorDescription;

  final PublishSubject<ManagerState> _stateSubject = PublishSubject();

  Stream<ManagerState> get state$ => _stateSubject.stream;
  Sink<ManagerState> get inState => _stateSubject.sink;
  final checkoutInfoManager = locator<CheckoutInfoManager>();

  Future<ManagerState> editAddress(
      {required AddressesRequest request, addressId}) async {
    var managerState = ManagerState.LOADING;
    inState.add(ManagerState.LOADING);
    await _editAddressRepo.editAddress(request, addressId).then((result) {
      if (result.status == true) {
        inState.add(ManagerState.SUCCESS);
        checkoutInfoManager.selectAddressSubject.value = result.data;


        if(locator<PrefsService>().userObj == null){
          checkoutInfoManager.execute();
        }

        managerState = ManagerState.SUCCESS;
        // locator<NavigationService>().goBack();
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
