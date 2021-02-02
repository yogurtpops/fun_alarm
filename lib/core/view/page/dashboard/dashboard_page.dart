import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_alarm/core/observable/scheduleO.dart';
import 'package:fun_alarm/router/router.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AllScheduleO>(
      builder: (context, _allSchedules, _) {
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
          body:  ListView.builder(
            itemBuilder: (context, index) => Container(
              child: Text(
                  _allSchedules?.schedules[index]?.timeOfDay.toString()),
            ),
            itemCount:
              _allSchedules?.schedules?.length ?? 0,
          )
        );
      }
    );
  }
}