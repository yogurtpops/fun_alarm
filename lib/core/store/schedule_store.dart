import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fun_alarm/core/observable/scheduleO.dart';
import 'package:fun_alarm/core/service/local_storage_keys.dart';
import 'package:fun_alarm/core/service/local_storage_service.dart';
import 'package:fun_alarm/core/view/page/createalarm/create_alarm_page.dart';
import 'package:rxdart/rxdart.dart';

class ScheduleStore {
  final BehaviorSubject<AllScheduleO> o$;
  final LocalStorageService _localStorageService;
  List<StreamSubscription> _listeners = [];

  void dispose() {
    o$.close();
    _listeners.forEach((element) {
      element.cancel();
    });
  }

  void listen<P>(Subject<P> stream, Function(P) callback) {
    _listeners.add(stream.listen(callback));
  }

  ScheduleStore(this._localStorageService, PublishSubject<LocalStorageUpdate> localStorageUpdate$, this.o$) {
    listen(localStorageUpdate$, (LocalStorageUpdate key) {
      if (key.value == LocalStorageKeys.schedule) {
        _updateObservables();
      }
    });
  }

  Future<ScheduleO> getIncomingSchedule() async {
    final createdSchedules = await _localStorageService.getList(LocalStorageKeys.schedule);
    var incomingSchedule;

    for (final schedule in createdSchedules) {
      var _schedule = ScheduleO.fromMap(jsonDecode(schedule));

      if (_schedule.isActive){
        if (incomingSchedule==null && getNearestDateTime(TimeOfDay(hour: _schedule.hour, minute: _schedule.minute), _schedule.selectedDays)
            .isBefore(DateTime.now().add(Duration(days: 1000)))){
                incomingSchedule = _schedule;
        } else if (incomingSchedule!=null && getNearestDateTime(TimeOfDay(hour: _schedule.hour, minute: _schedule.minute), _schedule.selectedDays)
            .isBefore(getNearestDateTime(TimeOfDay(hour: incomingSchedule.hour, minute: incomingSchedule.minute), incomingSchedule.selectedDays))){
                incomingSchedule = _schedule;
        }
      }
    }

    return incomingSchedule;
  }

  Future<void> _updateObservables() async {
    try {
      final createdSchedules = await _localStorageService.getList(LocalStorageKeys.schedule);

      List<ScheduleO> schedules = [];
      for (final schedule in createdSchedules) {
        schedules.add(ScheduleO.fromMap(jsonDecode(schedule)));
      }

      return o$.add(AllScheduleO(schedules));
    } catch (e) {
      return o$.add(AllScheduleO([]));
    }
  }

  Future<void> removeSchedule(ScheduleO scheduleO) async {
    var createdSchedules =
    await _localStorageService.getList(LocalStorageKeys.schedule);

    createdSchedules.removeWhere((e) => e == scheduleO.toString());

    _localStorageService.saveList(LocalStorageKeys.schedule,
        values: createdSchedules);

    return _updateObservables();
  }

  Future<void> getSchedules() async {
    return _updateObservables();
  }

  Future<void> addSchedule(ScheduleO scheduleO) async {
    var createdSchedules =
        await _localStorageService.getList(LocalStorageKeys.schedule) ??
            [];

    createdSchedules.add(scheduleO.toString());

    _localStorageService.saveList(LocalStorageKeys.schedule,
        values: createdSchedules);

    return _updateObservables();
  }

  Future<void> editSchedule(ScheduleO scheduleO) async {
    var createdSchedules =
        await _localStorageService.getList(LocalStorageKeys.schedule) ??
            [];

    createdSchedules[createdSchedules.indexWhere((element) => scheduleO.id == ScheduleO.fromMap(jsonDecode(element)).id)] = scheduleO.toString();

    _localStorageService.saveList(LocalStorageKeys.schedule,
        values: createdSchedules);

    return _updateObservables();
  }
}

class LocalStorageUpdate {
  final String value;

  LocalStorageUpdate(this.value);
}