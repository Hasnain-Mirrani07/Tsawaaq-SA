import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/home/home_response.dart';
import 'package:tasawaaq/features/search/search_post/search_post_repo.dart';
import 'package:tasawaaq/features/search/search_post/search_post_response.dart';
import 'package:tasawaaq/features/search/widgets/search_by_widget.dart';
import 'package:flutter/material.dart';

class SearchManager extends Manager<SearchPostResponse> {


  List<SearchItem> searchItemsList = [];
  List<Products> data = [];
  List<int> dataIds = [];

  final BehaviorSubject<List<SearchItem>> selectedSearchItemsSubject = BehaviorSubject.seeded([]);

  List<String> typeSubject = [];
  String keyWordSubject = "";


  int currentPageNum = 1;
  int maxPageNum = 5;
  int total = 0;

  final prefs = locator<PrefsService>();





  PublishSubject<SearchPostResponse> _mainSubject =
  PublishSubject<SearchPostResponse>();

  Stream<SearchPostResponse> get response$ => _mainSubject.stream;

  ScrollController scrollController = ScrollController();

  void reCallManager(
      // {type,keyWord}
      ) {
    Stream.fromFuture(
      SearchPostRepo.getSearchResults(
          page: currentPageNum,
          // type: type??"",
          // keyword: keyWord??"",
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

  // void resetSearchAttributesManager() {
  //
  // }

  void resetManager() {
    currentPageNum = 1;
    maxPageNum = 5;
    total = 0;
    data.clear();
    dataIds.clear();
    searchItemsList.clear();
    _mainSubject.drain();
    typeSubject.clear();
    keyWordSubject = "";
    selectedSearchItemsSubject.sink.add([]);
    selectedSearchItemsSubject.drain();
  }



  SearchManager() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        await loadMore();
      }
    });
  }

  Future<void> loadMore(
      // {type,keyWord}
      ) async {
    if (maxPageNum >= currentPageNum) {
      inPaginationState.add(PaginationState.LOADING);
      await SearchPostRepo.getSearchResults(
        page: currentPageNum,
        // type: type??"",
        // keyword: keyWord??"",
      )
          .then((value) {
        if (value.error == null) {
          if (value.status == true) {
            inPaginationState.add(PaginationState.SUCCESS);
            // currentPageNum++;
            currentPageNum = value.pagination!.currentPage! + 1;
            maxPageNum = value.pagination!.lastPage??0;
            _mainSubject.add(value);
          }
        } else {
          inPaginationState.add(PaginationState.ERROR);
        }
      });
    }
  }

  Future<void> onErrorLoadMore(
      // {type,keyWord}
      ) async {
    if (maxPageNum >= currentPageNum) {
      inPaginationState.add(PaginationState.LOADING);
      await SearchPostRepo.getSearchResults(
        page: currentPageNum,
        // type: type??"",
        // keyword: keyWord??"",
      )
          .then((value) {
        if (value.error == null) {
          if (value.status == true) {
            inPaginationState.add(PaginationState.SUCCESS);
            // currentPageNum++;
            currentPageNum = value.pagination!.currentPage! + 1;
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
    selectedSearchItemsSubject.close();
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


