import 'package:flutter/foundation.dart';
import 'package:rxdart/subjects.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/all_stores/all_stores_repo.dart';
import 'package:tasawaaq/features/all_stores/all_stores_response.dart';

class AllStoresManager extends Manager {
  final ValueNotifier<int> selectedIndex = ValueNotifier(0);

  final PublishSubject<StoresResponse> _subject =
      PublishSubject<StoresResponse>();

  Stream<StoresResponse> get stores$ => _subject.stream;

  execute({int id = 0}) async {
    await StoresRepo.getStores(id: id).then((result) {
      if (result.error == null) {
        _subject.add(result);
      } else {
        _subject.addError(result.error);
      }
    });
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
