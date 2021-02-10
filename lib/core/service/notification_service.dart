import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fun_alarm/core/configs/configs.dart';
import 'package:fun_alarm/core/service/background_service.dart';
import 'package:fun_alarm/router/router.dart';

class NotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final BackgroundService _backgroundService;

  NotificationService(this._backgroundService);

  initialize() async {
    await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('hour_glass');
    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);
  }

  Future<dynamic> onSelectNotification(String name) {
    print('onselect $name');
    switch(name){
      case('Alarm'):
        navigatorKey.currentState.pushNamed(RouteName.ringAlarmPage);
        break;
      default: break;
    }
  }

  Future onDidReceiveLocalIosNotification(int id, String title, String body, String payload, BuildContext context) async {

  }

  static AndroidNotificationDetails androidNotificationChannel = AndroidNotificationDetails(
      Config.notificationChannelId,
      Config.notificationChannelId,
      "this_is_the_only_notification_channel_for_platform_android",
      icon: 'hour_glass',
      sound: RawResourceAndroidNotificationSound('nightwatcher'),
      largeIcon: DrawableResourceAndroidBitmap('hour_glass'),
      enableLights: true,
      color: Colors.black,
      ledColor: Colors.black,
      ledOnMs: 1000,
      ledOffMs: 500,
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      ongoing: true,
      styleInformation: DefaultStyleInformation(true, true),
  );

  static var platformChannelSpecifics = NotificationDetails(
      android: androidNotificationChannel
  );

  static void showNotification({@required int id, @required String title, @required String body}) async {
    return await flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        platformChannelSpecifics);
  }

  Future<void> scheduleWorkmanagerPendingNotification(DateTime notificationScheduleDateTime, String task, {Map<String, dynamic> inputData}) async {
    _backgroundService.schedulePendingTask(
        notificationScheduleDateTime,
        task,
        input: inputData
    );
  }

  Future<List<ActiveNotification>> retrieveActiveNotifications() async {
    final List<ActiveNotification> activeNotifications =
        await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.getActiveNotifications();
    return activeNotifications;
  }

  cancelNotification(int id) async {
    _backgroundService.cancelAll();
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}