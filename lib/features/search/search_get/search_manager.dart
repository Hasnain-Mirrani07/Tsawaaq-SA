import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/search/search_get/search_repo.dart';
import 'package:tasawaaq/features/search/search_get/search_response.dart';

class SearchGetManager extends Manager<SearchGetResponse> {
  final PublishSubject<SearchGetResponse> _subject = PublishSubject<SearchGetResponse>();
  Stream<SearchGetResponse> get searchGet$  => _subject.stream;



  execute() async{
    await SearchRepo.getSearch().then((result) {
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
