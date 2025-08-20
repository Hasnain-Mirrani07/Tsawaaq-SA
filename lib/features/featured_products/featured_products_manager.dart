import 'package:flutter/material.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/features/featured_products/featured_products_repo.dart';
import 'package:tasawaaq/features/featured_products/featured_products_response.dart';
import 'package:tasawaaq/features/home/home_response.dart';

class FeaturedProductsManager extends Manager<FeaturedProductsResponse> {
  int currentPageNum = 1;
  int maxPageNum = 5;
  int total = 0;

  final prefs = locator<PrefsService>();



  List<Products> data = [];
  List<int> dataIds = [];

  PublishSubject<FeaturedProductsResponse> _mainSubject = PublishSubject<FeaturedProductsResponse>();

  Stream<FeaturedProductsResponse> get response$ => _mainSubject.stream;

  ScrollController scrollController = ScrollController();

  void reCallManager() {
    Stream.fromFuture(FeaturedProductRepo.getFeaturedProducts(page: currentPageNum,),
    ).listen((result) {
      if( result.error == null){
        _mainSubject.add(result);
        currentPageNum = result.pagination!.currentPage! + 1;
      }else{
        _mainSubject.addError(result.error);
      }
    });
  }


  void resetManager() {
    // isFirstTime = false;
    dataIds.clear();
    data.clear();
    currentPageNum = 1;
    maxPageNum = 5;
    total = 0;
    // data.removeRange(0, data.length);
    // _mainSubject.done;
    _mainSubject.drain();
  }

  FeaturedProductsManager() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        await loadMore();
      }
    });
  }

  Future<void> loadMore() async {


    if (maxPageNum >=  currentPageNum) {
      inPaginationState.add(PaginationState.LOADING);
      await FeaturedProductRepo.getFeaturedProducts(
          page: currentPageNum,)
          .then((value) {

        if (value.error == null) {
          if (value.status == true) {
            currentPageNum= value.pagination!.currentPage! + 1;

            inPaginationState.add(PaginationState.SUCCESS);
            maxPageNum = value.pagination!.lastPage!;
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
      await FeaturedProductRepo.getFeaturedProducts(
          page: currentPageNum,
      )
          .then((value) {

        if (value.error == null) {
          if (value.status == true) {
            currentPageNum = value.pagination!.currentPage! +1;
            inPaginationState.add(PaginationState.SUCCESS);

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
  Stream<PaginationState> get paginationState$ => _paginationStateSubject.stream;
  Sink<PaginationState> get inPaginationState => _paginationStateSubject.sink;

  @override
  void dispose() {
    _mainSubject.close();
    _paginationStateSubject.close();
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
