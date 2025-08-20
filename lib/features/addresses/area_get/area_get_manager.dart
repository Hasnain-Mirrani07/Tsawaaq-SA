import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/addresses/add_address/add_address_response.dart';
import 'package:tasawaaq/features/addresses/area_get/area_get_repo.dart';
import 'package:tasawaaq/features/addresses/area_get/area_get_response.dart';

class AreaGetManager extends Manager<AreaResponse> {
  final BehaviorSubject<AreaResponse> _subject = BehaviorSubject<AreaResponse>();
  Stream<AreaResponse> get ereas$ => _subject.stream;


  List<Area> areaSearchList = [];

  // final BehaviorSubject<List<Area>> areaSearchListSubject = BehaviorSubject<List<Area>>();

  final BehaviorSubject<List<Area>> areaSearchListSubject =
  BehaviorSubject<List<Area>>();

  void resetAreasList(){
    areaSearchList.clear();
    areaSearchList = List.from(_subject.value.data!);
    areaSearchListSubject.sink.add(areaSearchList);
  }

  void searchInAreas({required String word}){
    areaSearchList.clear();
    for (var area in _subject!.value!.data!) {
      if("${area.name!.toLowerCase()}".contains(word.toLowerCase())){
        areaSearchList.add(area);
      }
    }
    areaSearchListSubject.sink.add(areaSearchList);
  }
  //
  // @override
  //   Stream.fromFuture(AreaGetRepo.getArea()).listen((result) {
  //     if (result.error == null) {
  //       _subject.add(result);
  //       resetAreasList();
  //       areaSearchList = List.from(result.data!);
  //       areaSearchListSubject.sink.add(areaSearchList);
  //     } else {
  //       _subject.addError(result.error);
  //     }
  //   });
  //   return _subject.stream;
  // }


  execute() async {
    await AreaGetRepo.getArea().then(
          (result) {
            if (result.error == null) {
              _subject.add(result);
              resetAreasList();
              areaSearchList = List.from(result.data!);
              areaSearchListSubject.sink.add(areaSearchList);
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


// import 'package:rxdart/rxdart.dart';
// import 'package:tasawaaq/app_core/app_core.dart';
// import 'package:tasawaaq/features/addresses/area_get/area_get_repo.dart';
// import 'package:tasawaaq/features/addresses/area_get/area_get_response.dart';
//
// class AreaGetManager extends Manager<AreaResponse> {
//   final PublishSubject<AreaResponse> _subject = PublishSubject<AreaResponse>();
//
//   @override
//     Stream.fromFuture(AreaGetRepo.getArea()).listen((result) {
//       if (result.error == null) {
//         _subject.add(result);
//       } else {
//         _subject.addError(result.error);
//       }
//     });
//     return _subject.stream;
//   }
//
//   @override
//   void dispose() {}
//
//   @override
//   void clearSubject() {}
// }
