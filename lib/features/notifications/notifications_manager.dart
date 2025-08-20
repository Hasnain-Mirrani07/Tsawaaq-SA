import 'package:flutter/material.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/features/notifications/notifications_repo.dart';
import 'package:tasawaaq/features/notifications/notifications_response.dart';

class NotificationsManager extends Manager<NotificationsResponse> {
  int currentPageNum = 1;
  int maxPageNum = 5;
  int total = 0;

  final prefs = locator<PrefsService>();



  List<Data> data = [];
  List<int> dataIds = [];

  PublishSubject<NotificationsResponse> _mainSubject =
  PublishSubject<NotificationsResponse>();

  Stream<NotificationsResponse> get response$ => _mainSubject.stream;

  ScrollController scrollController = ScrollController();

  void reCallManager() {
    Stream.fromFuture(
      NotificationsRepo.getNotifications(
        page: currentPageNum,
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

  NotificationsManager() {
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
      await NotificationsRepo.getNotifications(
        page: currentPageNum,
      )
          .then((value) {
        if (value.error == null) {
          if (value.status == true) {
            inPaginationState.add(PaginationState.SUCCESS);
            currentPageNum = value.pagination!.currentPage! + 1;
            // currentPageNum++;
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
      await NotificationsRepo.getNotifications(
        page: currentPageNum,
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
