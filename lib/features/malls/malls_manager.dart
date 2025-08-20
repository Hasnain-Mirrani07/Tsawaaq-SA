import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/malls/malls_repo.dart';
import 'package:tasawaaq/features/malls/malls_response.dart';

class MallsManager extends Manager<MallsResponse> {
  final PublishSubject<MallsResponse> _subject = PublishSubject<MallsResponse>();

  Stream<MallsResponse> get malls$  => _subject.stream;



  execute() async{
    await MallsRepo.getMalls().then((result) {
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
