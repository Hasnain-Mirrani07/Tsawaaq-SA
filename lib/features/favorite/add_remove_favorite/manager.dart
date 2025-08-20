import 'dart:io';

import 'package:rxdart/subjects.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/cart/cart_actions/cart_managers/cart_list_manager.dart';
import 'package:tasawaaq/features/favorite/add_remove_favorite/repo.dart';
import 'package:tasawaaq/features/favorite/favorite_manager.dart';
import 'package:tasawaaq/features/home/home_manager.dart';

class AddRemoveFavoriteManager extends Manager {
  String? errorDescription;

  final PublishSubject<ManagerState> _stateSubject = PublishSubject();
  final prefs = locator<PrefsService>();
  final toast = locator<ToastTemplate>();
  final cartListManager = locator<CartListManager>();
  final favoriteManager = locator<FavoriteManager>();
  final homeManager = locator<HomeManager>();
  // final loadingManager = locator<LoadingManager>();

  Stream<ManagerState> get state$ => _stateSubject.stream;
  Sink<ManagerState> get inState => _stateSubject.sink;

  Future<ManagerState> addRemoveFavorite({required id}) async {
    var managerState = ManagerState.LOADING;
    // loadingManager.inState.add(managerState);
    inState.add(ManagerState.LOADING);
    await AddRemoveFavoriteRepo.addRemoveFavorite(id).then((result) {
      if (result.status == true) {
        inState.add(ManagerState.SUCCESS);
        // toast.show('${result.message}');
        cartListManager.execute();
        favoriteManager.execute();
        homeManager.execute();
        // loadingManager.inState.add(ManagerState.SUCCESS);
        managerState = ManagerState.SUCCESS;
      } else if (result.status == false) {
        inState.add(ManagerState.ERROR);
        errorDescription = result.message;
        managerState = ManagerState.ERROR;
        // loadingManager.inState.add(ManagerState.IDLE);
      } else if (result.error.error is SocketException) {
        inState.add(ManagerState.SOCKET_ERROR);
        errorDescription = prefs.appLanguage == 'en'
            ? 'No Internet Connection'
            : 'لا يوجد إتصال بالشبكة';
        // loadingManager.inState.add(managerState);

        managerState = ManagerState.SOCKET_ERROR;
      } else {
        inState.add(ManagerState.UNKNOWN_ERROR);
        errorDescription = prefs.appLanguage == 'en'
            ? "Unexpected error occurred"
            : 'حدث خظأ غير متوقع';
        // loadingManager.inState.add(ManagerState.IDLE);

        managerState = ManagerState.UNKNOWN_ERROR;
      }
    });
    return managerState;
  }

  @override
  void clearSubject() {
    // TODO: implement clearSubject
  }

  @override
  void dispose() {
    _stateSubject.close();
  }
}
