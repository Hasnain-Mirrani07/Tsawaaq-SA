import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/product_details/product_details_repo.dart';
import 'package:tasawaaq/features/product_details/product_details_response.dart';

class ProductDetailsManager extends Manager<ProductDetailsResponse> {


  final ValueNotifier<int> indicatorNotifier = ValueNotifier(0);
  final ValueNotifier<int> quantityNotifier = ValueNotifier(1);

  final ValueNotifier<Options?> colorNotifier = ValueNotifier(null);
  final ValueNotifier<Sizes?> sizeNotifier = ValueNotifier(null);
  final PublishSubject<ProductDetailsResponse> _subject = PublishSubject<ProductDetailsResponse>();


  final BehaviorSubject<PricePbj> priceSubject = BehaviorSubject();
  final BehaviorSubject<int> maxForSizeSubject = BehaviorSubject();

  Stream<ProductDetailsResponse> get product$  => _subject.stream;





  execute({required int id}) async{
    await ProductDetailsRepo.getProductDetails(id).then((result) {
      if (result.error == null) {
        _subject.add(result);
      } else {
        _subject.addError(result.error);
      }
    });
  }

  @override
  void dispose() {
    priceSubject.close();
    maxForSizeSubject.close();
  }

  @override
  void clearSubject() {}
}


class PricePbj{
  dynamic originalPrice;
  dynamic price;
  PricePbj({this.price,this.originalPrice});
}