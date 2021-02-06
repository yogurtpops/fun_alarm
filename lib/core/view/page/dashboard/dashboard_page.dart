import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fun_alarm/core/action/schedule_action.dart';
import 'package:fun_alarm/core/observable/scheduleO.dart';
import 'package:fun_alarm/core/store/schedule_store.dart';
import 'package:fun_alarm/core/view/page/createalarm/create_alarm_page.dart';
import 'package:fun_alarm/router/router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
      Provider.of<ScheduleAction>(context, listen: false).getSchedules());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AllScheduleO>(
      builder: (context, _allSchedules, _) {
        print('schedules... ${_allSchedules?.schedules?.length}');

        return Scaffold(
          appBar: AppBar(
            title: Text("Dash"),
            actions: [
              InkWell(
                onTap: () => Navigator.of(context).pushNamed(RouteName.createAlarmPage),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.add),
                ),
              )
            ],
          ),
          body:  _allSchedules==null ? Container() : ListView.builder(
            itemBuilder: (context, index) => NeumorphicButton(
              onPressed: () => navigatorKey.currentState.pushNamed(RouteName.ringAlarmPage),
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: EdgeInsets.all(24),
              style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(32))
              ),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${ _allSchedules.schedules[index]?.hour}:${ _allSchedules.schedules[index]?.minute}",
                      style: TextStyle(fontSize: 28, letterSpacing: 2, fontWeight: FontWeight.w400),
                    ),
                    Row(
                      children: [
                        Text(DateFormat('EEE, d MMM').format(getNearestDateTime(
                            TimeOfDay(hour: _allSchedules.schedules[index]?.hour, minute: _allSchedules.schedules[index]?.minute),
                            _allSchedules.schedules[index]?.selectedDays
                        ))),
                        Container(
                          margin: EdgeInsets.only(left: 16),
                            width: 54,
                            height: 28,
                            child: NeumorphicSwitch(value: _allSchedules.schedules[index]?.isActive, onChanged: (val){
                              Provider.of<ScheduleAction>(context, listen: false).editSchedule(_allSchedules.schedules[index]?.copyWith(isActive: val));
                            }))
                      ],
                    )
                  ],
                ),
              ),
            ),
            itemCount:
              _allSchedules.schedules?.length ?? 0,
          )
        );
      }
    );
  }
}