import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_core/fcm/FcmTokenManager.dart';
import 'package:tasawaaq/app_core/fcm/localNotificationService.dart';
import 'package:tasawaaq/app_core/locator.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/features/order_details/order_details_page.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final prefs = locator<PrefsService>();


  //  xxx (){
  // FirebaseMessaging.onBackgroundMessage((message)async {
  // await _fcm.getInitialMessage().then((_message) {
  // if(_message!=null){
  // _serializeAndNavigate(_message);
  // }
  // });
  // });
  // }

  Future initialize() async {

    // if(prefs.hasSubscribeToTopicFirebase == true ) {
      _fcm.requestPermission(alert: true, badge: true, sound: true);

      _fcm.getToken().then((token) {
        print(token);
        locator<FcmTokenManager>().inFcm.add(token!);
      });

      if(Platform.isIOS) {
        if(prefs.appLanguage == 'en'){
          _fcm.unsubscribeFromTopic('IOSAR');
          _fcm.subscribeToTopic('IOSEN');

        }else{
          _fcm.unsubscribeFromTopic('IOSEN');
          _fcm.subscribeToTopic('IOSAR');
        }
      }
      else{
        if(prefs.appLanguage == 'en'){
          _fcm.unsubscribeFromTopic('AndroidAr');
          _fcm.subscribeToTopic('AndroidEn');

        } else{
          _fcm.unsubscribeFromTopic('AndroidEn');
          _fcm.subscribeToTopic('AndroidAr');

        }
      }

      // FirebaseMessaging.onMessageOpenedApp
      FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {

        print("onMessage");
        var notificationData = remoteMessage.data;
        var notificationHead = remoteMessage.notification;
        if (remoteMessage.notification!.title!.isNotEmpty) {
          var title = notificationHead?.title;
          var body = notificationHead?.body;
          var id = notificationData['model_id'];
          var type = notificationData['model'];

          if(type != null){
            locator<FcmTokenManager>().notificationType = type;
          }

          locator<LocalNotificationService>().showNotification("$title", "$body", "$id");
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
        print("onMessage");
        _serializeAndNavigate(remoteMessage);
      });

      // FirebaseMessaging.onBackgroundMessage((message)async {
      //   await _fcm.getInitialMessage().then((_message) {
      //     if(_message!=null){
      //       _serializeAndNavigate(_message);
      //     }
      //   });
      // });

      // FirebaseMessaging.onBackgroundMessage(RemoteMessage message) async {
      //   print("onMessage");
      //   await _fcm.getInitialMessage().then((_message) {
      //     if(_message!=null){
      //       _serializeAndNavigate(_message);
      //     }
      //   });

      // return Future.value();
      // }

    }
  //   else{
  //     if(Platform.isIOS) {
  //       if(prefs.appLanguage == 'en'){
  //         _fcm.unsubscribeFromTopic('IOSEN');
  //       }else{
  //         _fcm.unsubscribeFromTopic('IOSAR');
  //         // _fcm.isSupported()
  //       }
  //     }
  //     else{
  //       if(prefs.appLanguage == 'en'){
  //         _fcm.unsubscribeFromTopic('AndroidEn');
  //       } else{
  //         _fcm.unsubscribeFromTopic('AndroidAr');
  //       }
  //     }
  //     _fcm.subscribeToTopic('Nothing');
  //     // _fcm.deleteToken();
  //     // _fcm.setAutoInitEnabled(false);
  //     // _fcm.isAutoInitEnabled;
  //     // _fcm.getNotificationSettings().ignore();
  //
  //
  //   // }
  //
  // }
  void _serializeAndNavigate(RemoteMessage message) {

    if(message.data['model'] == "order"){
      // if (int.parse(message.data['order_id']) != 0) {
      locator<NavigationService>().pushNamedTo(
          AppRouts.OrderDetailsPage,
          arguments: OrderDetailsPageArgs(
            orderId: message.data['model_id'],
            // orderStatus: ordersItems![index].status
          )
      );
      // }
    }
  }
}