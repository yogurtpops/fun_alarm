import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_alarm/core/observable/scheduleO.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Consumer<AllScheduleO>(
        builder: (context, _allSchedules, _) {
          return ListView.builder(
              itemBuilder: (context, index) => Container(
                child: Text(_allSchedules.schedules[index].title),
              ),
            itemCount: _allSchedules?.schedules?.length ?? 0,
          );
        }
      )
    );
  }
}