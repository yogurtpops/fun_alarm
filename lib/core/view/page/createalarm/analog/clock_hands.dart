import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_alarm/core/view/page/createalarm/analog/clock_ticks.dart';

class ClockHands extends StatefulWidget {
  final TimeOfDay selectedTime;

  const ClockHands({Key key, this.selectedTime}) : super(key: key);

  @override
  _ClockHandState createState() => new _ClockHandState();
}

class _ClockHandState extends State<ClockHands> {
  Timer _timer;
  // DateTime dateTime;

  @override
  void initState() {
    super.initState();
    // dateTime = new DateTime.now();
    // _timer = new Timer.periodic(const Duration(seconds: 1), setTime);
  }

  void setTime(Timer timer) {
    setState(() {
      // dateTime = new DateTime.now();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
        aspectRatio: 1.0,
        child: new Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            child: new Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  new CustomPaint( painter: new HourHandPainter(
                      hours: widget.selectedTime.hour, minutes: widget.selectedTime.minute),
                  ),
                  new CustomPaint(painter: new MinuteHandPainter(
                      minutes: widget.selectedTime.minute, seconds: 0),
                  ),
                ]
            )
        )

    );
  }
}