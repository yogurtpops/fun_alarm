import 'package:flutter/material.dart';

class ScheduleO {
  final bool isActive;
  final int id;
  final TimeOfDay timeOfDay;
  final List<int> selectedDays;

  ScheduleO({this.timeOfDay, this.selectedDays, this.isActive, this.id});

  factory ScheduleO.fromMap(Map<String, dynamic> map){

  }

  Map<String, dynamic> toMap(){

  }
}

class AllScheduleO {
  final List<ScheduleO> schedules;

  AllScheduleO(this.schedules);
}