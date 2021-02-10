import 'package:fun_alarm/core/configs/configs.dart';
import 'package:fun_alarm/core/service/notification_service.dart';
import 'package:fun_alarm/router/router.dart';
import 'package:workmanager/workmanager.dart';

class BackgroundService {
  void initialize(){
    Workmanager.initialize(
        callbackDispatcher,
        isInDebugMode: true
    );
  }

  void schedulePendingTask(DateTime dateTime, String task, {Map<String, dynamic> input}){
    var minuteDelay = dateTime.difference(DateTime.now()).inMinutes;
    Workmanager.registerOneOffTask(
      DateTime.now().toString(),
      task,
      initialDelay: Duration(minutes: minuteDelay),
      inputData: input,
      backoffPolicy: BackoffPolicy.linear,
      backoffPolicyDelay: Duration(seconds: 2)
    );
  }

  cancelAll(){
    Workmanager.cancelAll();
  }
}

void callbackDispatcher() {
  Workmanager.executeTask((task, args) {
    switch (task) {
      case BackgroundTask.alarm_notification:
        navigatorKey.currentState.pushNamed(RouteName.ringAlarmPage);
        NotificationService.showNotification(id: Config.alarmNotificationId, title: 'Alarm', body: "Its a fun alarm!");
        break;
      case Workmanager.iOSBackgroundTask:
        print("iOS background fetch delegate ran");
        break;
    }

    return Future.value(true);
  });
}

void callbackAndroidAlarmManager() {
  NotificationService.showNotification(id: Config.alarmNotificationId, title: 'Alarm', body: "Its a fun alarm!");
}


class BackgroundTask {
  static const String alarm_notification = "alarmNotification";
}