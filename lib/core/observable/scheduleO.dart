class ScheduleO {
  final String title;
  final DateTime scheduleTime;
  final String alarmType;
  final bool isActive;
  final int id;

  ScheduleO(this.title, this.scheduleTime, this.alarmType, this.isActive, this.id);

  factory ScheduleO.fromMap(Map<String, dynamic> map){

  }

  Map<String, dynamic> toMap(){

  }
}

class AllScheduleO {
  final List<ScheduleO> schedules;

  AllScheduleO(this.schedules);
}