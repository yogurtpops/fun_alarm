import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fun_alarm/core/action/schedule_action.dart';
import 'package:fun_alarm/core/observable/scheduleO.dart';
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

  final SlidableController slidableController = SlidableController();

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
            itemBuilder: (context, index) => Slidable(
              key: Key(_allSchedules?.schedules[index]?.id.toString()),
              controller: slidableController,
              fastThreshold: .4,
              movementDuration: Duration(milliseconds: 100),
              showAllActionsThreshold: .4,
              actionExtentRatio: .2,
              dismissal: SlidableDismissal(
                child: SlidableDrawerDismissal(),
                onDismissed: (_) {},
              ),
              actionPane: SlidableStrechActionPane(),
              secondaryActions: [
                Padding(
                  padding: const EdgeInsets.only(right:16.0),
                  child: IconSlideAction(
                    onTap: () {
                      Provider.of<ScheduleAction>(context, listen: false).removeSchedule(_allSchedules?.schedules[index]);
                    },
                    closeOnTap: true,
                    icon: Icons.delete,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                )
              ],
              child: NeumorphicButton(
                onPressed: () => navigatorKey.currentState.push(MaterialPageRoute(builder: (context) => CreateAlarPage(scheduleO: _allSchedules?.schedules[index]))),
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
            ),
            itemCount:
              _allSchedules.schedules?.length ?? 0,
          )
        );
      }
    );
  }
}