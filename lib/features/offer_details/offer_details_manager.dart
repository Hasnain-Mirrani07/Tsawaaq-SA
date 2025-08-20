import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/offer_details/offer_details_repo.dart';
import 'package:tasawaaq/features/offer_details/offer_details_response.dart';

class OfferDetailsManager extends Manager {
  final PublishSubject<OfferDetailsResponse> _subject =
      PublishSubject<OfferDetailsResponse>();


  Stream<OfferDetailsResponse> get offerDetails$  => _subject.stream;




  execute({required int id}) async{
    await OfferDetailsRepo.getOfferDetails(id: id).then((result) {
      if (result.error == null) {
        _subject.add(result);
      } else {
        _subject.addError(result.error);
      }
    });
  }


  @override
  void clearSubject() {}

  @override
  void dispose() {
    _subject.close();
  }
}
