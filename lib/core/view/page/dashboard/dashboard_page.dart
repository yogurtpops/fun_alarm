import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_alarm/core/observable/scheduleO.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

// Todo : wrap with Consumer<AllScheduleO>
class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dash"),
      ),
      body:  ListView.builder(
        itemBuilder: (context, index) => Container(
          child: Text(
              // _allSchedules.schedules[index].title ??
                  "Event title"),
        ),
        itemCount:
          // _allSchedules?.schedules?.length ??
              0,
      )
    );
  }
}