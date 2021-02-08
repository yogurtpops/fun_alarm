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
      inputData: input ?? null
    );
  }
}

void callbackDispatcher() {
  Workmanager.executeTask((task, args) {
    switch (task) {
      case BackgroundTask.pending_notification:
        NotificationService.showNotification(id: Config.alarmNotificationId, title: 'Alarm', body: "Its a fun alarm!");
        navigatorKey.currentState.pushNamed(RouteName.ringAlarmPage);
        break;
      case Workmanager.iOSBackgroundTask:
        print("iOS background fetch delegate ran");
        break;
    }

    return Future.value(true);
  });
}


class BackgroundTask {
  static const String pending_notification = "pendingNotification";
}