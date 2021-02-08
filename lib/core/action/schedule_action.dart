import 'package:flutter/material.dart';
import 'package:fun_alarm/core/configs/configs.dart';
import 'package:fun_alarm/core/observable/scheduleO.dart';
import 'package:fun_alarm/core/service/background_service.dart';
import 'package:fun_alarm/core/service/notification_service.dart';
import 'package:fun_alarm/core/store/schedule_store.dart';
import 'package:fun_alarm/core/view/page/createalarm/create_alarm_page.dart';

class ScheduleAction {
  final ScheduleStore _scheduleStore;
  final NotificationService _notificationService;

  ScheduleAction(this._scheduleStore, this._notificationService);

  Future<void> getSchedules() async {
    return _scheduleStore.getSchedules();
  }

  Future<void> addSchedule(ScheduleO scheduleO) async {
    await _scheduleStore.addSchedule(scheduleO);
    await scheduleNotification();
  }

  Future<void> editSchedule(ScheduleO updatedScheduleO) async {
    await _scheduleStore.editSchedule(updatedScheduleO);
    await scheduleNotification();
  }

  Future<void> removeSchedule(ScheduleO scheduleO) async {
    await _scheduleStore.removeSchedule(scheduleO);
    await scheduleNotification();
  }

  Future<void> scheduleNotification() async {
    var incomingSchedule = await _scheduleStore.getIncomingSchedule();

    if (incomingSchedule != null){
      var incomingDateTime = getNearestDateTime(TimeOfDay(hour: incomingSchedule.hour, minute: incomingSchedule.minute), incomingSchedule.selectedDays);

      await _notificationService.scheduleWorkmanagerPendingNotification(
        incomingDateTime,
        BackgroundTask.alarm_notification,
        inputData: {
          'time' : '${incomingDateTime.hour}:${incomingDateTime.minute}'
        });

    } else {
      await cancelNotification(Config.alarmNotificationId);
    }
  }

  Future<void> cancelNotification(int scheduleid) async {
    await _notificationService.cancelNotification(scheduleid);
  }
}