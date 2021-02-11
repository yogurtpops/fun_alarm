import 'dart:async';
import 'dart:isolate';
import 'dart:ui';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:fun_alarm/core/configs/configs.dart';
import 'package:fun_alarm/router/router.dart';

class NotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('hour_glass');
    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    await AndroidAlarmManager.initialize();

    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);
  }

  Future<String> getNotifRouteName() async {
    NotificationAppLaunchDetails launchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if (launchDetails.payload!=null){
      if (launchDetails.payload=='Alarm'){
        return RouteName.ringAlarmPage;
      }
    }

    return null;
  }

  Future<dynamic> onSelectNotification(String name) {
    switch(name){
      case('Alarm'):
        Future.delayed(Duration(milliseconds: 1000), () => navigatorKey.currentState.pushNamed(RouteName.ringAlarmPage));
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
      importance: Importance.max,
      priority: Priority.max,
      ongoing: true,
      icon: 'hour_glass',
      playSound: false,
      largeIcon: DrawableResourceAndroidBitmap('hour_glass'),
      enableLights: true,
      color: Colors.black,
      ledColor: Colors.black,
      ledOnMs: 1000,
      ledOffMs: 500
  );

  static var platformChannelSpecifics = NotificationDetails(
      android: androidNotificationChannel
  );


  void turnOffPersistentAlarmSound() async {
    final SendPort mainToIsolateStream = IsolateNameServer.lookupPortByName('callbackIsolateAndroidAlarmManager');
    mainToIsolateStream.send('turnoff_alarm');
    IsolateNameServer.removePortNameMapping('turnoff_alarm');
  }

  static void showNotification({@required int id, @required String title, @required String body}) async {
    FlutterRingtonePlayer.play(
      android: AndroidSounds.ringtone,
      ios: IosSounds.glass,
      looping: true,
      volume: .2,
      asAlarm: true,
    );

    return await flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        platformChannelSpecifics,
        payload: title
    );
  }

  Future<void> scheduleAndroidAlarmManagerNotification(DateTime notificationScheduleDateTime, String task, {Map<String, dynamic> inputData}) async {
    AndroidAlarmManager.oneShotAt(notificationScheduleDateTime, Config.alarmNotificationId, callbackIsolateAndroidAlarmManager);
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
    await flutterLocalNotificationsPlugin.cancel(id);
  }


}

void callbackAndroidAlarmManager() {
  NotificationService.showNotification(id: Config.alarmNotificationId, title: 'Alarm', body: "Its a fun alarm!");
}

class BackgroundTask {
  static const String alarm_notification = "alarmNotification";
}

void callbackIsolateAndroidAlarmManager() {
  NotificationService.showNotification(id: Config.alarmNotificationId, title: 'Alarm', body: "Its a fun alarm!");

  ReceivePort mainToIsolateStream = ReceivePort();
  IsolateNameServer.registerPortWithName(mainToIsolateStream.sendPort, 'callbackIsolateAndroidAlarmManager');
  mainToIsolateStream.listen((data) {
    if (data=='turnoff_alarm'){
      FlutterRingtonePlayer.stop();
    }
  });
}