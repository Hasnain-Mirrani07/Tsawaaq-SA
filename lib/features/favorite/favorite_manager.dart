import 'package:rxdart/subjects.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/favorite/favorite_repo.dart';
import 'package:tasawaaq/features/favorite/favorite_response.dart';

class FavoriteManager extends Manager {
  final PublishSubject<FavoriteResponse> _subject =
      PublishSubject<FavoriteResponse>();

  Stream<FavoriteResponse> get favorites$ => _subject.stream;

  execute() async {
    await FavoriteRepo.getWishList().then(
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
  void clearSubject() {
    // TODO: implement clearSubject
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
