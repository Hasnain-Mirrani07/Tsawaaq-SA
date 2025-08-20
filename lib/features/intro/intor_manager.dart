import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/intro/intro_repo.dart';
import 'package:tasawaaq/features/intro/intro_response.dart';

class IntroManager extends Manager<IntroResponse> {
  final PublishSubject<IntroResponse> _subject =
      PublishSubject<IntroResponse>();

  Stream<IntroResponse> get intro$  => _subject.stream;





  execute() async{
    await IntroRepo.getIntro().then((result) {
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
