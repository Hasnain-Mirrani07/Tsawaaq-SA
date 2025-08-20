import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/cart/cart_actions/cart_action_repo.dart';
import 'package:tasawaaq/features/cart/cart_actions/cart_actions_request.dart';
import 'package:tasawaaq/features/cart/cart_actions/cart_managers/cart_list_manager.dart';
import 'package:tasawaaq/features/cart/cart_count/cart_count_manager.dart';

class AddManager extends Manager {
  String? errorDescription;

  final PublishSubject<ManagerState> _stateSubject = PublishSubject();
  final prefs = locator<PrefsService>();
  final toast = locator<ToastTemplate>();
  final cartCountManager = locator<CartCountManager>();
  final cartListManager = locator<CartListManager>();

  Stream<ManagerState> get state$ => _stateSubject.stream;
  Sink<ManagerState> get inState => _stateSubject.sink;

  Future<ManagerState> addToCart({required AddToCartRequest request}) async {
    var managerState = ManagerState.LOADING;
    inState.add(ManagerState.LOADING);
    await CartActionsRepo.addToCart(request).then((result) {
      if (result.status == true) {
        inState.add(ManagerState.SUCCESS);
        // toast.show('${result.message}');
        cartCountManager.execute();
        cartListManager.inCartList = result;
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
