import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/cart/cart_count/cart_count_repo.dart';
import 'package:tasawaaq/features/cart/cart_count/cart_count_response.dart';

class CartCountManager extends Manager<CartCountResponse> {
  final PublishSubject<CartCountResponse> _subject =
      PublishSubject<CartCountResponse>();

  Stream<CartCountResponse> get cartCount$ => _subject.stream;

  execute() async {
    await CartCountRepo.getCartCount().then((result) {
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
