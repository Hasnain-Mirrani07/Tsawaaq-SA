import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_core/fcm/pushNotification_service.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/setting/pages/page.dart';
import 'package:tasawaaq/features/setting/setting_manager.dart';
import 'package:tasawaaq/features/setting/setting_response.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {


  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.use<SettingsManager>().execute();
    });
  }

  @override
  Widget build(BuildContext context) {
    final settingsManager = context.use<SettingsManager>();
    final prefs = locator<PrefsService>();
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;


    return Observer<SettingResponse>(
        onRetryClicked: () {
          settingsManager.execute();
        },
        manager: settingsManager,
        stream: settingsManager.settings$,
        onSuccess: (context, settingSnapshot) {
        return ListView(
          padding: EdgeInsets.symmetric(vertical: 16),
          children: [
            ListTile(
              // onTap: () {},
              title: Text(
                "${context.translate(AppStrings.LANGUAGE)}",
                style: AppFontStyle.greyMedTitleBold,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'AR',
                    style: AppFontStyle.greyMedTitleBold,
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: settingsManager.langSwitch,
                    builder: (_, value, __) {
                      return CupertinoSwitch(
                          value: value,
                          trackColor: AppStyle.yellowButton,
                          activeColor: AppStyle.yellowButton,
                          onChanged: (newValue) {
                            settingsManager.switchLang(newValue);
                            locator<PushNotificationService>().initialize();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                AppRouts.TABS_WIDGET,
                                (Route<dynamic> route) => false);
                          });
                    },
                  ),
                  Text(
                    'EN',
                    style: AppFontStyle.greyMedTitleBold,
                  ),
                ],
              ),
            ),
            Divider(
              indent: 15,
              endIndent: 15,
            ),
            ListTile(
              // onTap: () {
              //
              //
              // },
              title: Text(
                "${context.translate(AppStrings.NOTIFICATIONS)}",
                style: AppFontStyle.greyMedTitleBold,
              ),
              trailing: ValueListenableBuilder<bool>(
                valueListenable: settingsManager.notificationsSwitch,
                builder: (_, value, __) => CupertinoSwitch(
                    value: value,
                    activeColor: AppStyle.yellowButton,
                    onChanged: (newValue) async {
                      locator<PushNotificationService>().initialize();
                      settingsManager.switchNotifications(newValue);
                      print("settingsManager.notificationsStatus => ${settingsManager.notificationsStatus}");
                      prefs.hasSubscribeToTopicFirebase = settingsManager.notificationsStatus;
                      WidgetsFlutterBinding.ensureInitialized();
                      // await Firebase.initializeApp();
                      locator<PushNotificationService>().initialize();
                      // await Firebase.initializeApp().then((value) => value.options.);
                      //     .then((value) {
                      //   locator<PushNotificationService>().initialize().then((value) => FirebaseMessaging.instance.app.delete());
                      // });

                      print("prefs.hasSubscribeToTopicFirebase ${prefs.hasSubscribeToTopicFirebase}");
                    }),
              ),
            ),
            Divider(
              indent: 15,
              endIndent: 15,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: settingSnapshot.data!.length,
              separatorBuilder: (_, index) => Divider(
                indent: 15,
                endIndent: 15,
              ),
              itemBuilder: (_, index) => ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AppRouts.ServicesTemplatePage,
                    arguments: PagesArgs(
                      hasDrawer: false,
                        id: int.parse("${settingSnapshot.data![index].id.toString()}"),
                    ),
                  );
                },
                title: Text(
                  "${settingSnapshot.data![index].title}",
                  style: AppFontStyle.greyMedTitleBold,
                ),
                trailing: Icon(Icons.arrow_forward_ios_sharp),
              ),
            ),
            Divider(
              indent: 15,
              endIndent: 15,
            ),
          ],
        );
      }
    );
  }
}
