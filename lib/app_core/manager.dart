import 'app_core.dart';

abstract class Manager<T> {
  Stream<ApiResponse<T>>? streamDataObj() => null;

  Stream<ApiResponse<List<T>>>? streamDataList() => null;

  Future<ApiResponse<T>>? futureDataObj() => null;
  Future<ApiResponse<List<T>>>? futureDataList() => null;
  // For Api Post.
  void getFuture() async => null;
  // Future<List<T>> futureDataList() => null;
  void dispose();

  void clearSubject();
}

enum ManagerState {
  IDLE,
  LOADING,
  SUCCESS,
  ERROR,
  SOCKET_ERROR,
  UNKNOWN_ERROR,
}

// extension ManagerStateMsg on ManagerState {
//   String msg(ManagerState state) {
//     switch (state) {
//       case ManagerState.SUCCESS:
//         return '';
//         break;
//       default:
//         return '';
//     }
//   }
// }
