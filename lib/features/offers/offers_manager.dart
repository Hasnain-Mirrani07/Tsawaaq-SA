import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/offers/offers_repo.dart';
import 'package:tasawaaq/features/offers/offers_response.dart';

class OffersManager extends Manager {


  final PublishSubject<OffersResponse> _subject =
  PublishSubject<OffersResponse>();

  Stream<OffersResponse> get offer$  => _subject.stream;




  execute() async{
    await OffersRepo.getOffers().then((result) {
      if (result.error == null) {
        _subject.add(result);
      } else {
        _subject.addError(result.error);
      }
    });
  }


  @override
  void clearSubject() {
  }

  @override
  void dispose() {
    _subject.close();
  }
}
