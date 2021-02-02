import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fun_alarm/core/action/schedule_action.dart';
import 'package:fun_alarm/core/observable/scheduleO.dart';
import 'package:fun_alarm/router/router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'analog/clock_hands.dart';

class CreateAlarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateAlarmPageState();
  }
}

class CreateAlarmPageState extends State<CreateAlarPage> {
  DateTime selectedDatetime = null;
  TimeOfDay selectedTime;
  bool twelvehformat = true;
  List<int> _daysOption = List();

  @override
  void initState() {
    selectedTime = TimeOfDay.fromDateTime(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text("Create"),
        actions: [
          InkWell(
            onTap: () {
              Provider.of<ScheduleAction>(context).addSchedule(
                  ScheduleO(
                    timeOfDay: TimeOfDay.fromDateTime(selectedDatetime),
                    id: DateTime.now().millisecondsSinceEpoch,
                    isActive: true,
                    selectedDays: _daysOption
                  ));
              Navigator.of(context).pushNamed(RouteName.ringAlarmPage);
            },
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
                  intensity: .5,
                  depth: -5,
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
                  DayButton(label: "M", onTap: (selected) => setState(() {
                    selected ? _daysOption.add(DateTime.monday) : _daysOption.remove(DateTime.monday);
                    selectedDatetime = getNearestDateTime(selectedTime);
                  })),
                  DayButton(label: "T", onTap: (selected) => setState(() {
                    selected ? _daysOption.add(DateTime.tuesday) : _daysOption.remove(DateTime.tuesday);
                    selectedDatetime = getNearestDateTime(selectedTime);
                  })),
                  DayButton(label: "W", onTap: (selected) => setState(() {
                    selected ? _daysOption.add(DateTime.wednesday) : _daysOption.remove(DateTime.wednesday);
                    selectedDatetime = getNearestDateTime(selectedTime);
                  })),
                  DayButton(label: "T", onTap: (selected) => setState(() {
                    selected ? _daysOption.add(DateTime.thursday) : _daysOption.remove(DateTime.thursday);
                    if (selectedDatetime.weekday==DateTime.thursday){
                      selectedDatetime = getNearestDateTime(selectedTime);
                    }
                  })),
                  DayButton(label: "F", onTap: (selected) => setState(() {
                    selected ? _daysOption.add(DateTime.friday) : _daysOption.remove(DateTime.friday);
                    selectedDatetime = getNearestDateTime(selectedTime);
                  })),
                  DayButton(label: "S", onTap: (selected) => setState(() {
                    selected ? _daysOption.add(DateTime.saturday) : _daysOption.remove(DateTime.saturday);
                    selectedDatetime = getNearestDateTime(selectedTime);
                  })),
                  DayButton(label: "S", onTap: (selected) => setState(() {
                    selected ? _daysOption.add(DateTime.sunday) : _daysOption.remove(DateTime.sunday);
                    selectedDatetime = getNearestDateTime(selectedTime);
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
                        if (selectedDatetime == null || compareTimeOfDay(selectedTime, TimeOfDay.fromDateTime(selectedDatetime))!=0){
                          selectedDatetime = getNearestDateTime(selectedTime);
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
          selectedDatetime != null ?
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:8.0, bottom: 16),
                child: Text(DateFormat('EEEE, d MMMM yyyy').format(selectedDatetime)),
              ),
              NeumorphicText(twelvehformat ? DateFormat('HH : mm').format(selectedDatetime) : DateFormat('HH : mm a').format(selectedDatetime),
                  textStyle: NeumorphicTextStyle(fontSize: 32, letterSpacing: 2, fontWeight: FontWeight.bold )),
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
          ) : Container()

        ],
      ),
    );
  }

  DateTime getNearestDateTime(TimeOfDay time){
    final DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, time.hour, time.minute);
    var nearestDate = today.add(Duration(days: 1000));

    if (_daysOption.isEmpty){
      return null;
    }

    for (int selectedDays in _daysOption){
      int difference = selectedDays-DateTime.now().weekday;
      print('diff is $difference');

      if (difference == 0){
        if (compareTimeOfDay(time, TimeOfDay.fromDateTime(DateTime.now())) == 1)
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

  compareTimeOfDay(TimeOfDay first, TimeOfDay second){
    if (first.hour > second.hour)
      return 1;
    else if (first.hour < second.hour)
      return 2;
    else
      if (first.minute > second.minute)
        return 1;
      else if (first.minute < second.minute)
        return 2;
      else
        return 0;
  }
}

class DayButtonState extends State<DayButton> {
  bool selected;

  @override
  void initState() {
    selected = false;
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
        surfaceIntensity: .8,
        color: selected ? Colors.red[200] : Theme.of(context).scaffoldBackgroundColor,
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.circle(),
      ),
      child: Container(
          child: Center(child: Text(widget.label))),
    );
  }
}

class DayButton extends StatefulWidget {
  final String label;
  final Function(bool selected) onTap;

  const DayButton({Key key, this.label, this.onTap}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DayButtonState();
  }
}