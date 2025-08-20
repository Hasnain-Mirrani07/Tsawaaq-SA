import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/categories/categories_repo.dart';
import 'package:tasawaaq/features/categories/categories_response.dart';

class CategoriesManager extends Manager<CategoriesResponse> {
  final PublishSubject<CategoriesResponse> _subject =
      PublishSubject<CategoriesResponse>();

  Stream<CategoriesResponse> get categories$ => _subject.stream;

  execute() async {
    await CategoriesRepo.getCategories().then((result) {
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
