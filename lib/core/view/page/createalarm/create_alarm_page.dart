import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fun_alarm/core/action/schedule_action.dart';
import 'package:fun_alarm/core/helper/extensions.dart';
import 'package:fun_alarm/core/observable/scheduleO.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'analog/clock_hands.dart';

class CreateAlarPage extends StatefulWidget {

  final ScheduleO scheduleO;
  bool isEdit;

  CreateAlarPage({Key key, this.scheduleO}) : super(key: key) {
    this.isEdit = scheduleO!=null;
  }

  @override
  State<StatefulWidget> createState() {
    return CreateAlarmPageState();
  }
}

class CreateAlarmPageState extends State<CreateAlarPage> {
  DateTime selectedDatetime = null;
  TimeOfDay selectedTime = TimeOfDay.fromDateTime(DateTime.now());
  bool twelvehformat = true;
  List<int> _daysOption = List();

  @override
  void initState() {
    // setup view for edit
    if (widget.isEdit){
      _daysOption = widget.scheduleO.selectedDays;
      selectedTime = TimeOfDay(hour: widget.scheduleO.hour, minute: widget.scheduleO.minute);
      selectedDatetime = getNearestDateTime(selectedTime, _daysOption);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(widget.isEdit ? "Edit" : "Create"),
        actions: [
          InkWell(
            onTap: (() {
              if (selectedDatetime!=null){
                if (widget.isEdit){
                  Provider.of<ScheduleAction>(context, listen: false).editSchedule(
                      ScheduleO(
                          minute: selectedDatetime.minute,
                          hour: selectedDatetime.hour,
                          id: widget.scheduleO.id,
                          isActive: true,
                          selectedDays: _daysOption
                      ));
                } else {
                  Provider.of<ScheduleAction>(context, listen: false).addSchedule(
                      ScheduleO(
                          minute: selectedDatetime.minute,
                          hour: selectedDatetime.hour,
                          id: DateTime.now().millisecondsSinceEpoch,
                          isActive: true,
                          selectedDays: _daysOption
                      ));
                }
                Navigator.of(context).pop();
              } else {
                Fluttertoast.showToast(
                    msg: "Choose day for this schedule",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey,
                    textColor: Colors.black,
                    fontSize: 16.0
                );
              }
            }),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Save".toUpperCase()),
            ),
          )
        ],
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          Container(
            height: 32,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Neumorphic(
                style: NeumorphicStyle(
                  intensity: 12,
                  depth: -12,
                  shape: NeumorphicShape.flat,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
                ),
                child: Container(
                  height: 66,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DayButton(
                      isToday: DateTime.now().weekday==DateTime.monday,
                      isSelected: _daysOption.contains(DateTime.monday),
                      label: "M", onTap: (selected) => setState(() {
                    selected ? _daysOption.add(DateTime.monday) : _daysOption.remove(DateTime.monday);
                    selectedDatetime = getNearestDateTime(selectedTime, _daysOption);
                  })),
                  DayButton(
                      isToday: DateTime.now().weekday==DateTime.tuesday,
                      isSelected: _daysOption.contains(DateTime.tuesday),
                      label: "T", onTap: (selected) => setState(() {
                    selected ? _daysOption.add(DateTime.tuesday) : _daysOption.remove(DateTime.tuesday);
                    selectedDatetime = getNearestDateTime(selectedTime, _daysOption);
                  })),
                  DayButton(
                      isToday: DateTime.now().weekday==DateTime.wednesday,
                      isSelected: _daysOption.contains(DateTime.wednesday),
                      label: "W", onTap: (selected) => setState(() {
                    selected ? _daysOption.add(DateTime.wednesday) : _daysOption.remove(DateTime.wednesday);
                    selectedDatetime = getNearestDateTime(selectedTime, _daysOption);
                  })),
                  DayButton(
                      isToday: DateTime.now().weekday==DateTime.thursday,
                      isSelected: _daysOption.contains(DateTime.thursday),
                      label: "T", onTap: (selected) => setState(() {
                    selected ? _daysOption.add(DateTime.thursday) : _daysOption.remove(DateTime.thursday);
                    if (selectedDatetime.weekday==DateTime.thursday){
                      selectedDatetime = getNearestDateTime(selectedTime, _daysOption);
                    }
                  })),
                  DayButton(
                      isToday: DateTime.now().weekday==DateTime.friday,
                      isSelected: _daysOption.contains(DateTime.friday),
                      label: "F", onTap: (selected) => setState(() {
                    selected ? _daysOption.add(DateTime.friday) : _daysOption.remove(DateTime.friday);
                    selectedDatetime = getNearestDateTime(selectedTime, _daysOption);
                  })),
                  DayButton(
                      isToday: DateTime.now().weekday==DateTime.saturday,
                      isSelected: _daysOption.contains(DateTime.saturday),
                      label: "S", onTap: (selected) => setState(() {
                    selected ? _daysOption.add(DateTime.saturday) : _daysOption.remove(DateTime.saturday);
                    selectedDatetime = getNearestDateTime(selectedTime, _daysOption);
                  })),
                  DayButton(
                      isToday: DateTime.now().weekday==DateTime.sunday,
                      isSelected: _daysOption.contains(DateTime.sunday),
                      label: "S", onTap: (selected) => setState(() {
                    selected ? _daysOption.add(DateTime.sunday) : _daysOption.remove(DateTime.sunday);
                    selectedDatetime = getNearestDateTime(selectedTime, _daysOption);
                  })),
                ],
              ),
            ),
          ],),
          Container(
            height: 32,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Neumorphic(
                  style: NeumorphicStyle(
                    surfaceIntensity: .8,
                    intensity: .5,
                    depth: -5,
                    shape: NeumorphicShape.flat,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShape: NeumorphicBoxShape.circle(),
                  ),
                  child: Container(
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 150,
                  height: 150,
                  child: NeumorphicButton(
                    onPressed: () => showTimePicker(
                      initialTime: selectedTime,
                      context: context,
                    ).then((selectedTime) {
                      setState(() {
                        this.selectedTime = selectedTime;
                        if (selectedDatetime == null || selectedTime.compareTo(TimeOfDay.fromDateTime(selectedDatetime))!=0){
                          selectedDatetime = getNearestDateTime(selectedTime, _daysOption);
                        }
                      });
                    }),
                    drawSurfaceAboveChild: false,
                    style: NeumorphicStyle(
                      intensity: .5,
                      depth: 5,
                      shape: NeumorphicShape.flat,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShape: NeumorphicBoxShape.circle(),
                    ),
                    child: Center(
                      child: ClockHands(selectedTime: selectedTime),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 32,
          ),
          // selectedDatetime != null ?
          AnimatedOpacity(
            duration: Duration(microseconds: 1000),
            opacity: selectedDatetime!=null ? 1 : 0,
            child: Column(
              children: [
                selectedDatetime!=null ? Padding(
                  padding: const EdgeInsets.only(top:8.0, bottom: 16),
                  child: Text(DateFormat('EEEE, d MMMM yyyy').format(selectedDatetime)),
                ) : Container(),
                NeumorphicText(
                    twelvehformat ? selectedTime.format(context) : selectedTime.format(context) ,
                    textStyle: NeumorphicTextStyle(
                        fontSize: 32, letterSpacing: 2, fontWeight: FontWeight.bold )),
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Text('Indonesia'),
                ),
                Container(
                  height: 32,
                ),
                NeumorphicSwitch(
                  value: twelvehformat,
                  onChanged: (val) => setState((){ twelvehformat = val;}) ,
                )
              ],
            ),
          ) //: Container()
        ],
      ),
    );
  }

}

