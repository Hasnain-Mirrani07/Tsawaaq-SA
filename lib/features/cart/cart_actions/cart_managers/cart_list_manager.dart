import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/cart/cart_actions/cart_action_repo.dart';
import 'package:tasawaaq/features/cart/cart_actions/cart_actions_response.dart';

class CartListManager extends Manager<CartActionsResponse> {
  final PublishSubject<CartActionsResponse> _subject =
      PublishSubject<CartActionsResponse>();

  set inCartList(CartActionsResponse response) => _subject.sink.add(response);

  Stream<CartActionsResponse> get cartList$ => _subject.stream;

  execute() async {
    await CartActionsRepo.getCartList().then((result) {
      if (result.error == null) {
        _subject.add(result);
      } else {
        _subject.addError(result.error);
      }
    });
  }


  @override
  void dispose() {}

  @override
  void clearSubject() {}
}
