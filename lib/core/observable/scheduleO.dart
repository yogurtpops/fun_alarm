import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fun_alarm/core/helper/extensions.dart';

class ScheduleO {
  final bool isActive;
  final int id;
  final int minute;
  final int hour;
  final List<int> selectedDays;

  ScheduleO({@required this.minute, @required this.hour, @required this.selectedDays, @required this.isActive, @required this.id});

  factory ScheduleO.fromMap(Map<String, dynamic> map){
    return ScheduleO(
        hour: map['hour'],
        minute: map['minute'],
        id: map['id'],
        isActive: BoolExtension.fromString(map['isActive']),
        selectedDays: map['selectedDays'].cast<int>()
    );
  }

  ScheduleO copyWith({int minute, int hour, List<int> selectedDays, bool isActive}){
    return ScheduleO(
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        id:this.id,
        isActive: isActive ?? this.isActive,
        selectedDays: selectedDays ?? this.selectedDays
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'isActive': this.isActive.toString(),
      'id': this.id,
      'minute': this.minute,
      'hour': this.hour,
      'selectedDays': this.selectedDays,
    } as Map<String, dynamic>;
  }



  @override
  String toString() {
    return jsonEncode(this.toMap());
  }
}

class AllScheduleO {
  final List<ScheduleO> schedules;

  AllScheduleO(this.schedules);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AllScheduleO &&
              runtimeType == other.runtimeType &&
              schedules == other.schedules;

  @override
  int get hashCode => schedules.hashCode;
}