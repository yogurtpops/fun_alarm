import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fun_alarm/core/configs/configs.dart';
import 'package:fun_alarm/core/observable/scheduleO.dart';
import 'package:fun_alarm/core/view/page/createalarm/create_alarm_page.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  initialize(){
    const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);

    tz.initializeTimeZones();
  }

  Future<dynamic> onSelectNotification(String name) {
    // on tap remove notification
  }

  Future onDidReceiveLocalIosNotification(
      int id, String title, String body, String payload, BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              // await Navigator.push(
              //   context,
              //   MaterialPageRoute(
                  // builder: (context) => SecondScreen(payload),
              //   ),
              // );
            },
          )
        ],
      ),
    );
  }

  Future<void> scheduleNotification(ScheduleO scheduleO) async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      Config.notificationChannelId,
      Config.notificationChannelId,
      "CHANNEL_DESCRIPTION",
      icon: 'secondary_icon',
      sound: RawResourceAndroidNotificationSound('my_sound'),
      largeIcon: DrawableResourceAndroidBitmap('large_notf_icon'),
      enableLights: true,
      color: const Color.fromARGB(255, 255, 0, 0),
      ledColor: const Color.fromARGB(255, 255, 0, 0),
      ledOnMs: 1000,
      ledOffMs: 500,
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidChannelSpecifics
    );

    var scheduleNotificationDateTime = getNearestDateTime(TimeOfDay(hour: scheduleO.hour, minute: scheduleO.minute), scheduleO.selectedDays);

    return await flutterLocalNotificationsPlugin.zonedSchedule(
        scheduleO.id,
        'Alarm',
        "${TimeOfDay(hour: scheduleO.hour, minute: scheduleO.minute)}",
        scheduleNotificationDateTime,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
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

  dispose(){

  }
}