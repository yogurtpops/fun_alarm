import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_alarm/router/router.dart';

class CreateAlarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateAlarmPageState();
  }
}

class CreateAlarmPageState extends State<CreateAlarPage> {
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
            onTap: () => Navigator.of(context).pushNamed(RouteName.ringAlarmPage),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Save".toUpperCase()),
            ),
          )
        ],
        automaticallyImplyLeading: true,
      ),
    );
  }
}