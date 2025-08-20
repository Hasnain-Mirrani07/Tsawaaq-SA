import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/home/home_response.dart';
import 'package:tasawaaq/features/product_list/product_list_repo.dart';
import 'package:tasawaaq/features/product_list/product_list_response.dart';

class ProductListManager extends Manager {
  final ValueNotifier<int> selectedIndex = ValueNotifier(0);


  int currentPageNum = 1;
  int maxPageNum = 5;
  int total = 0;

  final prefs = locator<PrefsService>();


  List<Products> data = [];
  List<int> dataIds = [];



  BehaviorSubject<String> storeId = BehaviorSubject<String>.seeded("");
  BehaviorSubject<String> cateId = BehaviorSubject<String>.seeded("");

  PublishSubject<ProductListResponse> _mainSubject = PublishSubject<ProductListResponse>();

  Stream<ProductListResponse> get response$ => _mainSubject.stream;

  ScrollController scrollController = ScrollController();

  void reCallManager() {
    Stream.fromFuture(
      ProductListRepo.getProductList(
        page: currentPageNum,
        // word: searchController.text.isNotEmpty ? searchController.text : ''
      ),
    ).listen((result) {
      if(result.error == null){
        _mainSubject.add(result);
        currentPageNum = result.pagination!.currentPage! + 1;
      }else{
        _mainSubject.addError(result.error);
      }
    });
  }


  void resetManager() {
    currentPageNum = 1;
    maxPageNum = 5;
    total = 0;
    data.clear();
    dataIds.clear();
    _mainSubject.drain();
  }


  ProductListManager() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        await loadMore();
      }
    });
  }

  Future<void> loadMore() async {
    if (maxPageNum >= currentPageNum) {
      inPaginationState.add(PaginationState.LOADING);
      await ProductListRepo.getProductList(
          page: currentPageNum,
      )
          .then((value) {
        if (value.error == null) {
          if (value.status == true) {
            currentPageNum = value.pagination!.currentPage! + 1;
            inPaginationState.add(PaginationState.SUCCESS);
            maxPageNum = value.pagination!.lastPage??0;
            _mainSubject.add(value);
          }
        } else {
          inPaginationState.add(PaginationState.ERROR);
        }
      });
    }
  }

  Future<void> onErrorLoadMore() async {
    if (maxPageNum >= currentPageNum) {
      inPaginationState.add(PaginationState.LOADING);
      await ProductListRepo.getProductList(
          page: currentPageNum,
        // word: searchController.text.isNotEmpty ? searchController.text : ''
      )
          .then((value) {
        if (value.error == null) {
          if (value.status == true) {
            currentPageNum = value.pagination!.currentPage! + 1;
            inPaginationState.add(PaginationState.SUCCESS);
            // currentPageNum++;
            maxPageNum = value.pagination!.lastPage??0;
            _mainSubject.sink.add(value);
          }
        } else {
          inPaginationState.add(PaginationState.ERROR);
        }
      });
    }
  }

  final PublishSubject<PaginationState> _paginationStateSubject =
  PublishSubject<PaginationState>();
  Stream<PaginationState> get paginationState$ =>
      _paginationStateSubject.stream;
  Sink<PaginationState> get inPaginationState => _paginationStateSubject.sink;

  @override
  void dispose() {
    _mainSubject.close();
    _paginationStateSubject.close();
    storeId.close();
    cateId.close();
    // storeId.close();
  }

  @override
  void clearSubject() {}
}

enum PaginationState {
  LOADING,
  SUCCESS,
  ERROR,
  IDLE,
}