DateTime getNearestDateTime(TimeOfDay time, List<int> _daysOption){
  final DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, time.hour, time.minute);
  var nearestDate = today.add(Duration(days: 1000));

  if (_daysOption.isEmpty){
    return null;
  }

  for (int selectedDays in _daysOption){
    int difference = selectedDays-DateTime.now().weekday;
    print('diff is $difference');

    if (difference == 0){
      if (time.compareTo(TimeOfDay.fromDateTime(DateTime.now())) == 1)
        nearestDate = today;
      else if (today.add(Duration(days: 7)).isBefore(nearestDate))
        nearestDate = today.add(Duration(days: 7));
    }
    else if (difference < 0){
      if (today.add(Duration(days: difference+7)).isBefore(nearestDate)){
        nearestDate = today.add(Duration(days: difference+7));
      }
    }
    else {
      if (today.add(Duration(days: difference)).isBefore(nearestDate)){
        nearestDate = today.add(Duration(days: difference));
      }
    }
  }

  return nearestDate;
}

class DayButtonState extends State<DayButton> {
  bool selected;

  @override
  void initState() {
    selected = widget.isSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: (){
        setState(() => selected=!selected);
        widget.onTap(selected);
      },
      style: NeumorphicStyle(
        intensity: 15,
        depth: selected ? -8 : 4,
        color:  Theme.of(context).scaffoldBackgroundColor,
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.circle(),
      ),
      child: Container(
          child: Center(child:
            Text(widget.label, style:
              TextStyle(
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  color: widget.isToday ? Theme.of(context).highlightColor : Theme.of(context).buttonColor
              ),))),
    );
  }
}

class DayButton extends StatefulWidget {
  final bool isToday;
  final String label;
  final Function(bool selected) onTap;
  final bool isSelected;

  const DayButton({Key key, this.label, this.onTap, this.isToday, this.isSelected:false}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DayButtonState();
  }
}