import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/about_mall_and_store/about_store/about_store_repo.dart';
import 'package:tasawaaq/features/about_mall_and_store/about_store/about_store_response.dart';

class AboutStoreManager extends Manager<AboutStoreResponse> {
  final PublishSubject<AboutStoreResponse> _subject =
      PublishSubject<AboutStoreResponse>();

  Stream<AboutStoreResponse> get aboutStore$  => _subject.stream;

  execute({required int id}) async{
    await AboutStoreRepo.getAboutStore(id).then((result) {
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
