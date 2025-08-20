import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tasawaaq/app_core/fcm/FcmTokenManager.dart';
import 'package:tasawaaq/app_core/locator.dart';
import 'package:tasawaaq/app_core/services/navigation_service.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/features/order_details/order_details_page.dart';

////////////////////////////////////////////////////////////////////////////////
// LocalNotification
////////////////////////////////////////////////////////////////////////////////

class LocalNotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  initializeLocalNotification() async {
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@drawable/notifications_icon');
    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(requestAlertPermission: true, requestBadgePermission: true, requestSoundPermission: true);

    // final MacOSInitializationSettings initializationSettingsMacOS =
    // MacOSInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  void showNotification(
    title,
    body,
    id,
  ) async {
    var android = const AndroidNotificationDetails('channelId', 'channelName', channelDescription: 'channelDescription', importance: Importance.max, priority: Priority.high, showWhen: false);
    var ios = DarwinNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: ios);
    await flutterLocalNotificationsPlugin.show(0, '$title', '$body', platform, payload: '$id');
  }

  Future<dynamic> onDidReceiveNotificationResponse(payload) async {
    if (locator<FcmTokenManager>().notificationType == "order") {
      if (payload != null) {
        if ("$payload" != "") {
          locator<NavigationService>().pushNamedTo(AppRouts.OrderDetailsPage,
              arguments: OrderDetailsPageArgs(
                orderId: payload,
                // orderStatus: ordersItems![index].status
              ));
        }
      }
    }
  }

  Future onDidReceiveLocalNotification(int? id, String? title, String? body, String? payload) async {
    if (locator<FcmTokenManager>().notificationType == "order") {
      if (payload != null) {
        if ("$payload" != "") {
          print("IOS onDidReceiveLocalNotification");
          locator<NavigationService>().pushNamedTo(AppRouts.OrderDetailsPage,
              arguments: OrderDetailsPageArgs(
                orderId: payload,
                // orderStatus: ordersItems![index].status
              ));
        }
      }
    }

    // display a dialog with the notification details, tap ok to go to another page
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) => CupertinoAlertDialog(
    //     title: Text(title),
    //     content: Text(body),
    //     actions: [
    //       CupertinoDialogAction(
    //         isDefaultAction: true,
    //         child: Text('Ok'),
    //         onPressed: () async {
    //           Navigator.of(context, rootNavigator: true).pop();
    //           await Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => SecondScreen(payload),
    //             ),
    //           );
    //         },
    //       )
    //     ],
    //   ),
    // );
  }
}
