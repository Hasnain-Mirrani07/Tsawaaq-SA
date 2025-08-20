import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/home/home_repo.dart';
import 'package:tasawaaq/features/home/home_response.dart';

class HomeManager extends Manager<HomeResponse> {
  final PublishSubject<HomeResponse> _subject = PublishSubject<HomeResponse>();
  List<Socials> homeSocial = [];

  Stream<HomeResponse> get home$ => _subject.stream;

  execute() async {
    await HomeRepo.getHome().then(
      (result) {
        if (result.error == null) {
          _subject.add(result);
        } else {
          _subject.addError(result.error);
        }
      },
    );
  }


  @override
  void dispose() {}

  @override
  void clearSubject() {}
}
