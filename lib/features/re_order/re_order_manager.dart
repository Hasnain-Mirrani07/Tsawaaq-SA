import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/features/re_order/re_order_repo.dart';
import 'package:tasawaaq/features/re_order/re_order_response.dart';

class ReOrderManager extends Manager<ReOrderResponse> {
  final toast = locator<ToastTemplate>();

  final PublishSubject<ReOrderResponse> _subject =
      PublishSubject<ReOrderResponse>();

  Stream<ReOrderResponse> get reOrder$  => _subject.stream;


  execute({required int id}) async{
    await ReOrderRepo.getReOrder(id).then((result) {
      if (result.error == null) {
        _subject.add(result);
        if(result.status ==  true){
          locator<NavigationService>().pushNamedTo(AppRouts.CartPage,);
        }else{
          toast.show("${result.message}");
        }


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
