import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/filter/filter_repo.dart';
import 'package:tasawaaq/features/filter/filter_response.dart';

class FilterManager extends Manager<FilterResponse> {
  List<int> brandsList = [];
  List<int> cateList = [];
  List<int> typeList = [];
  List<int> sizeList = [];
  List<int> colorList = [];

  /// sortIndexNotifier
  final ValueNotifier<String> _sortIndexNotifier = ValueNotifier("");
  String get sortIndex => _sortIndexNotifier.value;
  set sortIndex(String value) => _sortIndexNotifier.value = value;
  ValueNotifier<String> sortIndexNotifier() => _sortIndexNotifier;

  /// brandIndexSubject
  final BehaviorSubject<List<int>> brandIndexSubject =
      BehaviorSubject.seeded([]);

  String? currency;

  /// categoryIndexNotifier
  final BehaviorSubject<List<int>> cateIndexSubject =
      BehaviorSubject.seeded([]);

  /// typeIndexNotifier
  final BehaviorSubject<List<int>> typeIndexSubject =
      BehaviorSubject.seeded([]);

  /// sizeIndexNotifier
  final BehaviorSubject<List<int>> sizeIndexSubject =
      BehaviorSubject.seeded([]);

  /// RangeValues
  // final ValueNotifier<RangeValues> _priceRangeNotifier = ValueNotifier(RangeValues(1, 1000));
  // RangeValues get priceRange => _priceRangeNotifier.value;
  // set priceRange(RangeValues value) => _priceRangeNotifier.value = value;
  // ValueNotifier<RangeValues> priceRangeNotifier() => _priceRangeNotifier;

  final BehaviorSubject<RangeValues> priceRangeSubject = BehaviorSubject();

  final BehaviorSubject<String> startPriceSubject = BehaviorSubject();
  final BehaviorSubject<String> endPriceSubject = BehaviorSubject();

  /// colorIndexNotifier
  final BehaviorSubject<List<int>> colorIndexSubject =
      BehaviorSubject.seeded([]);

  final PublishSubject<FilterResponse> _subject =
      PublishSubject<FilterResponse>();

  Stream<FilterResponse> get filter$ => _subject.stream;

  execute({categoryId, storeId}) async {
    await FilterRepo.getFilter(categoryId: categoryId, storeId: storeId).then(
      (result) {
        if (result.error == null) {
          _subject.add(result);
        } else {
          _subject.addError(result.error);
        }
      },
    );
  }



  void resetFilter() {
    sortIndex = "";
    startPriceSubject.sink.add("");
    endPriceSubject.sink.add("");
    brandIndexSubject.sink.add([]);
    cateIndexSubject.sink.add([]);
    typeIndexSubject.sink.add([]);
    sizeIndexSubject.sink.add([]);
    colorIndexSubject.sink.add([]);
    brandsList.clear();
    colorList.clear();
    sizeList.clear();
    cateList.clear();
    typeList.clear();
    // priceRange = RangeValues(1, 1000);
  }

  void dispose() {
    _subject.close();
    brandIndexSubject.close();
    cateIndexSubject.close();
    typeIndexSubject.close();
    colorIndexSubject.close();
    sizeIndexSubject.close();
    priceRangeSubject.close();
    startPriceSubject.close();
    endPriceSubject.close();
  }

  @override
  void clearSubject() {
    // TODO: implement clearSubject
  }
}
