import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/setting/pages/page_repo.dart';
import 'package:tasawaaq/features/setting/pages/page_response.dart';

class PageManager extends Manager<PageResponse> {
  ValueNotifier<bool> langSwitch =
      ValueNotifier(locator<PrefsService>().appLanguage == 'en' ? true : false);
  final langManager = locator<AppLanguageManager>();

  /// if false -> AR , if true -> EN
  void switchLang(bool newValue) {
    langSwitch.value = newValue;
    if (newValue) {
      langManager.changeLanguage(Locale('en'));
    } else {
      langManager.changeLanguage(Locale('ar'));
    }
  }

  ValueNotifier<bool> notificationsSwitch = ValueNotifier(true);
  void switchNotifications(bool newValue) {
    notificationsSwitch.value = newValue;
  }

  final PublishSubject<PageResponse> _subject = PublishSubject<PageResponse>();

  Stream<PageResponse> get pages$  => _subject.stream;




  execute({required int pageId}) async{
    await PageRepo.getPage(pageId).then((result) {
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
