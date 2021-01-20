import 'package:fun_alarm/core/observable/scheduleO.dart';
import 'package:fun_alarm/core/service/local_storage_service.dart';
import 'package:fun_alarm/core/store/schedule_store.dart';

class ScheduleAction {
  final ScheduleStore _scheduleStore;

  ScheduleAction(this._scheduleStore);

  addSchedule(ScheduleO scheduleO){
    _scheduleStore.addSchedule(scheduleO);
  }

  editSchedule(ScheduleO updatedScheduleO){
    _scheduleStore.editSchedule(updatedScheduleO);
  }

  removeSchedule(ScheduleO scheduleO){
    _scheduleStore.removeSchedule(scheduleO);
  }
}