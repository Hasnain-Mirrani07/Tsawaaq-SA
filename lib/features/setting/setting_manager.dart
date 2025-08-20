import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_core/fcm/pushNotification_service.dart';
import 'package:tasawaaq/features/setting/setting_repo.dart';
import 'package:tasawaaq/features/setting/setting_response.dart';

class SettingsManager extends Manager<SettingResponse> {
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

  ValueNotifier<bool> notificationsSwitch = ValueNotifier(locator<PrefsService>().hasSubscribeToTopicFirebase);
  void switchNotifications(bool newValue) {
    notificationsSwitch.value = newValue;
  }

  bool get notificationsStatus=>notificationsSwitch.value;

  final PublishSubject<SettingResponse> _subject = PublishSubject<SettingResponse>();

  Stream<SettingResponse> get settings$  => _subject.stream;


  execute() async{
    await SettingRepo.getSetting().then((result) {
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
