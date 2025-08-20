import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/mall_details/mall_details_repo.dart';
import 'package:tasawaaq/features/mall_details/mall_details_response.dart';

class MallDetailsManager extends Manager {
  final ValueNotifier<int> selectedIndex = ValueNotifier(0);


  final PublishSubject<MallResponse> _subject =
  PublishSubject<MallResponse>();

  Stream<MallResponse> get mallDetails$  => _subject.stream;




  execute({int id = 0,mallId}) async{
    await MallRepo.getMall(id: id,mallId:mallId).then((result) {
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
    _subject.close();
    // TODO: implement dispose
  }
}
