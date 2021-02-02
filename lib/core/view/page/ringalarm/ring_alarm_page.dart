import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fun_alarm/core/view/page/ringalarm/rive_animation.dart';

class RingAlarmPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RingAlarmPageState();
  }
}

class RingAlarmPageState extends State<RingAlarmPage> {
  GlobalKey<MyRiveAnimationState> alarmAnimationKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(alarmAnimationKey?.currentState?.startLoop('ringing'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        margin: EdgeInsets.all(32),
        child: SvgPicture.asset("svg/hourglass.svg"),
      ),
    );
  }

}