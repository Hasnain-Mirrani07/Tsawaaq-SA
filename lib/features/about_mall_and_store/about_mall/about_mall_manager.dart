import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/about_mall_and_store/about_mall/about_mall_repo.dart';
import 'package:tasawaaq/features/about_mall_and_store/about_mall/about_mall_response.dart';

class AboutMallManager extends Manager<AboutMallResponse> {
  final PublishSubject<AboutMallResponse> _subject =
      PublishSubject<AboutMallResponse>();

  Stream<AboutMallResponse> get aboutMall$  => _subject.stream;

  execute({required int id}) async{
   await AboutMallRepo.getAboutMall(id).then((result) {
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
